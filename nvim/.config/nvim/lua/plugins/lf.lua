return {
  "lmburns/lf.nvim",
  config = function()
    -- This feature will not work if the plugin is lazy-loaded
    vim.g.lf_netrw = 1

    require("lf").setup {
      winblend = 0,
      highlights = { NormalFloat = { guibg = "NONE" } },
      escape_quit = false,
      border = "rounded",
    }

    vim.keymap.set("n", "<M-o>", "<Cmd>Lf<CR>")

    -- vim.api.nvim_create_autocmd {
    --   event = "User",
    --   pattern = "LfTermEnter",
    --   callback = function(a) vim.api.nvim_buf_set_keymap(a.buf, "t", "q", "q", { nowait = true }) end,
    -- }
  end,
  requires = { "toggleterm.nvim" },
}
