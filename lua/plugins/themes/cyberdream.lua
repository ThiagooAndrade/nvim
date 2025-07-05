return  {
    "scottmckendry/cyberdream.nvim",
    lazy = false,
    config = function()
      require("cyberdream").setup {
        theme = "dark",
      }
      vim.cmd[[colorscheme cyberdream]]
    end,
}
