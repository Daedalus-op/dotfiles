-- -------------------------------------------------------------------
-- Function to read colors from pywal cache
local function load_colors()
	local colors = {}
	local file = io.open(os.getenv("HOME") .. "/.cache/wal/colors", "r")
	if file then
		for line in file:lines() do
			table.insert(colors, line)
		end
		file:close()
	end
	return colors
end

-- Load colors
local wal_colors = load_colors()
-- -------------------------------------------------------------------

local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi

local gears = require("gears")
local naughty = require("naughty")
local constants = require("constants")
local utils = require("utils")

-- assets
local gfs = require("gears.filesystem")
local assets_path = gfs.get_configuration_dir() .. "ui/assets/"
local icons_path = assets_path .. "icons/"
-- local shapes_path = assets_path .. "shapes/"

local theme = {}
theme.bar_width = 43
theme.hints_icon = gears.color.recolor_image(icons_path .. "hints.svg", theme.blue)
theme.fallback_notif_icon = gears.color.recolor_image(icons_path .. "hints.svg", theme.blue)

theme.icon_theme = "Papirus"

theme.transparent = "#00000000"
theme.font_name = "JetBrains Mono Nerd Font Bold"
theme.font_size = "12"
theme.font = theme.font_name .. " " .. theme.font_size

theme.black = "#16161D"
theme.red = "#E46876"
theme.yellow = "#F2D98C"
theme.orange = "#FFA066"
theme.green = "#03C04A"
theme.white = "#D3D3D3"
theme.dimblack = "#1a1c25"
theme.light_black = wal_colors[5] -- "#262831"
theme.grey = "#666891"
theme.magenta = "#c296eb"
theme.blue = wal_colors[5] -- "#86aaec"
theme.cyan = "#93cee9"
theme.aqua = "#7bd9e6"

-- dashboard
theme.dash_width = 600

-- bg
theme.bg_darker = "#0b0d16"
theme.bg_contrast = "#0f111a"
theme.bg_lighter = "#11131c"

theme.bg_normal = theme.black
theme.bg_focus = theme.green
theme.bg_urgent = theme.red
theme.bg_systray = theme.bg_normal

-- fg
theme.fg_normal = theme.white
theme.fg_focus = theme.yellow
theme.fg_urgent = theme.white

-- spacing
theme.spacing = dpi(8)
theme.spacing_md = dpi(12)
theme.spacing_lg = dpi(16)
theme.spacing_xl = dpi(20)

-- border
theme.useless_gap = dpi(4)
theme.border_width = dpi(2)
theme.border_radius = dpi(10)
theme.border_focus = theme.bg_focus
theme.border_normal = theme.bg_normal

-- taglist
theme.taglist_bg = theme.bg_normal
theme.taglist_bg_focus = wal_colors[5] -- theme.green
theme.taglist_bg_urgent = wal_colors[2] -- theme.red
theme.taglist_fg_focus = theme.bg_normal
theme.taglist_fg_occupied = wal_colors[5] -- theme.green

-- wallpaper
-- theme.wallpaper = gears.surface.load_uncached(constants.wallpapers .. "wall.png")

-- bar
theme.bar_height = dpi(50)

-- system tray
theme.systray_icon_spacing = theme.spacing
theme.systray_max_rows = 7

-- ********************************* --
--
--              Naughty
--
-- ********************************* --

local nc = naughty.config
nc.defaults.margin = theme.spacing_lg
nc.defaults.shape = utils.ui.rounded_rect()
nc.defaults.timeout = 3
nc.padding = theme.spacing
nc.padding = theme.spacing_xl
nc.presets.critical.bg = theme.red
nc.presets.critical.fg = theme.bg_normal
nc.presets.low.bg = theme.bg_normal
nc.presets.normal.bg = theme.green
nc.presets.normal.fg = theme.bg_normal
nc.spacing = theme.spacing

-- ********************************* --
--
--              Widgets
--
-- ********************************* --

-- battery
theme.battery_happy = theme.fg_normal
theme.battery_tired = theme.yellow
theme.battery_sad = theme.red
theme.battery_charging = theme.green

-- calendar
theme.calendar_fg_header = theme.fg_normal
theme.calendar_fg_focus = theme.bg_normal
theme.calendar_fg_weekday = theme.green
theme.calendar_fg = theme.fg_normal
theme.calendar_bg = theme.bg_normal
theme.calendar_bg_focus = theme.green

-- pomodoro
theme.pomo_B_ = theme.green
theme.pomo_5_ = theme.red
theme.pomo_W_ = theme.orange
theme.pomo_WP = theme.white
theme.pomo_BP = theme.white

return theme
