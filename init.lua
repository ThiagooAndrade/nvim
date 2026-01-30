require('config.options')
require('config.lazy')
require('config.keymaps')
require('config.lsp')

vim.g.autoformat = false

vim.cmd [[colorscheme kanagawa]]

-- function Transparent(color)
--   color = color or "everforest"
--   vim.cmd.colorscheme(color)
--   vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
--   vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
-- end
-- Transparent()

require('transparent').clear_prefix('NeoTree')
require('transparent').clear_prefix('BufferLine')
require('transparent').clear_prefix('lualine')

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
