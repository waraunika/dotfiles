-- https://github.com/rmagatti/auto-session

return {
	"rmagatti/auto-session",
	lazy = false,
	priority = 1000, -- load before the dashboard needs to query session list

	--- enables autocomplete for opts
	--- @module "auto-session"
	--- @type AutoSession.Config
	opts = {
		enabled = true,
		auto_save = true,
		auto_restore = false,
		auto_create = true,
		cwd_change_handling = true,
		log_level = "error",
		auto_session_enable_last_session = false,
		suppress_dirs = { "~/", "~/Downloads", "/", "~/tmp/", "~/temp/" },
		session_lens = {
			load_on_setup = false, -- we build our own picker on the dashboard
		},
	},
}
