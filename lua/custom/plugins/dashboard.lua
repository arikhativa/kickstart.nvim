return {
  'nvimdev/dashboard-nvim',
  event = 'VimEnter',
  dependencies = {
    'nvim-tree/nvim-web-devicons',
    'ahmedkhalf/project.nvim',
  },
  config = function()
    require('dashboard').setup {
      shortcut_type = 'number',
    }
  end,
}
