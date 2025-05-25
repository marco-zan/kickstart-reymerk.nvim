return {
  "folke/todo-comments.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function ()
    require("todo-comments").setup()
    vim.keymap.set('n', '<leader>tq', "<cmd>TodoQuickFix<cr>", { desc = "[T]odo in [Q]uickfix list" })
    vim.keymap.set('n', '<leader>tt', "<cmd>TodoTelescope<cr>", { desc = "[T]odo [T]elescope"} )
  end
}
