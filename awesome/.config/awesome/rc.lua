pcall(require, "luarocks.loader")

require("awful.autofocus")
local naughty = require("naughty")
local beautiful = require("beautiful")
local gears = require("gears")
local awful = require("awful")
local helpers = require("helpers")
-- require("awful.hotkeys_popup.keys")

-- {{{ Error handling
if awesome.startup_errors then
	naughty.notify({
		preset = naughty.config.presets.critical,
		title = "Oops, there were errors during startup!",
		text = awesome.startup_errors,
	})
end

do
	local in_error = false
	awesome.connect_signal("debug::error", function(err)
		if in_error then
			return
		end
		in_error = true

		naughty.notify({
			preset = naughty.config.presets.critical,
			title = "Oops, an error happened!",
			text = tostring(err),
		})
		in_error = false
	end)
end
-- }}}

awful.spawn.with_shell("~/.autostart.sh")
awful.spawn.with_shell("~/.fehbg")
awful.spawn.with_shell("/usr/lib/policykit-1-gnome/polkit-gnome-authentication-agent-1")

helpers.check_if_running("caffeine-indicator", nil, function()
	awful.spawn("caffeine-indicator", false)
end)

-- helpers.check_if_running("picom", nil, function()
-- 	awful.spawn("picom --config " .. gears.filesystem.get_configuration_dir() .. "config/picom.conf", false)
-- end)

beautiful.init(gears.filesystem.get_configuration_dir() .. "config/theme.lua")
require("config.layout")
require("config.wibar")
require("config.keys")
require("config.rules")
require("config.signals")
require("ui")
-- require("lockscreen.lockscreen")
