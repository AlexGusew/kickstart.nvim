vim.opt.verbose = 1 -- Log at level 1 (you can increase this value for more detailed logs)
vim.opt.runtimepath:append("~/.local/state/nvim")

vim.opt.tabstop = 2      -- Number of spaces for a tab
vim.opt.shiftwidth = 2   -- Number of spaces for autoindent
vim.opt.expandtab = true -- Use spaces instead of tabs

vim.api.nvim_set_keymap('n', 'n', 'nzz', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'N', 'Nzz', { noremap = true, silent = true })
-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
vim.api.nvim_set_keymap('n', '<leader>tn', ':tabnew<CR>', { noremap = true, desc = '[T]ab [N]ew', silent = true })
vim.api.nvim_set_keymap('n', '<leader>tt', ':tabnew | term<CR>',
  { noremap = true, desc = '[T]ab [T]erminal', silent = true })

function EditLineFromLazygit(file_path, line)
  local path = vim.fn.expand("%:p")
  if path == file_path then
    vim.cmd(tostring(line))
  else
    vim.cmd("e " .. file_path)
    vim.cmd(tostring(line))
  end
end

function EditFromLazygit(file_path)
  local path = vim.fn.expand("%:p")
  if path == file_path then
    return
  else
    vim.cmd("e " .. file_path)
  end
end

return {
  -- {
  --   "ahmedkhalf/project.nvim",
  --   config = function()
  --     require("project_nvim").setup {}
  --     require('telescope').load_extension('projects')
  --     require 'telescope'.extensions.projects.projects {}
  --   end
  -- },
  ---@type LazySpec
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    ---@type snacks.Config
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
      bigfile = { enabled = true },
      dashboard = { enabled = true },
      explorer = { enabled = false },
      indent = { enabled = false },
      input = { enabled = false },
      picker = { enabled = true },
      notifier = { enabled = true, top_down = false },
      quickfile = { enabled = true },
      scope = { enabled = false },
      scroll = { enabled = true },
      statuscolumn = { enabled = false },
      words = { enabled = false },
    },
  },
  {
    "mikavilpas/yazi.nvim",
    event = "VeryLazy",
    dependencies = {
      -- check the installation instructions at
      -- https://github.com/folke/snacks.nvim
      "folke/snacks.nvim"
    },
    keys = {
      -- 👇 in this section, choose your own keymappings!
      {
        "<leader>-",
        mode = { "n", "v" },
        "<cmd>Yazi<cr>",
        desc = "Open yazi at the current file",
      },
      {
        -- Open in the current working directory
        "<leader>cw",
        "<cmd>Yazi cwd<cr>",
        desc = "Open the file manager in nvim's working directory",
      },
      {
        "<c-up>",
        "<cmd>Yazi toggle<cr>",
        desc = "Resume the last yazi session",
      },
    },
    ---@type YaziConfig | {}
    opts = {
      -- if you want to open yazi instead of netrw, see below for more info
      open_for_directories = true,
      keymaps = {
        show_help = "<f1>",
      },
    },
    -- 👇 if you use `open_for_directories=true`, this is recommended
    init = function()
      -- More details: https://github.com/mikavilpas/yazi.nvim/issues/802
      vim.g.loaded_netrw = 1
      vim.g.loaded_netrwPlugin = 1
    end,
  }, {
  'pmizio/typescript-tools.nvim',
  dependencies = { 'nvim-lua/plenary.nvim', 'neovim/nvim-lspconfig' },
  opts = {},
  config = function()
    require('typescript-tools').setup {
      on_attach = function(client, bufnr)
        client.server_capabilities.documentFormattingProvider = false
        client.server_capabilities.documentRangeFormattingProvider = false
      end,
    }
  end,
},
  {
    'stevearc/conform.nvim',
    config = function()
      require('conform').setup {
        formatters_by_ft = {
          javascript = { 'prettier' },
          typescript = { 'prettier' },
          javascriptreact = { 'prettier' },
          typescriptreact = { 'prettier' },
          json = { 'prettier' },
          markdown = { 'prettier' },
          yaml = { 'prettier' },
        },
        format_on_save = function(bufnr)
          return { timeout_ms = 500, lsp_fallback = true }
        end,
        formatters = {
          prettierd = {
            condition = function()
              return vim.loop.fs_realpath '.prettierrc.js' ~= nil or
                  vim.loop.fs_realpath '.prettierrc.mjs' ~= nil or
                  vim.loop.fs_realpath '.prettierrc'
            end,
          },
        },
      }
    end,
  },
  -- {
  --   "folke/persistence.nvim",
  --   lazy = false,
  --   config = function()
  --     require("persistence").setup()
  --
  --     vim.api.nvim_create_autocmd("VimEnter", {
  --       callback = function()
  --         if vim.fn.argc() == 0 then
  --           require("persistence").load()
  --           -- 🔁 Trigger filetype and syntax manually
  --           vim.defer_fn(function()
  --             vim.cmd("silent! filetype detect")
  --             vim.cmd("silent! syntax enable")
  --           end, 100)
  --         end
  --       end,
  --     })
  --   end,
  -- },
  {
    "sindrets/diffview.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim", -- required dependency
    },
    config = function()
      -- optional: custom config
      vim.keymap.set("n", "<leader>gd", ":DiffviewOpen<CR>", { desc = "Open Git Diff View" })
      vim.keymap.set("n", "<leader>gD", ":DiffviewClose<CR>", { desc = "Close Git Diff View" })
    end,
  },
  {
    "folke/trouble.nvim",
    opts = {}, -- for default options, refer to the configuration section for custom setup.
    cmd = "Trouble",
    keys = {
      {
        "<leader>xx",
        "<cmd>Trouble diagnostics toggle<cr>",
        desc = "Diagnostics (Trouble)",
      },
      {
        "<leader>xX",
        "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
        desc = "Buffer Diagnostics (Trouble)",
      },
      {
        "<leader>cs",
        "<cmd>Trouble symbols toggle focus=false<cr>",
        desc = "Symbols (Trouble)",
      },
      {
        "<leader>cl",
        "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
        desc = "LSP Definitions / references / ... (Trouble)",
      },
      {
        "<leader>xL",
        "<cmd>Trouble loclist toggle<cr>",
        desc = "Location List (Trouble)",
      },
      {
        "<leader>xQ",
        "<cmd>Trouble qflist toggle<cr>",
        desc = "Quickfix List (Trouble)",
      },
    },
  }
}
