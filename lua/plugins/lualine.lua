return {
  'nvim-lualine/lualine.nvim',
  config = function()
    -- Adapted from: https://github.com/nvim-lualine/lualine.nvim/blob/master/lua/lualine/themes/onedark.lua
    local colorsOneDark = {
      blue = '#61afef',
      green = '#98c379',
      purple = '#c678dd',
      cyan = '#56b6c2',
      red1 = '#e06c75',
      red2 = '#be5046',
      yellow = '#e5c07b',
      fg = '#abb2bf',
      bg = '#282c34',
      gray1 = '#828997',
      gray2 = '#2c323c',
      gray3 = '#3e4452',
    }

    local oscura_theme = {
      normal = {
        a = { fg = colorsOneDark.bg, bg = colorsOneDark.green, gui = 'bold' },
        b = { fg = colorsOneDark.fg, bg = colorsOneDark.gray3 },
        c = { fg = colorsOneDark.fg, bg = colorsOneDark.gray2 },
      },
      command = { a = { fg = colorsOneDark.bg, bg = colorsOneDark.yellow, gui = 'bold' } },
      insert = { a = { fg = colorsOneDark.bg, bg = colorsOneDark.blue, gui = 'bold' } },
      visual = { a = { fg = colorsOneDark.bg, bg = colorsOneDark.purple, gui = 'bold' } },
      terminal = { a = { fg = colorsOneDark.bg, bg = colorsOneDark.cyan, gui = 'bold' } },
      replace = { a = { fg = colorsOneDark.bg, bg = colorsOneDark.red1, gui = 'bold' } },
      inactive = {
        a = { fg = colorsOneDark.gray1, bg = colorsOneDark.bg, gui = 'bold' },
        b = { fg = colorsOneDark.gray1, bg = colorsOneDark.bg },
        c = { fg = colorsOneDark.gray1, bg = colorsOneDark.gray2 },
      },
    }

    local onedark_theme = {
      normal = {
        a = { fg = colorsOneDark.bg, bg = colorsOneDark.green, gui = 'bold' },
        b = { fg = colorsOneDark.fg, bg = colorsOneDark.gray3 },
        c = { fg = colorsOneDark.fg, bg = colorsOneDark.gray2 },
      },
      command = { a = { fg = colorsOneDark.bg, bg = colorsOneDark.yellow, gui = 'bold' } },
      insert = { a = { fg = colorsOneDark.bg, bg = colorsOneDark.blue, gui = 'bold' } },
      visual = { a = { fg = colorsOneDark.bg, bg = colorsOneDark.purple, gui = 'bold' } },
      terminal = { a = { fg = colorsOneDark.bg, bg = colorsOneDark.cyan, gui = 'bold' } },
      replace = { a = { fg = colorsOneDark.bg, bg = colorsOneDark.red1, gui = 'bold' } },
      inactive = {
        a = { fg = colorsOneDark.gray1, bg = colorsOneDark.bg, gui = 'bold' },
        b = { fg = colorsOneDark.gray1, bg = colorsOneDark.bg },
        c = { fg = colorsOneDark.gray1, bg = colorsOneDark.gray2 },
      },
    }

    -- Import color theme based on environment variable NVIM_THEME
    local env_var_nvim_theme = os.getenv 'NVIM_THEME' or 'nord'

    -- Define a table of themes
    local themes = {
      onedark = onedark_theme,
      nord = 'nord',
      oscura = oscura_theme
    }

    local mode = {
      'mode',
      fmt = function(str)
        -- return ' ' .. str:sub(1, 1) -- displays only the first character of the mode
        return ' ' .. str
      end,
    }

    local filename = {
      'filename',
      file_status = true, -- displays file status (readonly status, modified status)
      path = 0,           -- 0 = just filename, 1 = relative path, 2 = absolute path
    }

    local hide_in_width = function()
      return vim.fn.winwidth(0) > 100
    end

    local diagnostics = {
      'diagnostics',
      sources = { 'nvim_diagnostic' },
      sections = { 'error', 'warn' },
      symbols = { error = ' ', warn = ' ', info = ' ', hint = ' ' },
      colored = false,
      update_in_insert = false,
      always_visible = false,
      cond = hide_in_width,
    }

    local diff = {
      'diff',
      colored = false,
      symbols = { added = ' ', modified = ' ', removed = ' ' }, -- changes diff symbols
      cond = hide_in_width,
    }

    require('lualine').setup {
      options = {
        icons_enabled = true,
        theme = themes[env_var_nvim_theme], -- Set theme based on environment variable
        -- Some useful glyphs:
        -- https://www.nerdfonts.com/cheat-sheet
        --        
        section_separators = { left = '', right = '' },
        component_separators = { left = '', right = '' },
        disabled_filetypes = { 'alpha', 'neo-tree', 'Avante' },
        always_divide_middle = true,
      },
      sections = {
        lualine_a = { mode },
        lualine_b = { 'branch' },
        lualine_c = { filename },
        lualine_x = { diagnostics, diff, { 'encoding', cond = hide_in_width }, { 'filetype', cond = hide_in_width } },
        lualine_y = { 'location' },
        lualine_z = { 'progress' },
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { { 'filename', path = 1 } },
        lualine_x = { { 'location', padding = 0 } },
        lualine_y = {},
        lualine_z = {},
      },
      tabline = {},
      extensions = { 'fugitive' },
    }
  end,
}
