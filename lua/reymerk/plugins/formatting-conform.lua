return {
  {
    'stevearc/conform.nvim',
    opts = {
      formatters_by_ft = {
        javascript = { "prettier" },
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
