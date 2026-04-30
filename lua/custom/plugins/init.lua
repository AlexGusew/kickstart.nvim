-- [[ Editor options ]]
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true

-- Folding via treesitter (nvim 0.12 API)
vim.opt.foldmethod = 'expr'
vim.opt.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
vim.opt.foldlevel = 99

vim.opt.swapfile = false

-- [[ Keymaps ]]
vim.keymap.set('n', 'n', 'nzz', { silent = true, desc = 'next search and center' })
vim.keymap.set('n', 'N', 'Nzz', { silent = true, desc = 'previous search and center' })
vim.keymap.set('n', '<leader>tq', ':tabclose<CR>', { silent = true, desc = '[T]ab [Q]uit' })
vim.keymap.set('n', '<leader>tn', ':tabnew<CR>', { silent = true, desc = '[T]ab [N]ew' })
vim.keymap.set('n', '<leader>tt', ':tabnew | term<CR>', { silent = true, desc = '[T]ab [T]erminal' })
vim.keymap.set('n', '<leader>w', ':w<CR>', { noremap = true, silent = true })

-- [[ Helper functions for lazygit integration ]]
function EditLineFromLazygit(file_path, line)
  local path = vim.fn.expand '%:p'
  if path == file_path then
    vim.cmd(tostring(line))
  else
    vim.cmd('e ' .. file_path)
    vim.cmd(tostring(line))
  end
end

function EditFromLazygit(file_path)
  local path = vim.fn.expand '%:p'
  if path ~= file_path then
    vim.cmd('e ' .. file_path)
  end
end

-- [[ GLSL filetype detection ]]
vim.api.nvim_create_autocmd({ 'BufReadPost', 'BufNewFile' }, {
  pattern = { '*.vs', '*.fs' },
  callback = function()
    vim.bo.filetype = 'glsl'
  end,
})

-- [[ yazi ]]
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
require('yazi').setup {
  open_for_directories = true,
  keymaps = { show_help = '<f1>' },
}
vim.keymap.set({ 'n', 'v' }, '<leader>-', '<cmd>Yazi<cr>', { desc = 'Open yazi at the current file' })
vim.keymap.set('n', '<leader>cw', '<cmd>Yazi cwd<cr>', { desc = "Open the file manager in nvim's working directory" })
vim.keymap.set('n', '<c-up>', '<cmd>Yazi toggle<cr>', { desc = 'Resume the last yazi session' })

-- [[ diffview ]]
vim.keymap.set('n', '<leader>gd', function()
  local view = require('diffview.lib').get_current_view()
  if view then
    vim.cmd 'DiffviewClose'
  else
    vim.cmd 'DiffviewOpen'
  end
end, { desc = 'Toggle Git Diff View' })

-- [[ typescript-tools ]]
require('typescript-tools').setup {
  on_attach = function(client, bufnr)
    client.server_capabilities.documentFormattingProvider = false
    client.server_capabilities.documentRangeFormattingProvider = false
  end,
}

-- [[ conform ]]
require('conform').setup {
  notify_on_error = false,
  formatters_by_ft = {
    lua = { 'stylua' },
    javascript = { 'prettier' },
    typescript = { 'prettier' },
    javascriptreact = { 'prettier' },
    typescriptreact = { 'prettier' },
    json = { 'prettier' },
    markdown = { 'prettier' },
    yaml = { 'prettier' },
  },
  format_on_save = function(bufnr)
    local ft = vim.bo[bufnr].filetype
    local disabled = { c = true, cpp = true }
    if disabled[ft] then return end
    return { timeout_ms = 500, lsp_format = 'fallback' }
  end,
  formatters = {
    prettierd = {
      condition = function()
        return vim.uv.fs_realpath '.prettierrc.js' ~= nil
          or vim.uv.fs_realpath '.prettierrc.mjs' ~= nil
          or vim.uv.fs_realpath '.prettierrc' ~= nil
      end,
    },
  },
}

vim.keymap.set({ 'n', 'v' }, '<leader>F', function()
  require('conform').format { async = true, lsp_format = 'fallback' }
end, { desc = '[F]ormat buffer' })
