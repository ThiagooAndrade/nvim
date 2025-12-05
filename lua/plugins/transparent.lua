return {
  'xiyaowong/transparent.nvim',
  lazy = false,
  config = function()
    require('transparent').setup({
      -- table: default groups
      -- groups = {
      --   'Normal',
      --   'NormalFloat',
      --   'NormalNC',
      --   'Comment',
      --   'Constant',
      --   'Special',
      --   'Identifier',
      --   'Statement',
      --   'PreProc',
      --   'Type',
      --   'Underlined',
      --   'Todo',
      --   'String',
      --   'Function',
      --   'Conditional',
      --   'Repeat',
      --   'Operator',
      --   'Structure',
      --   'LineNr',
      --   'NonText',
      --   'SignColumn',
      --   'CursorLine',
      --   'CursorLineNr',
      --   'StatusLine',
      --   'StatusLineNC',
      --   'EndOfBuffer',
      -- },
      -- table: additional groups that should be cleared
      -- extra_groups = {},
      -- table: groups you don't want to clear
      exclude_groups = {
        'StatusLine',
        'StatusLineNC',
        'StatusLineTerm',
        'StatusLineTermNC',
        'TabLine',
        'TabLineFill',
        'TabLineSel',
        "NormalFloat"
      },
      -- function: code to be executed after highlight groups are cleared
      -- Also the user event "TransparentClear" will be triggered
      on_clear = function()
        -- define background para os grupos da lualine (ajusta cor conforme o seu tema)
        -- vim.cmd('highlight LualineNormal guibg=#1f2329 guifg=#cfcfd0')
        -- vim.cmd('highlight LualineInactive guibg=#2b3137 guifg=#9ea0a4')
        -- -- também pode ajustar StatusLine se necessário
        -- vim.cmd('highlight StatusLine guibg=#1f2329 guifg=#cfcfd0')
      end,
    })
  end,
}
