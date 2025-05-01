return {
  'ahmedkhalf/project.nvim',
  dependencies = {
    'nvim-telescope/telescope.nvim',
  },
  config = function()
    require('project_nvim').setup {
      manual_mode = false,
    }
    require('telescope').load_extension 'projects'
    vim.keymap.set('n', '<leader>pp', ':Telescope projects<CR>', { desc = 'Projects' })
  end,
}
