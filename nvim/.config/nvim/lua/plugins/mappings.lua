return {
  {
    "AstroNvim/astrocore",
    ---@type AstroCoreOpts
    opts = {
      mappings = {
        -- first key is the mode
        n = {
          -- second key is the lefthand side of the map
          -- mappings seen under group name "Buffer"
          ["<Leader>bn"] = { "<cmd>tabnew<cr>", desc = "New tab" },
          ["<Leader>s"] = { "<cmd>w<cr>", desc = "Save file" },
          ["<Leader>e"] = { "<cmd>Lf<cr>", desc = "Explorer" },
          -- ["<Leader>w"] = { desc = "VimWiki" },
          ["<Leader>bD"] = {
            function()
              require("astroui.status").heirline.buffer_picker(
                function(bufnr) require("astrocore.buffer").close(bufnr) end
              )
            end,
            desc = "Pick to close",
          },
          -- ZenMode
          ["<Leader>z"] = { desc = "ZenMode" },
          ["<Leader>zz"] = { "<cmd>ZenMode<cr><Space>ul", desc = "ZenMode toggle" },
          ["<Leader>zt"] = { "<cmd>Twilight<cr>", desc = "Twilight toggle" },
          -- tables with just a `desc` key will be registered with which-key if it's installed
          ["<Leader>b"] = { desc = "Buffers" },

          ["<Leader>pp"] = { '"+p', desc = "Clipboard Paste" },

          ["<Leader>N"] = { "<cmd>Neorg<cr>", desc = "Neorg" },

          -- quick save
          -- ["<C-s>"] = { "<cmd>w!<cr>", desc = "Save File" },
          ["<C-p>"] = { "<cmd>FuzzyOpen<cr>", desc = "Fuzzy Open" },
        },
        t = {
          -- setting a mapping to false will disable it
          -- ["<esc>"] = false,
        },
        v = {
          ["<Leader>y"] = { '"+y', desc = "Clipboard Yank" },
          ["<Leader>p"] = { '"+p', desc = "Clipboard Paste" },
        },
      },
    },
  },
  {
    "AstroNvim/astrolsp",
    ---@type AstroLSPOpts
    opts = {
      mappings = {
        n = {
          -- this mapping will only be set in buffers with an LSP attached
          K = {
            function() vim.lsp.buf.hover() end,
            desc = "Hover symbol details",
          },
          -- condition for only server with declaration capabilities
          gD = {
            function() vim.lsp.buf.declaration() end,
            desc = "Declaration of current symbol",
            cond = "textDocument/declaration",
          },
        },
      },
    },
  },
}
