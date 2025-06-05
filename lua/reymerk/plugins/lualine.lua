-- The statusline at the bottom, no need to know more, it just 
-- works, no problem

-- Provide the number of words of the document. Useful more 
-- for writing than actual code, but i figured is better to have 
-- it than not have it
local function getWords()
  return tostring(vim.fn.wordcount().words)
end

return {
  {
    'nvim-lualine/lualine.nvim',
    -- See `:help lualine.txt`
    opts = {
      options = {
        globalstatus = true,
        icons_enabled = true,
        theme = 'tokyonight',
        -- component_separators = '|',
        -- section_separators = ''
        component_separators = { left = '', right = ''},
        section_separators = { left = '', right = ''},
      },
      sections = {
        lualine_a = {"filetype"},
        lualine_b = {'diff', 'diagnostics'},
        lualine_c = {'branch'},
        lualine_x = {'encoding', 'fileformat'},
        lualine_y = {
          "location",
          { getWords }
        },
        lualine_z = { "mode" }
      },
      winbar = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {
          {
            'filename',
            file_status = true,
            path = 1
          }
        },
        lualine_x = {},
        lualine_y = {},
        lualine_z = {}
      },

      inactive_winbar = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {
          {
            'filename',
            file_status = true,
            path = 1
          }
        },
        lualine_x = {},
        lualine_y = {},
        lualine_z = {}
      }
    },
  },
}
