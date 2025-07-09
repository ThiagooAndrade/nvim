require 'core.keymaps'
require 'core.options'

local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
  if vim.v.shell_error ~= 0 then
    error('Error cloning lazy.nvim:\n' .. out)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Import color theme based on environment variable NVIM_THEME
local default_color_scheme = 'kanagawa'
local env_var_nvim_theme = os.getenv 'NVIM_THEME' or default_color_scheme

-- Define a table of theme modules
local themes = {
  nord = 'plugins.themes.nord',
  cyberdream = 'plugins.themes.cyberdream',
  tokyonight = 'plugins.themes.tokyonight',
  astrotheme = 'plugins.themes.astrotheme',
  kanagawa = 'plugins.themes.kanagawa'
}

require('lazy').setup({
  require(themes[env_var_nvim_theme]),
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
  require 'plugins.scrollbar'
}, {
  ui = {
    -- If you have a Nerd Font, set icons to an empty table which will use the
    -- default lazy.nvim defined Nerd Font icons otherwise define a unicode icons table
    icons = vim.g.have_nerd_font and {} or {
      cmd = '⌘',
      config = '🛠',
      event = '📅',
      ft = '📂',
      init = '⚙',
      keys = '🗝',
      plugin = '🔌',
      runtime = '💻',
      require = '🌙',
      source = '📄',
      start = '🚀',
      task = '📌',
      lazy = '💤 ',
    },
  },
})

-- Função para configurar indentação
function SetIndent(width)
  vim.opt.tabstop = width     -- Número de espaços que um <Tab> representa
  vim.opt.softtabstop = width -- Número de espaços ao digitar <Tab>
  vim.opt.shiftwidth = width  -- Número de espaços usados para indentação automática
  vim.opt.expandtab = true    -- Usa espaços em vez de tabs reais
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
