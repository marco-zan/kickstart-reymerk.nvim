
-- This function resolves a difference between neovim nightly (version 0.11) and stable (version 0.10)
---@param client vim.lsp.Client
---@param method vim.lsp.protocol.Method
---@param bufnr? integer some lsp support methods only in specific files
---@return boolean
local function client_supports_method(client, method, bufnr)
  if vim.fn.has 'nvim-0.11' == 1 then
    return client:supports_method(method, bufnr)
  else
    return client.supports_method(method, { bufnr = bufnr })
  end
end

-- LSP settings.
--  This function gets run when an LSP connects to a particular buffer.
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
  callback = function(event)
    -- NOTE: Remember that lua is a real programming language, and as such it is possible
    -- to define small helper and utility functions so you don't have to repeat yourself
    -- many times.
    --
    -- In this case, we create a function that lets us more easily define mappings specific
    -- for LSP related items. It sets the mode, buffer and description for us each time.
    local map = function(keys, func, desc, mode)
      mode = mode or 'n'
      vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = desc .. " (LSP)" })
    end

    map('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')

    map('<leader>cr', vim.lsp.buf.rename, '[C]ode [R]ename')
    map('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

    map('<leader>cR', require('telescope.builtin').lsp_references, '[C]ode [R]eferences')
    map('<leader>cD', require('telescope.builtin').lsp_references, '[C]ode References [D]')
    map('<leader>cI', vim.lsp.buf.implementation, '[C]ode [I]mplementation')
    -- map('<leader>cD', vim.lsp.buf.type_definition, '[C]ode Type [D]efinition')
    -- map('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
    -- map('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

    -- See `:help K` for why this keymap
    map('K', vim.lsp.buf.hover, 'Hover Documentation')
    map('<leader>ch', vim.lsp.buf.signature_help, '[ch] Code Signature Help')

    vim.keymap.set('i', '<C-k>', vim.lsp.buf.signature_help )

    -- Lesser used LSP functionality
    map('<leader>gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
    map('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
    map('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
    map('<leader>wl', function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, '[W]orkspace [L]ist Folders')

    map('<leader>ccd', ":Copilot disable<CR>", '[C]ode [C]opilot [D]isable')
    map('<leader>cce', ":Copilot enable<CR>", '[C]ode [C]opilot [E]nable')

    local bufnr = event.buf
    -- Create a command `:Format` local to the LSP buffer
    vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
      vim.lsp.buf.format()
    end, { desc = 'Format current buffer with LSP' })

    if client and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_inlayHint, event.buf) then
      map('<leader>cth', function()
        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
      end, '[C]ode [T]oggle Inlay [H]ints')
    end
  end

})

local vue_language_server_path = vim.fn.expand '$MASON/packages' .. '/vue-language-server' .. '/node_modules/@vue/language-server'

-- Enable the following language servers
--  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
--
--  Add any additional override configuration in the following tables. Available keys are:
--  - cmd (table): Override the default command used to start the server
--  - filetypes (table): Override the default list of associated filetypes for the server
--  - capabilities (table): Override fields in capabilities. Can be used to disable certain LSP features.
--  - settings (table): Override the default settings passed when initializing the server.
--        For example, to see the options for `lua_ls`, you could go to: https://luals.github.io/wiki/settings/
local servers = {
  clangd = {},
  basedpyright = {},

  html = {
    filetypes = { 'html', 'htmldjango' },
  },
  htmx = {
    filetypes = { 'html', 'htmldjango' },
  },


  jinja_lsp = {
    cmd = { '/home/reymerk/.cargo/bin/jinja-lsp'},
    filetypes = {'htmldjango', 'html', 'jinja', 'python'},
    settings = {
      root_dir = PROJECT_ROOT,
      init_options = {
        templates = './templates',
        backend = {'./src'},
        lang = "python"
      }
    }
  },
  lua_ls = {
    settings = {
      Lua = {
        workspace = { checkThirdParty = false },
        telemetry = { enable = false },
      },
    }
  },

  ts_ls = {
    init_options = {
      plugins = {
        {
          name = '@vue/typescript-plugin',
          location = vue_language_server_path,
          languages = { 'vue' },
        },
      },
    },
    filetypes = {
      "javascript",
      "typescript",
      "vue",
    },
  },

  vue_ls = {
  },


}


-- Enable code folding / Ufo Setup
local ufo = require('ufo')

vim.opt.foldcolumn = '0'
vim.opt.foldlevel = 99
vim.opt.foldlevelstart = 99
vim.opt.foldenable = true

vim.keymap.set('n', 'zR', ufo.openAllFolds)
vim.keymap.set('n', 'zM', ufo.closeAllFolds)

-- vim.lsp.set_log_level("debug")
-- Setup neovim lua configuration
require('neodev').setup()

-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
local capabilities = vim.tbl_deep_extend(
  "force",
  vim.lsp.protocol.make_client_capabilities(),
  -- returns configured operations if setup() was already called
  -- or default operations if not
  require'lsp-file-operations'.default_capabilities()
)

-- For code folding / ufo
capabilities.textDocument.foldingRange = {
  dynamicRegistration = false,
  lineFoldingOnly = true
}
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)
capabilities.offsetEncoding = "utf-8"

capabilities.workspace = {
  didChangeWatchedFiles = {
    dynamicRegistration = true
  }
}

local ensure_installed = vim.tbl_keys(servers or {})
vim.list_extend(ensure_installed, {
  'stylua', -- Used to format Lua code
})
require('mason-tool-installer').setup { ensure_installed = ensure_installed }

require('mason-lspconfig').setup {
  ensure_installed = {}, -- explicitly set to an empty table (Kickstart populates installs via mason-tool-installer)
  automatic_installation = false
}

for server_name, server in pairs(servers) do
  -- This handles overriding only values explicitly passed
  -- by the server configuration above. Useful when disabling
  -- certain features of an LSP (for example, turning off formatting for ts_ls)
  server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
  require('lspconfig')[server_name].setup(server)
end

-- End folding configuration -- this should be after lspconfig setup
ufo.setup()

require("copilot_cmp").setup()


-- nvim-cmp setup
local cmp = require 'cmp'
local luasnip = require 'luasnip'
require('luasnip.loaders.from_vscode').lazy_load()
luasnip.config.setup {}

local compare = cmp.config.compare

-- General cmp setup
cmp.setup {
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert {
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete {},
    ['<CR>'] = cmp.mapping.confirm {
      -- This means that it will not replace the already written text 
      -- and do not automatically select the first option
      behavior = cmp.ConfirmBehavior.Insert,
      select = false,
    },
    ['<C-j>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_locally_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<C-k>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        -- Disable the annoying C-k not working for signature help 
        -- on insert mode with copilot and such
        if cmp.get_active_entry() == nil then
          fallback()
        else
          cmp.select_prev_item()
        end
      elseif luasnip.locally_jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { 'i', 's' }),
  },
  -- formatting = {
  --   format = lspkind.cmp_format({
  --     mode = "symbol",
  --     max_width = 50,
  --     symbol_map = { Copilot = "" }
  --   })
  -- },
  sources = {
    { name = 'nvim_lsp' },
    { name = 'copilot'},
    { name = 'luasnip' },
    { name = 'path' },
  },
  sorting = {
    priority_weight = 2,
    comparators = {
      require('copilot_cmp.comparators').prioritize,

      -- compare.offset, -- not good at all - they say -- but we try that
      compare.exact,
      compare.score, -- based on :  score = score + ((#sources - (source_index - 1)) * sorting.priority_weight)
      compare.recently_used,
      compare.locality,
      -- compare.order,
      -- compare.scopes, -- what?
      -- compare.sort_text,
      -- compare.kind,
      -- compare.length, -- useless 
    }
  },
}

-- configure the autopairs (idk if it is already working or not without it)
local cmp_autopairs = require('nvim-autopairs.completion.cmp')
cmp.event:on(
  'confirm_done',
  cmp_autopairs.on_confirm_done()
)
