return {
  "vimwiki/vimwiki",
  enabled = false,
  config = function()
    -- This feature will not work if the plugin is lazy-loaded
    -- vim.keymap.set("n", "<M-o>", "<Cmd>Lf<CR>")
  end,
}
