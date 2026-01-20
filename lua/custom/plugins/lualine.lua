return {
  'nvim-lualine/lualine.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons', 'kdheepak/tabline.nvim' },
  config = function()
    -- local custom_moonfly = require 'lualine.themes.moonfly'

    -- local black = '#000000'
    -- -- custom_moonfly.replace.a.bg = black
    -- custom_moonfly.replace.b.bg = black
    -- custom_moonfly.inactive.a.bg = black
    -- custom_moonfly.inactive.b.bg = black
    -- custom_moonfly.inactive.c.bg = black
    -- -- custom_moonfly.normal.a.bg = black
    -- custom_moonfly.normal.b.bg = black
    -- custom_moonfly.normal.c.bg = black
    -- -- custom_moonfly.visual.a.bg = black
    -- custom_moonfly.visual.b.bg = black
    -- -- custom_moonfly.insert.a.bg = black
    -- custom_moonfly.insert.b.bg = black
    require('lualine').setup {
      options = {
        icons_enabled = true,
        -- theme = custom_moonfly,
        theme = 'moonfly',
        section_separators = '',
        component_separators = '',
        disabled_filetypes = {
          statusline = {},
          winbar = {},
        },
        ignore_focus = {},
        -- always_divide_middle = true,
        -- always_show_tabline = true,
        globalstatus = true,
        refresh = {
          statusline = 1000,
          tabline = 1000,
          winbar = 1000,
        },
      },
      sections = {
        lualine_a = { 'mode' },
        lualine_b = { 'branch' },
        lualine_c = { 'filename', 'diagnostics' },
        lualine_x = { 'lsp_status', 'filetype' },
        lualine_y = { 'progress' },
        lualine_z = { 'location' },
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { 'filename' },
        lualine_x = {},
        lualine_y = {},
        lualine_z = {},
      },
      tabline = {
        lualine_a = { 'buffers' },
        lualine_b = {},
        lualine_c = {},
        lualine_x = {},
        -- lualine_c = { require('tabline').tabline_buffers },
        -- lualine_x = { require('tabline').tabline_tabs },
        lualine_y = {},
        lualine_z = { 'tabs' },
      },
      winbar = {},
      inactive_winbar = {},
      extensions = {},
    }
  end,
}
