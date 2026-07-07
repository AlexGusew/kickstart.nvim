local lint = require 'lint'

lint.linters_by_ft = vim.tbl_deep_extend('force', lint.linters_by_ft or {}, {
  javascript = { 'eslint_d' },
  typescript = { 'eslint_d' },
  javascriptreact = { 'eslint_d' },
  typescriptreact = { 'eslint_d' },
  python = { 'ruff' },
})

local lint_augroup = vim.api.nvim_create_augroup('lint', { clear = true })
vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost', 'InsertLeave' }, {
  group = lint_augroup,
  callback = function()
    local ft = vim.bo.filetype
    local supported = lint.linters_by_ft[ft]
    if vim.opt_local.modifiable:get() and supported then
      lint.try_lint()
    end
  end,
})
