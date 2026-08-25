local lint = require 'lint'

local js_ts_fts = { 'javascript', 'typescript', 'javascriptreact', 'typescriptreact' }

local function js_linters()
  if vim.fn.executable 'oxlint' == 1 then
    return { 'oxlint' }
  end
  return { 'eslint_d' }
end

local linters_by_ft = {
  python = { 'ruff' },
}
for _, ft in ipairs(js_ts_fts) do
  linters_by_ft[ft] = js_linters()
end

lint.linters_by_ft = vim.tbl_deep_extend('force', lint.linters_by_ft or {}, linters_by_ft)

local lint_augroup = vim.api.nvim_create_augroup('lint', { clear = true })
vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost', 'InsertLeave' }, {
  group = lint_augroup,
  callback = function()
    local ft = vim.bo.filetype
    local supported = lint.linters_by_ft[ft]
    if vim.opt_local.modifiable:get() and supported and vim.fn.filereadable(vim.api.nvim_buf_get_name(0)) == 1 then
      lint.try_lint()
    end
  end,
})
