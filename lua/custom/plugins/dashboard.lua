return {
  'nvimdev/dashboard-nvim',
  event = 'VimEnter',
  dependencies = {
    'nvim-tree/nvim-web-devicons',
    'nvim-telescope/telescope.nvim',
    'ahmedkhalf/project.nvim',
  },
  config = function()
    require('dashboard').setup {}
  end,
}
