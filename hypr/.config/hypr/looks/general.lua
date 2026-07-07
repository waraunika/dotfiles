local colors = require("colors")

hl.config({
  general = {
    gaps_in = 2,
    gaps_out = 0,

    border_size = 1,

    col = {
      active_border = colors.outline,
      inactive_border = colors.on_secondary,
    },

    -- Set to true to enable resizing windows by clicking and dragging on borders and gaps
    resize_on_border = false,

    -- Please see https://wiki.hypr.land/Configuring/Advanced-and-Cool/Tearing/ before you turn this on
    allow_tearing = false,
  },
})
