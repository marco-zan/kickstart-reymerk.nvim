
return {
  {
    'NMAC427/guess-indent.nvim', -- Detect tabstop and shiftwidth automatically
    opts = {
      on_tab_options = { -- A table of vim options when tabs are detected
        ["expandtab"] = false,
        ["autoindent"] = false,

        ["tabstop"] = 4,
        ["shiftwidth"] = 4
      },
      on_space_options = { -- A table of vim options when spaces are detected
        ["expandtab"] = true,
        ["tabstop"] = "detected", -- If the option value is 'detected', The value is set to the automatically detected indent size.
        ["softtabstop"] = "detected",
        ["shiftwidth"] = "detected",
      },
    }
  }
}

