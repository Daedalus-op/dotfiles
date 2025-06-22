-- You can also add or configure plugins by creating files in this `plugins/` folder
-- Here are some examples:

---@type LazySpec
return {

  -- == Examples of Adding Plugins ==

  -- == Examples of Overriding Plugins ==

  -- customize alpha options
  { -- Alpha Config
    "goolord/alpha-nvim",
    opts = function(_, opts)
      -- customize the dashboard header
      opts.section.header.val = {
        -- "            ⣴⣶⣤⡤⠦⣤⣀⣤⠆     ⣈⣭⣿⣶⣿⣦⣼⣆                  ",
        -- "             ⠉⠻⢿⣿⠿⣿⣿⣶⣦⠤⠄⡠⢾⣿⣿⡿⠋⠉⠉⠻⣿⣿⡛⣦               ",
        -- "                   ⠈⢿⣿⣟⠦ ⣾⣿⣿⣷    ⠻⠿⢿⣿⣧⣄             ",
        -- "                    ⣸⣿⣿⢧ ⢻⠻⣿⣿⣷⣄⣀⠄⠢⣀⡀⠈⠙⠿⠄            ",
        -- "                   ⢠⣿⣿⣿⠈    ⣻⣿⣿⣿⣿⣿⣿⣿⣛⣳⣤⣀⣀           ",
        -- "            ⢠⣧⣶⣥⡤⢄ ⣸⣿⣿⠘  ⢀⣴⣿⣿⡿⠛⣿⣿⣧⠈⢿⠿⠟⠛⠻⠿⠄          ",
        -- "           ⣰⣿⣿⠛⠻⣿⣿⡦⢹⣿⣷   ⢊⣿⣿⡏  ⢸⣿⣿⡇ ⢀⣠⣄⣾⠄           ",
        -- "          ⣠⣿⠿⠛ ⢀⣿⣿⣷⠘⢿⣿⣦⡀ ⢸⢿⣿⣿⣄ ⣸⣿⣿⡇⣪⣿⡿⠿⣿⣷⡄          ",
        -- "          ⠙⠃   ⣼⣿⡟  ⠈⠻⣿⣿⣦⣌⡇⠻⣿⣿⣷⣿⣿⣿ ⣿⣿⡇ ⠛⠻⢷⣄         ",
        -- "               ⢻⣿⣿⣄   ⠈⠻⣿⣿⣿⣷⣿⣿⣿⣿⣿⡟ ⠫⢿⣿⡆             ",
        -- "                ⠻⣿⣿⣿⣿⣶⣶⣾⣿⣿⣿⣿⣿⣿⣿⣿⡟⢀⣀⣤⣾⡿⠃             ",
        "                                                    ",
        "                                                    ",
        "                                                    ",
        "                                                    ",
        " ███    ██  ██████   ██████   ██    ██ ██ ███    ███",
        " ████   ██  ██      ██    ██  ██    ██ ██ ████  ████",
        " ██ ██  ██  ██████  ██    ██  ██    ██ ██ ██ ████ ██",
        " ██  ██ ██  ██      ██    ██   ██  ██  ██ ██  ██  ██",
        " ██   ████  ██████   ██████     ████   ██ ██      ██",
      }
      return opts
    end,
  },

  -- You can disable default plugins as follows:
  { "max397574/better-escape.nvim", enabled = false },
  { "nvim-neo-tree/neo-tree.nvim", enabled = false },
  { "nvim-telescope/telescope-fzf-native.nvim", enabled = false },
  -- { "3rd/image.nvim", enabled = false },

  -- You can also easily customize additional setup of plugins that is outside of the plugin's setup call
  { -- Neorg Config
    "nvim-neorg/neorg",
    lazy = false, -- Disable lazy loading as some `lazy.nvim` distributions set `lazy = true` by default
    version = "*", -- Pin Neorg to the latest stable release
    config = function()
      require("neorg").setup {
        load = {
          ["core.defaults"] = {},
          ["core.concealer"] = {},
          ["core.export"] = {},
          ["core.ui.calendar"] = {},
          ["core.presenter"] = {
            config = {
              zen_mode = "zen-mode",
            },
          },
          ["core.dirman"] = {
            config = {
              workspaces = {
                notes = "~/projects/notes",
              },
              default_workspace = "notes",
            },
          },
          -- ["core.latex.renderer"] = {},
        },
      }
    end,
  },
  { -- LuaSnip Config
    "L3MON4D3/LuaSnip",
    config = function(plugin, opts)
      require "astronvim.plugins.configs.luasnip"(plugin, opts) -- include the default astronvim config that calls the setup call
      -- add more custom luasnip configuration such as filetype extend or custom snippets
      local luasnip = require "luasnip"
      luasnip.filetype_extend("javascript", { "javascriptreact" })
    end,
  },

  { -- nvim-autopairs Config
    "windwp/nvim-autopairs",
    config = function(plugin, opts)
      require "astronvim.plugins.configs.nvim-autopairs"(plugin, opts) -- include the default astronvim config that calls the setup call
      -- add more custom autopairs configuration such as custom rules
      local npairs = require "nvim-autopairs"
      local Rule = require "nvim-autopairs.rule"
      local cond = require "nvim-autopairs.conds"
      npairs.add_rules(
        {
          Rule("$", "$", { "tex", "latex" })
            -- don't add a pair if the next character is %
            :with_pair(cond.not_after_regex "%%")
            -- don't add a pair if  the previous character is xxx
            :with_pair(
              cond.not_before_regex("xxx", 3)
            )
            -- don't move right when repeat character
            :with_move(cond.none())
            -- don't delete if the next character is xx
            :with_del(cond.not_after_regex "xx")
            -- disable adding a newline when you press <cr>
            :with_cr(cond.none()),
        },
        -- disable for .vim files, but it work for another filetypes
        Rule("a", "a", "-vim")
      )
    end,
  },
  -- ** DEFAULT SETTINGS; TO USE THESE, PASS NO ARGUMENTS TO THE SETUP FUNCTION **
  require("notify").setup {
    merge_duplicates = true,
    background_colour = "#000000",
  },
  require("telescope").setup {
    defaults = {
      -- other default settings...
      sorting_strategy = "ascending",
      layout_strategy = "horizontal",
      layout_config = {
        horizontal = { mirror = false },
        vertical = { mirror = false },
      },
      -- Set fzy as the sorter
      sorter = require("telescope.sorters").fzy_sorter,
    },
  },
  require("mkdnflow").setup {
    modules = {
      bib = true,
      buffers = true,
      conceal = true,
      cursor = true,
      folds = true,
      foldtext = true,
      links = true,
      lists = true,
      maps = true,
      paths = true,
      tables = true,
      yaml = false,
      cmp = false,
    },
    filetypes = { md = true, rmd = true, markdown = true },
    create_dirs = true,
    perspective = {
      priority = "first",
      fallback = "current",
      root_tell = false,
      nvim_wd_heel = false,
      update = false,
    },
    wrap = false,
    bib = {
      default_path = nil,
      find_in_root = true,
    },
    silent = false,
    cursor = {
      jump_patterns = nil,
    },
    links = {
      style = "markdown",
      name_is_source = false,
      conceal = false,
      context = 0,
      implicit_extension = nil,
      transform_implicit = false,
      transform_explicit = function(text)
        text = text:gsub(" ", "-")
        text = text:lower()
        -- text = os.date "%Y-%m-%d_" .. text
        return text
      end,
      create_on_follow_failure = true,
    },
    new_file_template = {
      use_template = false,
      placeholders = {
        before = {
          title = "link_title",
          date = "os_date",
        },
        after = {},
      },
      template = "# {{ title }}",
    },
    to_do = {
      symbols = { " ", "-", "X" },
      update_parents = true,
      not_started = " ",
      in_progress = "-",
      complete = "X",
    },
    foldtext = {
      object_count = true,
      object_count_icons = "emoji",
      object_count_opts = function() return require("mkdnflow").foldtext.default_count_opts() end,
      line_count = true,
      line_percentage = true,
      word_count = false,
      title_transformer = nil,
      separator = " · ",
      fill_chars = {
        left_edge = "⢾",
        right_edge = "⡷",
        left_inside = " ⣹",
        right_inside = "⣏ ",
        middle = "⣿",
      },
    },
    tables = {
      trim_whitespace = true,
      format_on_move = true,
      auto_extend_rows = false,
      auto_extend_cols = false,
      style = {
        cell_padding = 1,
        separator_padding = 1,
        outer_pipes = true,
        mimic_alignment = true,
      },
    },
    yaml = {
      bib = { override = false },
    },
    mappings = {
      MkdnEnter = { { "n", "v" }, "<CR>" },
      MkdnTab = false,
      MkdnSTab = false,
      MkdnNextLink = { "n", "<Tab>" },
      MkdnPrevLink = { "n", "<S-Tab>" },
      MkdnNextHeading = { "n", "]]" },
      MkdnPrevHeading = { "n", "[[" },
      MkdnGoBack = { "n", "<BS>" },
      MkdnGoForward = { "n", "<Del>" },
      MkdnCreateLink = false, -- see MkdnEnter
      MkdnCreateLinkFromClipboard = { { "n", "v" }, "<leader>p" }, -- see MkdnEnter
      MkdnFollowLink = false, -- see MkdnEnter
      MkdnDestroyLink = { "n", "<M-CR>" },
      MkdnTagSpan = { "v", "<M-CR>" },
      MkdnMoveSource = { "n", "<F2>" },
      MkdnYankAnchorLink = { "n", "yaa" },
      MkdnYankFileAnchorLink = { "n", "yfa" },
      MkdnIncreaseHeading = { "n", "+" },
      MkdnDecreaseHeading = { "n", "-" },
      MkdnToggleToDo = { { "n", "v" }, "tt" },
      MkdnNewListItem = false,
      MkdnNewListItemBelowInsert = { "n", "o" },
      MkdnNewListItemAboveInsert = { "n", "O" },
      MkdnExtendList = false,
      MkdnUpdateNumbering = { "n", "<leader>nn" },
      MkdnTableNextCell = { "i", "<Tab>" },
      MkdnTablePrevCell = { "i", "<S-Tab>" },
      MkdnTableNextRow = false,
      MkdnTablePrevRow = { "i", "<M-CR>" },
      MkdnTableNewRowBelow = { "n", "<leader>ir" },
      MkdnTableNewRowAbove = { "n", "<leader>iR" },
      MkdnTableNewColAfter = { "n", "<leader>ic" },
      MkdnTableNewColBefore = { "n", "<leader>iC" },
      MkdnFoldSection = { "n", "<leader>f" },
      MkdnUnfoldSection = { "n", "<leader>F" },
    },
  },
}
