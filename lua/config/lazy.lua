local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system({ 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    error('Error cloning lazy.nvim:\n' .. out)
  end
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
  spec = {
    -- add LazyVim and import its plugins
    {
      'LazyVim/LazyVim',
      import = 'lazyvim.plugins',
      opts = {
        colorscheme = 'gruvbox-material',
        news = {
          lazyvim = true,
          neovim = true,
        },
      },
    },
    -- import any extras modules here
    { import = 'lazyvim.plugins.extras.coding.yanky' },
    -- { import = 'lazyvim.plugins.extras.coding.blink' },
    { import = 'lazyvim.plugins.extras.editor.dial' },
    { import = 'lazyvim.plugins.extras.editor.snacks_explorer' },
    { import = 'lazyvim.plugins.extras.linting.eslint' },
    { import = 'lazyvim.plugins.extras.formatting.prettier' },
    { import = 'lazyvim.plugins.extras.ui.alpha' },
    { import = 'lazyvim.plugins.extras.util.dot' },
    { import = 'lazyvim.plugins.extras.util.mini-hipatterns' },
    { import = 'lazyvim.plugins.extras.lang.vue' },
    { import = 'lazyvim.plugins.extras.lang.typescript' },
    { import = 'lazyvim.plugins.extras.lang.json' },
    { import = 'lazyvim.plugins.extras.lang.sql' },
    { import = 'lazyvim.plugins.extras.lang.tailwind' },
    { import = 'plugins' },
    { import = 'plugins.themes' },
  },
  {
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
    performance = {
      rtp = {
        disabled_plugins = {
          'gzip',
          'tarPlugin',
          'tohtml',
          'tutor',
          'zipPlugin',
        },
      },
    },
  },
})
