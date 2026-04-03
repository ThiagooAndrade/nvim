return {
  'lopi-py/luau-lsp.nvim',
  opts = {},
  config = function()
    local function rojo_project()
      return vim.fs.root(0, function(name)
        return name:match ".+%.project%.json$"
      end)
    end

    if rojo_project() then
      vim.filetype.add {
        extension = {
          lua = function(path)
            return path:match "%.nvim%.lua$" and "lua" or "luau"
          end,
        },
      }
    end

    require('luau-lsp').setup({
      platform = {
        type = "roblox",
      },
      sourcemap = {
        enabled = true,
        autogenerate = true,
        rojo_path = 'rojo',
        rojo_project_file = 'default.project.json',
        include_non_scripts = true,
        sourcemap_file = 'sourcemap.json',
        generator_cmd = nil,
      },
      types = {
        roblox_security_level = 'PluginSecurity',
        definition_files = {
          -- ["@foo"] = "path/to/definitions/file",
          -- bar = "https://some.url/file.d.luau", -- @ will be added internally
        },
        documentation_files = { "https://raw.githubusercontent.com/MaximumADHD/Roblox-Client-Tracker/roblox/api-docs/en-us.json" },
      },
      fflags = {
        enable_by_default = true,
        enable_new_solver = true,
        sync = true,
        override = {
          LuauTableTypeMaximumStringifierLength = "100",
        },
      },
      plugin = {
        enabled = true,
        port = 3667,
      },
      server = {
        path = vim.fn.expand("~/.local/share/nvim/mason/bin/luau-lsp"),
        -- base_luaurc = nil,
      },
    })

    local schemas = {
      {
        name = "default.project.json",
        description = "JSON schema for Rojo project files",
        fileMatch = { "*.project.json" },
        url = "https://raw.githubusercontent.com/rojo-rbx/vscode-rojo/master/schemas/project.template.schema.json",
      },
    }

    vim.lsp.config("jsonls", {
      settings = {
        json = {
          -- without SchemaStore.nvim
          schemas = schemas,

          -- or if using SchemaStore.nvim
          -- schemas = require("schemastore").json.schemas { extra = schemas },

          validate = {
            enabled = true
          },
        },
      },
    })

  end
}
