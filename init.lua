require 'core.lazy'
require 'core.keymaps'
require 'core.options'
require 'core.lsp'
require 'core.mason-path'

-- Import color theme based on environment variable NVIM_THEME
local default_color_scheme = 'gruvbox'
-- local env_var_nvim_theme = os.getenv 'NVIM_THEME' or default_color_scheme

-- Define a table of theme modules
local themes = {
  require 'plugins.themes.nord',
  require 'plugins.themes.cyberdream',
  require 'plugins.themes.tokyonight',
  require 'plugins.themes.astrotheme',
  require 'plugins.themes.kanagawa',
  require 'plugins.themes.gruvbox-material',
  require 'plugins.themes.catppuccin',
}

require('lazy').setup({
  themes,
  require 'plugins.neotree',
  require 'plugins.bufferline',
  require 'plugins.lualine',
  require 'plugins.treesitter',
  require 'plugins.telescope',
  require 'plugins.autocompletion',
  require 'plugins.none-ls',
  require 'plugins.lsp',
  require 'plugins.comment',
  require 'plugins.misc',
  require 'plugins.neogit',
  require 'plugins.gitsigns',
  require 'plugins.alpha',
  require 'plugins.indent-blankline',
  require 'plugins.which-key',
  require 'plugins.scrollbar',
  require 'plugins.vim-visual-multi',
}, {
  install = {
    missing = true,
  },
  checker = {
    enabled = true,
    notify = false,
  },
  change_detection = {
    enabled = true,
    notify = false,
  },
  ui = {
    -- If you have a Nerd Font, set icons to an empty table which will use the
    -- default lazy.nvim defined Nerd Font icons otherwise define a unicode icons table
    icons = vim.g.have_nerd_font and {} or {
      -- cmd = '⌘',
      -- config = '🛠',
      -- event = '📅',
      -- ft = '📂',
      -- init = '⚙',
      -- keys = '🗝',
      -- plugin = '🔌',
      -- runtime = '💻',
      -- require = '🌙',
      -- source = '📄',
      -- start = '🚀',
      -- task = '📌',
      -- lazy = '💤 ',
    },
  },
  performance = {
    rtp = {
      disabled_plugins = {
        "gzip",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
})

-- Função para configurar indentação
function SetIndent(width)
  vim.opt.tabstop = width     -- Número de espaços que um <Tab> representa
  vim.opt.softtabstop = width -- Número de espaços ao digitar <Tab>
  vim.opt.shiftwidth = width  -- Número de espaços usados para indentação automática
  vim.opt.expandtab = false   -- Usa espaços em vez de tabs reais
  print("Indent set to " .. width .. " spaces")
end

-- Comando para facilitar no modo de comando
vim.api.nvim_create_user_command("SetIndent", function(opts)
  SetIndent(tonumber(opts.args))
end, { nargs = 1 })

-- Function to check if a file exists
local function file_exists(file)
  local f = io.open(file, 'r')
  if f then
    f:close()
    return true
  else
    return false
  end
end

-- Path to the session file
local session_file = '.session.vim'

-- Check if the session file exists in the current directory
if file_exists(session_file) then
  -- Source the session file
  vim.cmd('source ' .. session_file)
end

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
