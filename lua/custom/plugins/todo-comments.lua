return {
  "folke/todo-comments.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  keys = {
    {
      'tq',
      "<cmd>TodoQuickFix<cr>",
      desc = "[T]odo in [Q]uickfix list",
    },
    {
      'tt',
      "<cmd>TodoTelescope<cr>",
      desc = "[T]odo [T]elescope",
    }
  },
  opts = {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
  }
}
