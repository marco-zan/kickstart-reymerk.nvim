return {
  "folke/tokyonight.nvim",
  lazy = false,
  priority = 1000,
  opts = {
    transparent = true,
    -- style = "day"
  },
  config = function(_, opts)
    local config = {
      on_colors = function(colors)
        colors.terminal_black = "#8b8d99"
      end,
      on_highlights = function(highlights, colors)
        -- Change the foreground of the LineNr highlight group
        -- Replace "#YourDesiredColor" with the hex code you want
        local lineNr = { fg =  "#a5aac9" }
        highlights.LineNr = lineNr -- Example: A muted blue/grey
        highlights.LineNrAbove = lineNr -- Example: A muted blue/grey
        highlights.LineNrBelow = lineNr -- Example: A muted blue/grey


        -- Optional: You might also want to change the current line number color
        -- If you want it to be the same as the regular line number:
        -- highlights.CursorLineNr = { fg = "#565f89" }
        -- Or if you want it different (e.g., brighter):
        highlights.CursorLineNr = { fg = "#8a8da6", bold = true }
      end
    }
    config = vim.tbl_deep_extend("force", config, opts)

    require('tokyonight').setup(config)
    vim.cmd.colorscheme 'tokyonight'
    -- vim.api.nvim_set_hl(0, 'LineNr', { fg = "#9baeff"} )
  end
}
