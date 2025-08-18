return {
  "dstein64/vim-startuptime",
  setup = function ()
  end,
  commands = {
    {
      "StartupTime",
      function()
        vim.cmd("StartupTime")
      end,
      desc = "Show Neovim startup time",
    },
  },
}
