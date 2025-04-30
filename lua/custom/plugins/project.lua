return {
  'ahmedkhalf/project.nvim',
  event = 'VeryLazy',
  dependencies = {
    'nvim-telescope/telescope.nvim',
  },
  config = function()
    require('project_nvim').setup {}
    require('telescope').load_extension 'projects'
    vim.keymap.set('n', '<leader>pp', ':Telescope projects<CR>', { desc = 'Projects' })
  end,
}
