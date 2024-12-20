
-- LSP settings.
--  This function gets run when an LSP connects to a particular buffer.
local on_attach = function(_, bufnr)
  -- NOTE: Remember that lua is a real programming language, and as such it is possible
  -- to define small helper and utility functions so you don't have to repeat yourself
  -- many times.
  --
  -- In this case, we create a function that lets us more easily define mappings specific
  -- for LSP related items. It sets the mode, buffer and description for us each time.
  local nmap = function(keys, func, desc)
    if desc then
      desc = 'LSP: ' .. desc
    end

    vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
  end

  nmap('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')

  nmap('<leader>cr', vim.lsp.buf.rename, '[C]ode [R]ename')
  nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

  nmap('<leader>cR', require('telescope.builtin').lsp_references, '[C]ode [R]eferences')
  nmap('<leader>cD', require('telescope.builtin').lsp_references, '[C]ode References [D]')
  nmap('<leader>cI', vim.lsp.buf.implementation, '[C]ode [I]mplementation')
  -- nmap('<leader>cD', vim.lsp.buf.type_definition, '[C]ode Type [D]efinition')
  -- nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
  -- nmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

  -- See `:help K` for why this keymap
  nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
  nmap('<leader>ch', vim.lsp.buf.signature_help, '[ch] Code Signature Help')

  vim.keymap.set('i', '<C-k>', vim.lsp.buf.signature_help )

  -- Lesser used LSP functionality
  nmap('<leader>gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
  nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
  nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
  nmap('<leader>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, '[W]orkspace [L]ist Folders')

  -- Create a command `:Format` local to the LSP buffer
  vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
    vim.lsp.buf.format()
  end, { desc = 'Format current buffer with LSP' })

end

-- Enable the following language servers
--  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
--
--  Add any additional override configuration in the following tables. They will be passed to
--  the `settings` field of the server config. You must look up that documentation yourself.
local servers = {
  clangd = {},
  pyright = {},

  html = {
    filetypes = { 'html', 'htmldjango' },
  },
  htmx = {
    filetypes = { 'html', 'htmldjango' },
  },


  jinja_lsp = {
    cmd = { '/home/reymerk/.cargo/bin/jinja-lsp'},
    filetypes = {'htmldjango', 'html', 'jinja', 'python'},
    root_dir = PROJECT_ROOT,
    init_options = {
      templates = './templates',
      backend = {'./src'},
      lang = "python"
    }
  },
  lua_ls = {
    Lua = {
      workspace = { checkThirdParty = false },
      telemetry = { enable = false },
    },
  },
}
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
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)
capabilities.offsetEncoding = "utf-8"

capabilities.workspace = {
  didChangeWatchedFiles = {
    dynamicRegistration = true
  }
}

-- Setup mason so it can manage external tooling
require('mason').setup()

-- Ensure the servers above are installed
local mason_lspconfig = require 'mason-lspconfig'

mason_lspconfig.setup {
  ensure_installed = vim.tbl_keys(servers),
}

mason_lspconfig.setup_handlers {
  function(server_name)
    require('lspconfig')[server_name].setup {
      capabilities = capabilities,
      on_attach = on_attach,
      settings = servers[server_name],
      filetypes = (servers[server_name] or {}).filetypes,
    }
  end,
}

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
    { name = 'copilot'},
    { name = 'nvim_lsp' },
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
