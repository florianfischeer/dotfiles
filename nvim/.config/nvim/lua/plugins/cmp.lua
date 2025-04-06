return {
  -- nvim-cmp
  {
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
    dependencies = {
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-cmdline',

      -- Funktionale Klammern ergänzen
      'onsails/lspkind.nvim',          -- für hübsche Icons
      'hrsh7th/cmp-nvim-lsp-signature-help', -- Signaturhilfe
    },
    config = function()
      local cmp = require('cmp')
      local lspkind = require('lspkind')

      cmp.setup({
        preselect = "item",
        completion = {
          autocomplete = { require("cmp.types").cmp.TriggerEvent.TextChanged }, -- Sofort reagieren
          completeopt = 'menu,menuone,noselect',
          keyword_length = 1, -- Bereits nach 1 Zeichen Vorschläge
        },
        snippet = {
          expand = function(args)
            vim.snippet.expand(args.body) -- native snippets
          end,
        },
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },
        mapping = cmp.mapping.preset.insert({
          ['<C-b>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<C-e>'] = cmp.mapping.abort(),
          ['<C-y>'] = cmp.mapping.confirm({ select = true }),
        }),
        formatting = {
          format = lspkind.cmp_format({
            mode = 'symbol_text', -- z. B. "ƒ print"
            maxwidth = 50,
            ellipsis_char = '…',
          }),
        },
        sources = cmp.config.sources({
          { name = 'nvim_lsp' },
          { name = 'nvim_lsp_signature_help' }, -- Signaturhilfe beim Tippen
          { name = 'buffer' },
          { name = 'path' },
        }),
        experimental = {
          ghost_text = true, -- Vorschau im Text
        },
      })

      -- Cmdline für `/`, `?` und `:`
      cmp.setup.cmdline({ '/', '?' }, {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = 'buffer' }
        }
      })

      cmp.setup.cmdline(':', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = 'path' }
        }, {
          { name = 'cmdline' }
        }),
        matching = { disallow_symbol_nonprefix_matching = false }
      })
    end
  },

  -- LSPConfig
  {
    'neovim/nvim-lspconfig',
    event = { 'BufReadPre', 'BufNewFile' },
    config = function()
      local lspconfig = require('lspconfig')
      local capabilities = require('cmp_nvim_lsp').default_capabilities()

      -- Erweiterung für automatische Klammerergänzung bei Funktionskompletion
      capabilities.textDocument.completion.completionItem.snippetSupport = true
      capabilities.textDocument.completion.completionItem.insertTextFormat = 2

      local servers = { 'lua_ls', 'pyright', 'tsserver' } -- Beispiel-Server

      for _, server in ipairs(servers) do
        lspconfig[server].setup({
          capabilities = capabilities,
        })
      end
    end
  }
}
