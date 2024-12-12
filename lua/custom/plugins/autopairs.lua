-- File: lua/custom/plugins/autopairs.lua

return {
  'windwp/nvim-autopairs',
  lazy = false,
  config = function (setup_opts)

    local Rule = require('nvim-autopairs.rule')
    local npairs = require('nvim-autopairs')
    local cond = require 'nvim-autopairs.conds'

    npairs.setup(setup_opts)

    npairs.add_rule(
      Rule("{%","%","htmldjango")
    )

    -- npairs.add_rule(
    --   Rule("{%","%}","html")
    -- )

  end
  -- use opts = {} for passing setup options
  -- this is equivalent to setup({}) function
}
