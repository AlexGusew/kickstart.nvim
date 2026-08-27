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

-- [[ trouble.nvim ]]
require('trouble').setup {}
vim.api.nvim_set_hl(0, 'TroubleNormal', { link = 'Normal' })
vim.api.nvim_set_hl(0, 'TroubleNormalNC', { link = 'NormalNC' })
vim.api.nvim_create_autocmd('ColorScheme', {
  pattern = '*',
  callback = function()
    vim.api.nvim_set_hl(0, 'TroubleNormal', { link = 'Normal' })
    vim.api.nvim_set_hl(0, 'TroubleNormalNC', { link = 'NormalNC' })
  end,
})
vim.keymap.set('n', '<leader>xx', '<cmd>Trouble diagnostics toggle<cr>', { desc = 'Diagnostics (Trouble)' })
vim.keymap.set('n', '<leader>xX', '<cmd>Trouble diagnostics toggle filter.buf=0<cr>', { desc = 'Buffer diagnostics (Trouble)' })
vim.keymap.set('n', '<leader>cs', '<cmd>Trouble symbols toggle<cr>', { desc = '[S]ymbols (Trouble)' })
vim.keymap.set('n', '<leader>cl', '<cmd>Trouble lsp toggle<cr>', { desc = '[L]SP (Trouble)' })
vim.keymap.set('n', '<leader>xL', '<cmd>Trouble loclist toggle<cr>', { desc = 'Location list (Trouble)' })
vim.keymap.set('n', '<leader>xQ', '<cmd>Trouble qflist toggle<cr>', { desc = 'Quickfix list (Trouble)' })

-- [[ diffview ]]
vim.keymap.set('n', '<leader>gd', function()
  local view = require('diffview.lib').get_current_view()
  if view then
    vim.cmd 'DiffviewClose'
  else
    vim.cmd 'DiffviewOpen'
  end
end, { desc = 'Toggle Git Diff View' })

-- Also close diffview from within its own buffers
vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'DiffviewFiles', 'DiffviewFileHistory' },
  callback = function(ev)
    vim.keymap.set('n', '<leader>gd', '<cmd>DiffviewClose<cr>', { buffer = ev.buf, desc = 'Close Git Diff View' })
  end,
})

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
    c = { 'clang-format' },
    cpp = { 'clang-format' },
    javascript = { 'oxfmt' },
    typescript = { 'oxfmt' },
    javascriptreact = { 'oxfmt' },
    typescriptreact = { 'oxfmt' },
    json = { 'prettierd' },
    -- markdown = { 'prettierd' },
    yaml = { 'prettierd' },
    css = { 'prettierd' },
    scss = { 'prettierd' },
    html = { 'prettierd' },
    python = {
      'ruff_fix', -- ruff check --fix (auto-fixable lint errors)
      'ruff_format', -- ruff format
      'ruff_organize_imports',
    },
  },
  format_on_save = function(bufnr)
    return { timeout_ms = 500, lsp_format = 'fallback' }
  end,
  formatters = {
    oxfmt = {
      command = 'oxfmt',
      args = { '--stdin-filepath', '$FILENAME' },
      stdin = true,
    },
  },
}

vim.keymap.set({ 'n', 'v' }, '<leader>F', function()
  require('conform').format { async = true, lsp_format = 'fallback' }
end, { desc = '[F]ormat buffer' })
