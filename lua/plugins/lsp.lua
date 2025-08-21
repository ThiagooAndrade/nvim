return { -- LSP Configuration & Plugins
  'neovim/nvim-lspconfig',
  dependencies = {
    -- Automatically install LSPs and related tools to stdpath for neovim
    'williamboman/mason.nvim',
    'williamboman/mason-lspconfig.nvim',
    'WhoIsSethDaniel/mason-tool-installer.nvim',

    -- Useful status updates for LSP.
    -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
    {
      'j-hui/fidget.nvim',
      tag = 'v1.4.0',
      opts = {
        progress = {
          display = {
            done_icon = '✓', -- Icon shown when all LSP progress tasks are complete
          },
        },
        notification = {
          window = {
            winblend = 0, -- Background color opacity in the notification window
          },
        },
      },
    },
  },
  config = function()
    -- Define os servidores e suas configurações
    local tsdk_path = "/home/thiago/.nvm/versions/node/v22.16.0/lib/node_modules/typescript/lib"

    local on_attach = function(client, bufnr)
      -- Desativa documentHighlight para este cliente
      client.server_capabilities.documentHighlightProvider = false

      -- Aqui você pode continuar suas outras configurações on_attach
      -- Por exemplo, seus mapeamentos de tecla, etc
    end
    local servers = {
      ts_ls = {
        cmd = { "typescript-language-server", "--stdio" },
        filetypes = {
          "javascript",
          "javascriptreact",
          "javascript.jsx",
          "typescript",
          "typescriptreact",
          "typescript.tsx"
        },
        init_options = {
          typescript = {
            tsdk = tsdk_path -- opcional, útil para type checking
          }
        },
      },
      -- vtsls = {
      --   -- on_attach = on_attach,
      --   filetypes = { "typescript", "javascript", "vue" },
      --   init_options = {
      --     typescript = {
      --       tsdk = tsdk_path -- opcional, útil para type checking
      --     }
      --   },
      -- },
      -- vue_ls = {
      --   cmd = { "vue-language-server", "--stdio" },
      --   filetypes = { "vue", "javascript", "typescript", "javascriptreact", "typescriptreact" },
      --   init_options = {
      --     typescript = {
      --       tsdk = tsdk_path -- opcional, útil para type checking
      --     }
      --   },
      -- },
      lua_ls = {
        settings = {
          Lua = {
            runtime = { version = 'LuaJIT' },
            workspace = {
              checkThirdParty = false,
              library = {
                '${3rd}/luv/library',
                unpack(vim.api.nvim_get_runtime_file('', true)),
              },
            },
            completion = {
              callSnippet = 'Replace',
            },
            telemetry = { enable = false },
            diagnostics = { disable = { 'missing-fields' } },
          },
        },
      },
      jsonls = {},
      sqlls = {},
      tailwindcss = {
        filetypes = {
          "html", "css", "scss"
        },
      },
      html = {
        filetypes = {
          'html',            -- arquivos HTML padrão
          'typescriptreact', -- arquivos .tsx
          'javascriptreact', -- arquivos .jsx
          'angular',         -- (Angular geralmente usa HTML puro)
          'twig', 'hbs'      -- se estiver usando esses
        }
      },
      cssls = {
        filetypes = { "vue", "css", "scss", "less" },
        settings = {
          css = { validate = true },
          scss = { validate = true },
          less = { validate = true },
          vue = { validate = true }
        },
        init_options = {
          provideFormatter = true
        },
      },
    }

    vim.api.nvim_create_autocmd('LspAttach', {
      group = vim.api.nvim_create_augroup('lsp-attach', { clear = true }),
      -- Create a function that lets us more easily define mappings specific LSP related items.
      -- It sets the mode, buffer and description for us each time.

      callback = function(event)
        local map = function(keys, func, desc)
          vim.keymap.set('n', keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
        end

        -- Jump to the definition of the word under your cursor.
        --  This is where a variable was first declared, or where a function is defined, etc.
        --  To jump back, press <C-T>.
        map('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')

        -- Find references for the word under your cursor.
        map('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')

        -- Jump to the implementation of the word under your cursor.
        --  Useful when your language has ways of declaring types without an actual implementation.
        map('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')

        -- Jump to the type of the word under your cursor.
        --  Useful when you're not sure what type a variable is and you want to see
        --  the definition of its *type*, not where it was *defined*.
        map('<leader>D', require('telescope.builtin').lsp_type_definitions, 'Type [D]efinition')

        -- Fuzzy find all the symbols in your current document.
        --  Symbols are things like variables, functions, types, etc.
        map('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')

        -- Fuzzy find all the symbols in your current workspace
        --  Similar to document symbols, except searches over your whole project.
        map('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

        -- Rename the variable under your cursor
        --  Most Language Servers support renaming across files, etc.
        map('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')

        -- Execute a code action, usually your cursor needs to be on top of an error
        -- or a suggestion from your LSP for this to activate.
        map('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

        -- Opens a popup that displays documentation about the word under your cursor
        --  See `:help K` for why this keymap
        map('K', vim.lsp.buf.hover, 'Hover Documentation')

        -- WARN: This is not Goto Definition, this is Goto Declaration.
        --  For example, in C this would take you to the header
        map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

        map('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
        map('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
        map('<leader>wl', function()
          print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        end, '[W]orkspace [L]ist Folders')

        -- The following two autocommands are used to highlight references of the
        -- word under your cursor when your cursor rests there for a little while.
        --    See `:help CursorHold` for information about when this is executed
        --
        -- When you move your cursor, the highlights will be cleared (the second autocommand).
        local client = vim.lsp.get_client_by_id(event.data.client_id)
        -- if client and client.server_capabilities.documentFormattingProvider then
        --   -- Desabilita qualquer format on save automático
        --   vim.api.nvim_clear_autocmds({ group = "format_on_save", buffer = args.buf })
        -- end
        if client and client.server_capabilities.documentHighlightProvider then
          vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
            buffer = event.buf,
            callback = vim.lsp.buf.document_highlight,
          })

          vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
            buffer = event.buf,
            callback = vim.lsp.buf.clear_references,
          })
        end
      end,
    })
    local lspconfig = require("lspconfig")

    lspconfig.ts_ls.setup(servers.ts_ls)
    -- lspconfig.vue_ls.setup(servers.vue_ls)
    lspconfig.cssls.setup(servers.cssls)
    -- lspconfig.vtsls.setup(servers.vtsls)

    -- Ensure the servers and tools above are installed
    require('mason').setup()

    require('mason-tool-installer').setup { ensure_installed = {
      "ts_ls",
      -- "vtsls",
      -- "vue_ls",
      "lua_ls",
      "jsonls",
      "html",
      "tailwindcss",
      "sqlls",
      "cssls"
    } }

    require('mason-lspconfig').setup {
      handlers = {
        -- Handler específico para ts_ls
        ["ts_ls"] = function()
          local server = servers["ts_ls"]
          server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
          require("lspconfig").ts_ls.setup(server)
        end,
        -- Handler específico para Vue
        ["vue_ls"] = function()
          local server = servers["vue_ls"]
          server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
          require("lspconfig").vue_ls.setup(server)
        end,
        function(server_name)
          local server = servers[server_name] or {}
          -- This handles overriding only values explicitly passed
          -- by the server configuration above. Useful when disabling
          -- certain features of an LSP (for example, turning off formatting for tsserver)
          server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
          require('lspconfig')[server_name].setup(server)
        end,
      },
    }
  end,
}
