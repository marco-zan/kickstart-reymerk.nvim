return {
  "folke/tokyonight.nvim",
  lazy = false,
  priority = 1000,
  opts = {
    transparent = true,
    -- style = "day"
  },
  config = function(_, opts)
    require('tokyonight').setup(opts)
    vim.cmd.colorscheme 'tokyonight'
    vim.api.nvim_set_hl(0, 'LineNr', { fg = "#9baeff"} )
  end
}
