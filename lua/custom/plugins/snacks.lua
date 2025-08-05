return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  ---@type snacks.Config
  opts = {
    bigfile = { enabled = true },
    indent = { enabled = true },
    input = { enabled = true },
    quickfile = { enabled = true },
    scroll = { enabled = true },
    image = {
      enabled = true,
      inline = true
    },
    statuscolumn = { enabled = true },
    words = { enabled = true },
    explorer = {
      -- auto_close = true,
      enabled = true,
      hidden = true,      -- Show hidden files like .gitignore
      ignored = true,     -- Show files ignored by .gitignore
      follow_file = true, -- Automatically follow the current file
      tree = true,        -- Display as a tree structure
      watch = true,
    },
    picker = {
      enabled = true,
      hidden = true,
      ignored = true,
    },
  },
  keys = {
    -- { "<leader>s",  function() Snacks.scratch() end,          desc = "Toggle Scratch Buffer" },
    -- { "<leader>S",  function() Snacks.scratch.select() end,   desc = "Select Scratch Buffer" },
    { "<c-/>",      function() Snacks.terminal() end,         desc = "Toggle Terminal" },
    { "<c-/>",      function() Snacks.terminal() end,         desc = "Toggle Terminal",             mode = { 't' } },
    { "<leader>gB", function() Snacks.gitbrowse() end,        desc = "Git Browse",                  mode = { "n", "v" } },
    { "<leader>gb", function() Snacks.git.blame_line() end,   desc = "Git Blame Line" },
    { "<leader>gf", function() Snacks.lazygit.log_file() end, desc = "Lazygit Current File History" },
    { "<leader>gg", function() Snacks.lazygit() end,          desc = "Lazygit" },
    { "<leader>gl", function() Snacks.lazygit.log() end,      desc = "Lazygit Log (cwd)" },
  },
  init = function()
    vim.api.nvim_create_autocmd("User", {
      pattern = "VeryLazy",
      callback = function()
        _G.dd = function(...)
          Snacks.debug.inspect(...)
        end
        _G.bt = function()
          Snacks.debug.backtrace()
        end
        vim.print = _G.dd
        -- Create some toggle mappings
        Snacks.toggle.option("spell", { name = "Spelling" }):map("<leader>us")
        Snacks.toggle.option("wrap", { name = "Wrap" }):map("<leader>uw")
      end,
    })
  end,
  config = function(_, opts)
    -- Initialize the plugin with provided opts
    require("snacks").setup(opts)

    -- Set keymap safely *after* setup
    vim.keymap.set("n", "<leader>e", function()
      require("snacks").explorer()
    end, { desc = "Toggle [E]xplorer" })
  end,
}
