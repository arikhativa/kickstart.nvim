-- return {
--   'nvimdev/dashboard-nvim',
--   event = 'VimEnter',
--   config = function()
--     require('dashboard').setup {
--       -- config
--     }
--   end,
--   dependencies = { { 'nvim-tree/nvim-web-devicons' } },
-- }
return {
  'nvimdev/dashboard-nvim',
  event = 'VimEnter',
  dependencies = {
    'nvim-tree/nvim-web-devicons',
    'nvim-telescope/telescope.nvim',
    'ahmedkhalf/project.nvim',
  },
  config = function()
    -- require('project_nvim').setup {
    --   manual_mode = false,
    --   detection_methods = { 'pattern' },
    --   patterns = { '.git', 'Makefile', 'package.json' },
    -- }
    --
    -- require('telescope').load_extension 'projects'

    require('dashboard').setup {}
  end,
}
