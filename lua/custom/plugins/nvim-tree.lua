return {
  'nvim-tree/nvim-tree.lua',
  version = '*',
  lazy = false,
  dependencies = {
    'nvim-tree/nvim-web-devicons',
  },
  config = function()
    require('nvim-tree').setup {
      sync_root_with_cwd = true,
      respect_buf_cwd = true,
    }

    vim.keymap.set('n', '<leader>jo', ':NvimTreeOpen<CR>', { noremap = true, silent = true })
    vim.keymap.set('n', '<leader>jf', ':NvimTreeFindFile<CR>', { noremap = true, silent = true })
    vim.keymap.set('n', '<leader>jc', ':NvimTreeClose<CR>', { noremap = true, silent = true })
    vim.keymap.set('n', '<leader>jr', ':NvimTreeRefresh<CR>', { noremap = true, silent = true })
    vim.keymap.set('n', '<leader>js', ':NvimTreeCollapse<CR>', { noremap = true, silent = true })
    vim.api.nvim_create_autocmd('VimEnter', {
      callback = function()
        vim.cmd 'NvimTreeClose'
      end,
    })
  end,
}
