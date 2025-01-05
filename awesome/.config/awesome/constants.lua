local gfs = require("gears.filesystem")

local M = {}

M.terminal = "kitty"
M.browser = "flatpak run app.zen_browser.zen"
M.browser_alt = "firefox-esr"
M.term_fm = "lf"
M.fm = "nemo"
M.editor = "nvim"
M.editor_cmd = M.terminal .. " -e " .. M.editor
M.mods = {
	m = "Mod4",
	s = "Shift",
	c = "Control",
	a = "Mod1",
}
-- M.wallpapers = gfs.get_configuration_dir() .. "/home/xubundadu/.customise/Wallpapers/Scenery/"
M.wallpapers = "/home/xubundadu/.customise/Wallpapers/Scenery/"

return M
