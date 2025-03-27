return {
  'nvim-tree/nvim-tree.lua',
  version = '*',
  lazy = false,
  dependencies = {
    'nvim-tree/nvim-web-devicons',
  },
  config = function()
    require('nvim-tree').setup {}

    vim.keymap.set('n', '<leader>jo', ':NvimTreeOpen<CR>', { noremap = true, silent = true })
    vim.keymap.set('n', '<leader>jc', ':NvimTreeClose<CR>', { noremap = true, silent = true })
    vim.keymap.set('n', '<leader>jr', ':NvimTreeRefresh<CR>', { noremap = true, silent = true })
    vim.keymap.set('n', '<leader>js', ':NvimTreeCollapse<CR>', { noremap = true, silent = true })
  end,
}
