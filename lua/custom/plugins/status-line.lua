return {
  'nvim-lualine/lualine.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    local custom_horizon = require 'lualine.themes.horizon'

    custom_horizon.normal = {
      a = { fg = '#282c34', bg = '#9f00ff', gui = 'bold' }, -- mode indicator (e.g., NORMAL)
      b = { fg = '#abb2bf', bg = '#3e4452' }, -- middle section
      c = { fg = '#abb2bf', bg = '#2c323c' }, -- right section
    }

    require('lualine').setup {
      options = { theme = custom_horizon },
      sections = {
        lualine_x = { 'filetype' },
      },
    }
  end,
}
