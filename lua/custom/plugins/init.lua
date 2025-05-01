vim.opt.verbose = 1 -- Log at level 1 (you can increase this value for more detailed logs)
vim.opt.runtimepath:append("~/.local/state/nvim")

vim.opt.tabstop = 2      -- Number of spaces for a tab
vim.opt.shiftwidth = 2   -- Number of spaces for autoindent
vim.opt.expandtab = true -- Use spaces instead of tabs

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
  {
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
  {
    "folke/persistence.nvim",
    lazy = false,
    config = function()
      require("persistence").setup()

      vim.api.nvim_create_autocmd("VimEnter", {
        callback = function()
          if vim.fn.argc() == 0 then
            require("persistence").load()
            -- 🔁 Trigger filetype and syntax manually
            vim.defer_fn(function()
              vim.cmd("silent! filetype detect")
              vim.cmd("silent! syntax enable")
            end, 100)
          end
        end,
      })
    end,
  },
  {
    "sindrets/diffview.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim", -- required dependency
    },
    config = function()
      -- optional: custom config
      vim.keymap.set("n", "<leader>gd", ":DiffviewOpen<CR>", { desc = "Open Git Diff View" })
    end,
  },
}
