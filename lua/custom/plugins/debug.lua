-- Lean, lazy-loaded DAP debugging for PHP (xdebug) and Python (debugpy)
--
-- Nothing is loaded at startup. The whole stack activates only on the first
-- <F5> or :Dap* command.

return {
  'mfussenegger/nvim-dap',
  dependencies = {
    'jay-babu/mason-nvim-dap.nvim',
  },
  cmd = {
    'DapContinue',
    'DapToggleBreakpoint',
    'DapStepInto',
    'DapStepOver',
    'DapStepOut',
    'DapTerminate',
  },
  keys = {
    { '<F5>',  function() require('dap').continue() end,     desc = 'DAP: Start / continue' },
    { '<F9>',  function() require('dap').toggle_breakpoint() end, desc = 'DAP: Toggle breakpoint' },
    { '<F10>', function() require('dap').step_over() end,     desc = 'DAP: Step over' },
    { '<F11>', function() require('dap').step_into() end,     desc = 'DAP: Step into' },
    { '<F12>', function() require('dap').step_out() end,      desc = 'DAP: Step out' },
    { '<F6>',  function() require('dap.ui.widgets').hover() end,        desc = 'DAP: Hover value' },
    { '<F7>',  function()
                 local w = require('dap.ui.widgets')
                 w.centered_float(w.scopes)
               end,                                              desc = 'DAP: Scopes float' },
    { '<F8>',  function() require('dap').repl.open() end,       desc = 'DAP: Repl' },
  },
  config = function()
    local dap = require('dap')

    -- Auto-install debugpy + php-debug-adapter into the existing ~/.local/share/nvim/mason
    -- and register their adapter + launch configurations.
    require('mason-nvim-dap').setup({
      ensure_installed = { 'python', 'php' },
      handlers = {},
    })

    -- Nerd Font breakpoint icons (replaces the plain B/C/R/L glyphs).
    -- NOTE: the `text` must be a REAL glyph. An empty string ('') makes vim
    -- silently fail to place the sign, so toggle_breakpoint() never registers
    -- a breakpoint (it is not sent to the debug adapter).
    if vim.g.have_nerd_font then
      vim.fn.sign_define('DapBreakpoint',           { text = '', texthl = 'DiagnosticError' })
      vim.fn.sign_define('DapBreakpointCondition',  { text = '', texthl = 'DiagnosticWarn' })
      vim.fn.sign_define('DapBreakpointRejected',   { text = '', texthl = 'DiagnosticError' })
      vim.fn.sign_define('DapLogPoint',             { text = '', texthl = 'DiagnosticInfo' })
      vim.fn.sign_define('DapStopped',              { text = '', texthl = 'DiagnosticInfo', linehl = 'debugPC' })
    end
  end,
}
