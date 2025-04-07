return {
  'nvim-pack/nvim-spectre',
  dependencies = {
    'nvim-lua/plenary.nvim', -- Required dependency
  },
  config = function()
    require('spectre').setup()
  end,
  keys = {
    {
      '<leader>S',
      function()
        require('spectre').toggle()
      end,
      desc = 'Toggle Spectre',
    },
    {
      '<leader>sw',
      function()
        require('spectre').open_visual { select_word = true }
      end,
      desc = 'Search current word',
    },
    {
      '<leader>sf',
      function()
        require('spectre').open_file_search { select_word = true }
      end,
      desc = 'Search current file',
    },
  },
}
