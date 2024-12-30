local gears = require("gears")
local awful = require("awful")
local hotkeys_popup = require("awful.hotkeys_popup")
local lain = require("lain")

local constants = require("constants")
local mods = constants.mods
local terminal = constants.terminal
local apps = require("lockscreen.apps")
-- local pomodoro = require("awmodoro.config")

local utils = require("utils")
local bind = utils.misc.bind

local flt_terminal = lain.util.quake({
	app = terminal,
	argname = "--name %s",
	vert = "center",
	horiz = "center",
	width = 0.7,
	height = 0.7,
})

local GLOBAL_GROUPS = {
	awesome = {
		[mods.m] = {
			[""] = {
				{ key = "s", action = hotkeys_popup.show_help, description = "show help" },
				-- { key = "l", action = awful.spawn(apps.default.lock, false), description = "lock screen" }, TODO: Fix locksreen
			},
			[mods.c] = {
				{ key = "r", action = awesome.restart, description = "reload awesome" },
				{ key = "q", action = awesome.quit,    description = "quit awesome" },
			},
		},
	},
	client = {
		[mods.a] = {
			[""] = {
				{ key = "j", action = bind(awful.client.focus.byidx, { 1 }),  description = "focus next index" },
				{ key = "k", action = bind(awful.client.focus.byidx, { -1 }), description = "focus previous index" },
				{ key = "u", action = awful.client.urgent.jumpto,             description = "jump to urgent client" },
				{
					key = "Tab",
					action = function()
						awful.client.focus.history.previous()
						if client.focus then
							client.focus:raise()
						end
					end,
					description = "go back",
				},
			},
			[mods.s] = {
				{ key = "j", action = bind(awful.client.swap.byidx, { 1 }),  description = "swap next client" },
				{ key = "k", action = bind(awful.client.swap.byidx, { -1 }), description = "swap previous client" },
			},
		},
	},
	launcher = {
		[mods.m] = {
			[""] = {
				{
					key = "z",
					action = function()
						flt_terminal:toggle()
					end,
					description = "open floating terminal",
				},
				{
					key = "w",
					action = bind(awful.spawn, { "rofi -show window -window-thumbnail" }),
					description = "open window switcher",
				},
				{
					key = "Return",
					action = bind(awful.spawn, { terminal }),
					description = "open terminal",
				},
				{
					key = "r",
					action = bind(awful.spawn, { "rofi -show drun -show-icons" }),
					description = "open apps",
				},
				{
					key = "e",
					action = bind(awful.spawn, { "x-terminal-emulator -e lf" }),
					description = "open file manager",
				},
				{
					key = "c",
					action = bind(awful.spawn, { "codium" }),
					description = "open codium",
				},
			},
		},
		[mods.a] = {
			[""] = {
				{
					key = "space",
					action = bind(awful.spawn, { "launcher_t1" }),
					description = "open apps",
				},
				{
					key = "q",
					action = bind(awful.spawn, { "applet -r quicklinks" }),
					description = "open quicklinks",
				},
				{
					key = "f",
					action = bind(awful.spawn, { "applet -r web" }),
					description = "open websearch",
				},
				{
					key = "n",
					action = bind(awful.spawn, { "applet -r player" }),
					description = "open player controls",
				},
				{
					key = "e",
					action = bind(awful.spawn, { "kitty -e nvim" }),
					description = "open nvim",
				},
				-- { TODO: Add pomodoro timer
				-- 	key = "p",
				-- 	action = pomodoro:toggle(),
				-- 	description = "pomodoro timer",
				-- },
				-- {
				-- 	key = "s",
				-- 	action = pomodoro:finish(),
				-- 	description = "pomodoro timer",
				-- },
			},
		},
		[mods.c] = {
			[""] = {
				{
					key = "space",
					action = bind(awful.spawn, { "applet -r powermenu" }),
					description = "open powermenu",
				},
			},
		},
	},
	browser = {
		[mods.m] = {
			[""] = {
				{
					key = "f",
					action = bind(awful.spawn, { "flatpak run io.github.zen_browser.zen" }),
					description = "open zen browser",
				},
				{
					key = "g",
					action = bind(awful.spawn, { "firefox-esr" }),
					description = "open firefox",
				},
			},
			[mods.s] = {
				{
					key = "f",
					action = bind(awful.spawn, { "flatpak run io.github.zen_browser.zen --private-window" }),
					description = "open zen browser with private window",
				},
				{
					key = "g",
					action = bind(awful.spawn, { "firefox-esr --private-window" }),
					description = "open firefox with private window",
				},
			},
		},
	},
	tag = {
		[mods.a] = {
			[""] = {
				{ key = "h", action = awful.tag.viewprev, description = "view previous" },
				{ key = "l", action = awful.tag.viewnext, description = "view next" },
			},
		},
	},
	screen = {
		[mods.m] = {
			["c"] = {
				{
					key = "j",
					action = bind(awful.screen.focus_relative, { 1 }),
					description = "focus the next screen",
				},
				{
					key = "k",
					action = bind(awful.screen.focus_relative, { -1 }),
					description = "focus the previous screen",
				},
			},
		},
	},
	layout = {
		[mods.m] = {
			[""] = {
				{
					key = "l",
					action = bind(awful.tag.incmwfact, { 0.05 }),
					description = "increase master width factor",
				},
				{
					key = "h",
					action = bind(awful.tag.incmwfact, { -0.05 }),
					description = "decrease master width factor",
				},
				{ key = "space", action = bind(awful.layout.inc, { 1 }), description = "select next" },
			},
			[mods.a] = {
				{ key = "space", action = bind(awful.layout.inc, { -1 }), description = "select previous" },
			},
			[mods.s] = {
				{
					key = "s",
					action = function()
						local myscreen = awful.screen.focused()
						myscreen.mywibox.visible = not myscreen.mywibox.visible
					end,
					description = "toggle statusbar",
				},
			},
		},

		[mods.s] = {
			{
				key = "h",
				action = bind(awful.tag.incnmaster, { 1, nil, true }),
				description = "increase the number of master clients",
			},
			{
				key = "l",
				action = bind(awful.tag.incnmaster, { -1, nil, true }),
				description = "decrease the number of master clients",
			},
			{ key = "space", action = bind(awful.layout.inc, { -1 }), description = "select previous" },
		},
		[mods.c] = {
			{
				key = "h",
				action = bind(awful.tag.incncol, { 1, nil, true }),
				description = "increase the number of columns",
			},
			{
				key = "l",
				action = bind(awful.tag.incncol, { -1, nil, true }),
				description = "decrease the number of columns",
			},
		},
	},
	others = {
		[mods.m] = {
			[""] = {
				{ key = "i", action = utils.ibus.toggle, description = "switch input engine" },
			},
			[mods.s] = {
				{
					key = "l",
					action = bind(awful.spawn, { "betterlockscreen --blur 0.7 --lock blur" }),
					description = "Lock the screen",
				},
			},
		},
		[""] = {
			[""] = {
				{
					key = "XF86AudioRaiseVolume",
					action = utils.volume.increase,
					description = "increase volume",
				},
				{
					key = "XF86AudioLowerVolume",
					action = utils.volume.decrease,
					description = "decrease volume",
				},
				{
					key = "XF86AudioMute",
					action = utils.volume.toggle,
					description = "toggle mute",
				},
				{
					key = "Print",
					action = bind(awful.spawn, { "flameshot gui" }),
					description = "take screenshot",
				},
				{
					key = "XF86MonBrightnessUp",
					action = bind(awful.spawn, { "light -A 5" }),
					description = "increase brightness",
				},
				{
					key = "XF86MonBrightnessDown",
					action = bind(awful.spawn, { "light -U 5" }),
					description = "decrease brightness",
				},
				-- playerctl controls
				{
					key = "XF86AudioPlay",
					action = bind(awful.spawn, { "playerctl play-pause" }),
					description = "player toggle",
				},
				{
					key = "XF86AudioPrev",
					action = bind(awful.spawn, { "playerctl previous" }),
					description = "player previous",
				},
				{
					key = "XF86AudioNext",
					action = bind(awful.spawn, { "playerctl next" }),
					description = "player next",
				},
				{
					key = "XF86AudioStop",
					action = bind(awful.spawn, { "playerctl stop" }),
					description = "player stop",
				},
			},
		},
	},
}

local CLIENT_GROUPS = {
	client = {
		[mods.m] = {
			[""] = {
				{
					key = "q",
					action = function(c)
						c:kill()
					end,
					description = "close",
				},
				{
					key = "o",
					action = function(c)
						c:move_to_screen()
					end,
					description = "move to screen",
				},
				{
					key = "t",
					action = function(c)
						c.ontop = not c.ontop
					end,
					description = "toggle keep on top",
				},
				{
					key = "m",
					action = function(c)
						c.maximized = not c.maximized
						c:raise()
					end,
					description = "toggle maximize",
				},
			},
			[mods.s] = {
				{ key = "space", action = awful.client.floating.toggle, description = "toggle floating" },
				{
					key = "m",
					action = function(c)
						c.maximized_vertical = not c.maximized_horizontal
						c:raise()
					end,
					description = "toggle maximize horizontally",
				},
			},
			[mods.c] = {
				{
					key = "Return",
					action = function(c)
						c:swap(awful.client.getmaster())
					end,
					description = "move to master",
				},
				{
					key = "m",
					action = function(c)
						c.maximized_vertical = not c.maximized_vertical
						c:raise()
					end,
					description = "toggle maximize vertically",
				},
			},
		},
	},
}

local function apply_mappings(groups)
	local ret = {}
	for group, mappings in pairs(groups) do
		for mod, submappings in pairs(mappings) do
			for submod, keys in pairs(submappings) do
				for _, key in ipairs(keys) do
					local modkey = {}
					if mod ~= "" then
						table.insert(modkey, mod)
						if submod ~= "" then
							table.insert(modkey, submod)
						end
					end

					ret[#ret + 1] =
							awful.key(modkey, key.key, key.action, { description = key.description, group = group })
				end
			end
		end
	end

	return ret
end

local global_keys = apply_mappings(GLOBAL_GROUPS)
local client_keys = apply_mappings(CLIENT_GROUPS)

globalkeys = gears.table.join(table.unpack(global_keys))
clientkeys = gears.table.join(table.unpack(client_keys))

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it work on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 9 do
	globalkeys = gears.table.join(
		globalkeys,
		-- View tag only.
		awful.key({ mods.m }, "#" .. i + 9, function()
			local screen = awful.screen.focused()
			local tag = screen.tags[i]
			if tag then
				tag:view_only()
			end
		end, { description = "view tag #" .. i, group = "tag" }),
		-- Toggle tag display.
		awful.key({ mods.m, mods.c }, "#" .. i + 9, function()
			local screen = awful.screen.focused()
			local tag = screen.tags[i]
			if tag then
				awful.tag.viewtoggle(tag)
			end
		end, { description = "toggle tag #" .. i, group = "tag" }),
		-- Move client to tag.
		awful.key({ mods.m, mods.s }, "#" .. i + 9, function()
			if client.focus then
				local tag = client.focus.screen.tags[i]
				if tag then
					client.focus:move_to_tag(tag)
				end
			end
		end, { description = "move focused client to tag #" .. i, group = "tag" }),
		-- Toggle tag on focused client.
		awful.key({ mods.m, mods.c, mods.s }, "#" .. i + 9, function()
			if client.focus then
				local tag = client.focus.screen.tags[i]
				if tag then
					client.focus:toggle_tag(tag)
				end
			end
		end, { description = "toggle focused client on tag #" .. i, group = "tag" })
	)
end

clientbuttons = gears.table.join(
	awful.button({}, 1, function(c)
		c:emit_signal("request::activate", "mouse_click", { raise = true })
	end),
	awful.button({ mods.m }, 1, function(c)
		c:emit_signal("request::activate", "mouse_click", { raise = true })
		awful.mouse.client.move(c)
	end),
	awful.button({ mods.m }, 3, function(c)
		c:emit_signal("request::activate", "mouse_click", { raise = true })
		awful.mouse.client.resize(c)
	end)
)

-- 		-- Lockscreen
--		awful.key(
--			{modkey},
--			'l',
--			function()
--				awful.spawn(apps.default.lock, false)
--			end,
--			{description = 'lock the screen', group = 'Utility'}
--		),

root.keys(globalkeys)
