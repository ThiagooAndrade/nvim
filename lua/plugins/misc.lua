-- Standalone plugins with less than 10 lines of config go here
return {
  {
    'nguyenvukhang/nvim-toggler',
    lazy = false,
    config = function()
      require('nvim-toggler').setup()
    end,
    keys = {
      { '<leader>i', "<cmd>lua require('nvim-toggler').toggle()<CR>", desc = 'Invert value' },
    },
  },
  {
    'mg979/vim-visual-multi',
    lazy = false,
  },
  {
    -- autoclose tags
    'windwp/nvim-ts-autotag',
  },
  {
    -- detect tabstop and shiftwidth automatically
    'tpope/vim-sleuth',
  },
  {
    -- Powerful Git integration for Vim
    'tpope/vim-fugitive',
  },
  {
    -- GitHub integration for vim-fugitive
    'tpope/vim-rhubarb',
  },
}
