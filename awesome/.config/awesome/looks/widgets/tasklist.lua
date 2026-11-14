-- widget: tasklist

local gears = require("gears")
local awful = require("awful")
local wibox = require("wibox")
local vars = require("variables")
local beautiful = require("beautiful")

local cfg = vars.bar
local opt = cfg.tasklist

local buttons = gears.table.join(
	awful.button({}, 1, function(c)
		if c == client.focus then
			c.minimized = true
		else
			c:emit_signal("request::activate", "tasklist", { raise = true })
		end
	end),

	awful.button({}, 2, function(c)
		c:kill()
	end),

	awful.button({}, 3, function()
		awful.menu.client_list({ theme = { width = 250 } })
	end),

	awful.button({}, 4, function()
		awful.client.focus.byidx(-1)
	end),

	awful.button({}, 5, function()
		awful.client.focus.byidx(1)
	end)
)

local function truncate(s, n)
	if utf8 and utf8.len(s) then
		local cut = utf8.offset(s, n + 1)
		if cut then
			return s:sub(1, cut - 1) .. "…"
		end
		return s
	end

	return #s > n and (s:sub(1, n) .. "…") or s
end

local home = os.getenv("HOME")

local function readfile(path)
	local f = io.open(path, "rb")
	if not f then
		return nil
	end
	local d = f:read("*a")
	f:close()
	return d
end

--- foreground command of a terminal window's shell or nil at no prompt
local function foreground_cmd(pid)
	local kids = readfile("/proc/" .. pid .. "/task/" .. pid .. "/children")
	if not kids then
		return nil
	end
	for shell in kids:gmatch("%d+") do
		local stat = readfile("/proc/" .. shell .. "/stat")
		local rest = stat and stat:match("%)%s+(.*)$") -- skip "pid (comm)"
		if rest then
			local f = {}
			for n in rest:gmatch("%S+") do
				f[#f + 1] = n
			end
			-- f: 1 state, 2 ppid, 3 pgrp, 4 session, 5 tty_nr, 6 tpgid
			if f[5] and f[5] ~= "0" then -- the child that owns the tty is the shell
				if f[6] and f[6] ~= "-1" and f[6] ~= f[3] then
					local cmd = readfile("/proc/" .. f[6] .. "/cmdline")
					if cmd and cmd ~= "" then
						cmd = cmd:gsub("\0", " "):gsub("%s+$", "")
						if home then
							cmd = cmd:gsub(gears.string.quote_pattern(home), "~")
						end
						return cmd
					end
				end
				return nil
			end
		end
	end
end

local function display_title(c)
	if opt.terminals[c.class] and c.pid then
		return foreground_cmd(c.pid) or c.name or ""
	end
	return c.name or ""
end

-- Starting nvim from the prompt doesn't change the window title, so Awesome
-- wouldn't redraw. Nudge terminal clients every 2s; the tasklist re-reads then.
gears.timer({
	timeout = 2,
	autostart = true,
	callback = function()
		for _, c in ipairs(client.get()) do
			if opt.terminals[c.class] then
				c:emit_signal("property::name")
			end
		end
	end,
})

local function update_item(self, c)
	local tb = self:get_children_by_id("title")[1]
	if tb then
		local fg = c == client.focus and beautiful.tasklist_fg_focus
			or c.minimized and beautiful.tasklist_fg_minimize
			or beautiful.tasklist_fg_normal
		tb:set_markup(
			string.format(
				'<span foreground="%s">%s</span>',
				fg,
				gears.string.xml_escape(truncate(display_title(c), opt.chars))
			)
		)
	end
	local ic = self:get_children_by_id("clienticon")[1]
	if ic then
		ic.client = c
	end
end

return function(s)
	return awful.widget.tasklist({
		screen = s,
		filter = awful.widget.tasklist.filter[opt.filter] or awful.widget.tasklist.filter.currenttags,
		buttons = buttons,
		-- highest index first = top of column
		-- so w're reversing theme, me likey at bottom
		source = function()
			local all, list = client.get(s), {}
			for i = #all, 1, -1 do
				list[#list + 1] = all[i]
			end
			return list
		end,
		layout = { spacing = 4, layout = wibox.layout.fixed.vertical },
		widget_template = {
			{
				{
					{
						{
							{
								id = "title",
								align = "center",
								valign = "center",
								font = cfg.font .. " " .. opt.font_size,
								widget = wibox.widget.textbox,
							},
							direction = opt.direction,
							widget = wibox.container.rotate,
						},
						{
							{
								id = "clienticon",
								forced_width = opt.icon_size,
								forced_height = opt.icon_size,
								widget = awful.widget.clienticon,
							},
							halign = "center",
							widget = wibox.container.place,
						},
						spacing = opt.gap,
						layout = wibox.layout.fixed.vertical,
					},
					top = opt.pad,
					bottom = opt.pad,
					widget = wibox.container.margin,
				},
				id = "background_role",
				widget = wibox.container.background,
				forced_width = cfg.width - 2 * cfg.padding,
			},
			widget = wibox.container.place,
			create_callback = update_item,
			update_callback = update_item,
		},
	})
end
