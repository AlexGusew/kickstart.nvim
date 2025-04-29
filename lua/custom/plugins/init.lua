-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
vim.api.nvim_set_keymap('n', '<leader>tn', ':tabnew<CR>', { noremap = true, desc = '[T]ab [N]ew', silent = true })
vim.api.nvim_set_keymap('n', '<leader>tt', ':tabnew | term<CR>', { noremap = true, desc = '[T]ab [T]erminal', silent = true })

return {
  {
    'pmizio/typescript-tools.nvim',
    dependencies = { 'nvim-lua/plenary.nvim', 'neovim/nvim-lspconfig' },
    opts = {},
  },
}
