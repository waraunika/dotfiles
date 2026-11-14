pcall(require, "luarocks.loader")
require("awful.autofocus")
local gears = require("gears")
local awful = require("awful")

package.loaded["naughty.dbus"] = {}

require("environment.errors")

require("variables")

require("looks.theme")
require("environment.env")
require("layout.layouts")
require("menu.menu")
require("io.keyboard")

require("layout.tags")
require("looks.wibar")

require("binds.application")
require("binds.awesome")
require("binds.layout")
require("binds.mouse")
require("binds.scripts")
require("binds.window")
require("binds.tools")

-- Set keys
root.keys(globalkeys)

require("environment.window-rules")
require("signals")
require("looks.borders")

awful.spawn.with_shell(gears.filesystem.get_configuration_dir() .. "autostart.sh")
