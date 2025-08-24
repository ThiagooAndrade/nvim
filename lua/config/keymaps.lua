-- For conciseness
local opts = { noremap = true, silent = true }

-- Atalhos rápidos
vim.keymap.set('n', '<leader>i2', function()
  SetIndent(2)
end, { desc = 'Set indent to 2 spaces' })
vim.keymap.set('n', '<leader>i4', function()
  SetIndent(4)
end, { desc = 'Set indent to 4 spaces' })

vim.keymap.set('n', '<leader><A-f>', function()
  vim.lsp.buf.format({ async = true })
end, { desc = 'Formatar buffer', noremap = true, silent = true })

-- Disable the spacebar key's default behavior in Normal and Visual modes
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Allow moving the cursor through wrapped lines with j, k
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- clear highlights
vim.keymap.set('n', '<Esc>', ':noh<CR>', opts)

-- save file
vim.keymap.set('n', '<C-s>', '<cmd> w <CR>', opts)

-- save file without auto-formatting
vim.keymap.set('n', '<leader>sn', '<cmd>noautocmd w <CR>', opts)

-- quit file
vim.keymap.set('n', '<C-q>', '<cmd> q <CR>', opts)

-- delete single character without copying into register
vim.keymap.set('n', 'x', '"_x', opts)

-- Vertical scroll and center
-- vim.keymap.set('n', '<C-d>', '<C-d>zz', opts)
-- vim.keymap.set('n', '<C-u>', '<C-u>zz', opts)

-- Find and center
vim.keymap.set('n', 'n', 'nzzzv')
vim.keymap.set('n', 'N', 'Nzzzv')

-- Resize with arrows
vim.keymap.set('n', '<Up>', ':resize -2<CR>', opts)
vim.keymap.set('n', '<Down>', ':resize +2<CR>', opts)
vim.keymap.set('n', '<Left>', ':vertical resize -2<CR>', opts)
vim.keymap.set('n', '<Right>', ':vertical resize +2<CR>', opts)

-- Buffers
vim.keymap.set('n', '<Tab>', ':bnext<CR>', opts)
vim.keymap.set('n', '<S-Tab>', ':bprevious<CR>', opts)
vim.keymap.set('n', '<leader>x', ':Bdelete!<CR>', opts) -- close buffer
vim.keymap.set('n', '<leader>b', '<cmd> enew <CR>', opts) -- new buffer

-- Increment/decrement numbers
vim.keymap.set('n', '<leader>+', '<C-a>', opts) -- increment
vim.keymap.set('n', '<leader>-', '<C-x>', opts) -- decrement

-- Window management
vim.keymap.set('n', '<leader>v', '<C-w>v', opts) -- split window vertically
vim.keymap.set('n', '<leader>h', '<C-w>s', opts) -- split window horizontally
vim.keymap.set('n', '<leader>se', '<C-w>=', opts) -- make split windows equal width & height
vim.keymap.set('n', '<leader>xs', ':close<CR>', opts) -- close current split window

-- Navigate between splits
vim.keymap.set('n', '<C-h>', ':wincmd h<CR>', opts)
vim.keymap.set('n', '<C-l>', ':wincmd l<CR>', opts)

-- Tabs
vim.keymap.set('n', '<leader>to', ':tabnew<CR>', opts) -- open new tab
vim.keymap.set('n', '<leader>tx', ':tabclose<CR>', opts) -- close current tab
vim.keymap.set('n', '<leader>tn', ':tabn<CR>', opts) --  go to next tab
vim.keymap.set('n', '<leader>tp', ':tabp<CR>', opts) --  go to previous tab

-- Toggle line wrapping
vim.keymap.set('n', '<leader>uw', '<cmd>set wrap!<CR>', opts)

-- Press jk fast to exit insert mode
vim.keymap.set('i', 'jk', '<ESC>', opts)
vim.keymap.set('i', 'kj', '<ESC>', opts)

-- Keep last yanked when pasting
vim.keymap.set('v', 'p', '"_dP', opts)

-- Explicitly yank to system clipboard (highlighted and entire row)
vim.keymap.set({ 'n', 'v' }, '<leader>y', [["+y]])
vim.keymap.set('n', '<leader>Y', [["+Y]])

-- Save and load session
vim.keymap.set('n', '<leader>ss', ':mksession! .session.vim<CR>', { noremap = true, silent = false })
vim.keymap.set('n', '<leader>sl', ':source .session.vim<CR>', { noremap = true, silent = false })

-- limpar o highlight sem precisar digitar :noh:
vim.keymap.set('n', '<Esc>', '<Esc>:nohlsearch<CR>', { noremap = true, silent = true })

-- Gitsigns
vim.keymap.set('n', '<leader>gp', '<cmd>Gitsigns preview_hunk<CR>', { desc = 'Preview git hunk' })
vim.keymap.set('n', ']g', '<cmd>Gitsigns next_hunk<CR>', { desc = 'Next git hunk' })
vim.keymap.set('n', '[g', '<cmd>Gitsigns prev_hunk<CR>', { desc = 'Previous git hunk' })
vim.keymap.set('n', '<leader>gis', '<cmd>Gitsigns stage_hunk<CR>', { desc = 'Stage git hunk' })
vim.keymap.set('n', '<leader>gir', '<cmd>Gitsigns reset_hunk<CR>', { desc = 'Reset git hunk' })

-- Neotree reveal and close
-- vim.keymap.set('n', '<leader>e', '<Cmd>Neotree reveal<CR>')

-- move cursor windows com Ctrl-j/k
vim.keymap.set('n', '<C-j>', '<C-w>j', { noremap = true, silent = true, desc = 'Window below' })
vim.keymap.set('n', '<C-k>', '<C-w>k', { noremap = true, silent = true, desc = 'Window above' })

-- desbind esc key
vim.keymap.set('i', '<Esc>', '<Nop>', { noremap = true })

vim.keymap.set('v', '<leader>f', function()
  local start_pos = vim.api.nvim_buf_get_mark(0, '<')
  local end_pos = vim.api.nvim_buf_get_mark(0, '>')
  vim.lsp.buf.format({
    range = {
      ['start'] = { start_pos[1], start_pos[2] },
      ['end'] = { end_pos[1], end_pos[2] + 1 },
    },
  })
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<Esc>', true, false, true), 'n', false)
end, { desc = 'Format selected range', noremap = true, silent = true })

-- Telescope colorscheme picker
vim.keymap.set('n', '<leader>tt', function()
  require('telescope.builtin').colorscheme({
    enable_preview = true, -- preview ao vivo dos temas
  })
end, { desc = 'Trocar tema com Telescope' })

-- Função para configurar indentação
function SetIndent(width)
  vim.opt.tabstop = width -- Número de espaços que um <Tab> representa
  vim.opt.softtabstop = width -- Número de espaços ao digitar <Tab>
  vim.opt.shiftwidth = width -- Número de espaços usados para indentação automática
  vim.opt.expandtab = true -- Usa espaços em vez de tabs reais
  print('Indent set to ' .. width .. ' spaces')
end

-- Comando para facilitar no modo de comando
vim.api.nvim_create_user_command('SetIndent', function(opts)
  SetIndent(tonumber(opts.args))
end, { nargs = 1 })
