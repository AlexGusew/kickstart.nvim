require('blink.cmp').setup {
  -- Use pure Lua fuzzy matcher (no Rust build step needed)
  fuzzy = { implementation = 'lua' },


  keymap = {
    preset = 'cmdline',
    -- VS Code-like: Tab confirms selected item or accepts ghost text

    -- ['<Tab>'] = { 'accept', 'fallback' },
    -- ['<S-Tab>'] = { 'fallback' },
    -- ['<CR>'] = { 'accept', 'fallback' },
    ['<C-Space>'] = { 'show', 'show_documentation', 'hide_documentation' },
    -- ['<C-e>'] = { 'cancel', 'fallback' },
    -- ['<C-k>'] = { 'select_prev', 'fallback' },
    -- ['<C-j>'] = { 'select_next', 'fallback' },
  },

  appearance = {
    -- Use mono Nerd Font icons (matches nvim-web-devicons)
    nerd_font_variant = 'mono',
  },

  completion = {
    -- Pre-select the first item like most IDEs
    list = { selection = { preselect = true, auto_insert = false } },

    -- Show inline ghost text preview of selected completion
    ghost_text = { enabled = true },

    -- Show docs popup automatically
    documentation = {
      auto_show = true,
      auto_show_delay_ms = 200,
    },

    menu = {
      -- Show kind icons in the menu
      draw = {
        columns = {
          { 'kind_icon' },
          { 'label',    'label_description', gap = 1 },
          { 'kind' },
        },
      },
    },
  },

  -- Parameter hints while typing function arguments
  signature = { enabled = true },

  sources = {
    default = { 'lsp', 'path', 'snippets', 'buffer' },
  },
}
