if false then
  return {}
end

return {
  "chomosuke/typst-preview.nvim",
  lazy = true,
  -- lazy = false, -- or ft = 'typst'
  version = "1.*",
  opts = {
    open_cmd = "firefox-esr %s",
    invert_colors = "auto",
  }, -- lazy.nvim will implicitly calls `setup {}`
}
