return {
  'yetone/avante.nvim',
  build = vim.fn.has 'win32' ~= 0 and 'powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false' or 'make',
  event = 'VeryLazy',
  version = false,
  opts = {
    provider = 'copilot',
    mode = 'agentic',

    providers = {
      copilot = {
        model = 'gpt-4o',

        timeout = 30000,
        extra_request_body = {
          temperature = 0,
          max_tokens = 4096,
        },
      },
    },

    instructions_file = 'CLAUDE.md',
  },
  dependencies = {
    'nvim-lua/plenary.nvim',
    'MunifTanjim/nui.nvim',
    'stevearc/dressing.nvim',
    'nvim-tree/nvim-web-devicons',
    {
      'zbirenbaum/copilot.lua',
      config = function()
        require('copilot').setup {
          -- Disable the default ghost text if you want Avante to handle everything
          suggestion = { enabled = false },
          panel = { enabled = false },
        }
      end,
    },
    {
      'MeanderingProgrammer/render-markdown.nvim',
      opts = { file_types = { 'markdown', 'Avante' } },
      ft = { 'markdown', 'Avante' },
    },
  },
}
