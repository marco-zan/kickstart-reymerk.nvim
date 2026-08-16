return {
  {
    'stevearc/conform.nvim',
    opts = {
      formatters_by_ft = {
        javascript = { "prettierd", "prettier", stop_after_first = true },
        lua = { "stylua" },
        -- typescript = { "prettier" },
        -- python = { "black" },
        -- go = { "gofmt" },
        -- rust = { "rustfmt" },
        -- Add your languages here
      },
    },
  },
}
