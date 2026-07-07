local movefocus = function ()
	hl.dsp.focus({ direction = "left" })
end

hl.gesture({
	fingers = 3,
	direction = "vertical",
	action = "workspace",
})

hl.gesture({
	fingers = 3,
	direction = "left",
	action = function ()
		-- hl.notification.create({"hi", 200})qqqq
		hl.dsp.focus({ direction = "left" })
	end
})

hl.config({
  input = {
		follow_mouse = 1,

		sensitivity = 0, -- -1.0 - 1.0, 0 means no modification.

    touchpad = {
			natural_scroll = true,
		},
  }
})

hl.device({
	name = "epic-mouse-v1",
	sensitivity = -0.5,
})