return {
  "Pocco81/auto-save.nvim",
  config = function()
    require("auto-save").setup {
      
      enabled = false,
      execution_message = {
        message = function() -- message to print on save
          return ("AutoSave: saved at " .. vim.fn.strftime("%H:%M:%S"))
        end,
        dim = 0.18, -- dim the color of `message`
        cleaning_interval = 0, -- (milliseconds) automatically clean MsgArea after displaying `message`. See :h MsgArea
      },
      trigger_events = {"InsertLeave", "TextChanged"},
      debounce_delay = 1000, -- saves the file at most every `debounce_delay` milliseconds
    }
  end,
  keys = {
    { "<leader>fa", ":ASToggle<CR>", desc = "Load autosave" },
  },
}
