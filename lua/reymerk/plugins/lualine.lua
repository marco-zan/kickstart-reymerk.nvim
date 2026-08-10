-- The statusline at the bottom, no need to know more, it just 
-- works, no problem

local function getProjectOrWords()
  local cwd = vim.fn.getcwd()
  if vim.fn.isdirectory(cwd .. '/.git') == 1 then
    local repo_name = cwd:match('([^/]+)$')
    local origin = vim.fn.system('git -C ' .. vim.fn.shellescape(cwd) .. ' remote get-url origin 2>/dev/null')
    origin = origin:gsub('%s+$', '')
    if origin:find('github') then
      return 'gh:' .. repo_name
    elseif origin:find('bitbucket') then
      return 'bb:' .. repo_name
    else
      return repo_name
    end
  else
    return tostring(vim.fn.wordcount().words)
  end
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
          { getProjectOrWords }
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
