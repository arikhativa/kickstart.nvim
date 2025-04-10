return {
  'theprimeagen/harpoon',
  branch = 'harpoon2',
  dependencies = { 'nvim-lua/plenary.nvim'
    --'nvim-telescope/telescope.nvim'
  },
  config = function()
    local harpoon = require 'harpoon'

    harpoon:setup()

    -- basic telescope configuration
    -- local conf = require('telescope.config').values
    -- local function toggle_telescope(harpoon_files)
    --   local file_paths = {}
    --   for _, item in ipairs(harpoon_files.items) do
    --     table.insert(file_paths, item.value)
    --   end
    --
    --   require('telescope.pickers')
    --     .new({}, {
    --       prompt_title = 'harpoon',
    --       finder = require('telescope.finders').new_table {
    --         results = file_paths,
    --       },
    --       previewer = conf.file_previewer {},
    --       sorter = conf.generic_sorter {},
    --     })
    --     :find()
    -- end

    -- vim.keymap.set('n', '<leader>hg', function()
    --   harpoon:list():clear()
    --   local changed_files = vim.fn.systemlist "git status --porcelain | awk '{print $2}'"
    --   for _, file in ipairs(changed_files) do
    --     vim.notify(file, vim.log.levels.INFO)
    --     harpoon:list():add { value = file }
    --   end
    -- end)

    -- vim.keymap.set('n', '<c-e>', function()
    --   toggle_telescope(harpoon:list())
    -- end, { desc = 'open harpoon window' })

    vim.keymap.set('n', '<leader>ha', function()
      harpoon:list():add()
    end)

    vim.keymap.set('n', '<leader>hr', function()
      harpoon:list():remove()
    end)


    vim.keymap.set('n', '<C-b>', function()
      local list = harpoon:list()
      local current = list._index
      local len = list._length

      if current == 1 then
        list._index = len
        harpoon:list():select(len)
      else
        harpoon:list():prev()
      end
    end)

    vim.keymap.set('n', '<C-n>', function()
      local list = harpoon:list()
      local current = list._index
      local len = list._length

      if current == len then
        list._index = 1
        list:select(1)
      else
        list:next()
      end
    end)


    vim.keymap.set('n', '<C-e>', function()
      harpoon.ui:toggle_quick_menu(harpoon:list())
    end)
  end,
}
