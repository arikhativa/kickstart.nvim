-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: custom
vim.keymap.set('t', '<Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- cpy to clipboard
-- vim.api.nvim_set_keymap('v', '<leader>y', '"+y', { noremap = true, silent = true })
-- del no cpy
vim.api.nvim_set_keymap('v', 'q', '"_d', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'q', '"_d', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-q>', '"_dd', { noremap = true })
vim.api.nvim_set_keymap('n', '<C-a>', ':copy .<CR>', { noremap = true })
vim.api.nvim_set_keymap('i', '<C-a>', '<Esc>:copy .<CR>i', { noremap = true })
--vim.api.nvim_set_keymap('n', '<C-o>', 'o<CR><Esc>', { noremap = true })

vim.keymap.set('n', '<C-d>', '<C-d>zz', { desc = 'Move down and keep curser at center' })
vim.keymap.set('n', '<C-u>', '<C-u>zz', { desc = 'Move up and keep curser at center' })

local term_buf = -1
local term_win = -1
local last_win = -1

function ToggleTerminal()
  local current_win = vim.api.nvim_get_current_win()

  if term_win ~= -1 and vim.api.nvim_win_is_valid(term_win) then
    -- If terminal window is open, close it and return to the last window
    vim.api.nvim_win_hide(term_win)
    term_win = -1
    vim.api.nvim_set_current_win(last_win)
  else
    -- Save the last window before opening the terminal
    last_win = current_win

    if term_buf == -1 or not vim.api.nvim_buf_is_valid(term_buf) then
      -- Create a new terminal buffer if none exists
      vim.cmd 'split'
      vim.cmd 'term'
      term_buf = vim.api.nvim_get_current_buf()
    else
      -- Open terminal in the same position
      vim.cmd 'split'
      vim.api.nvim_set_current_buf(term_buf)
    end

    -- Store the new terminal window ID
    term_win = vim.api.nvim_get_current_win()
  end
end

vim.api.nvim_set_keymap('n', '<leader>st', ':lua ToggleTerminal()<CR>', { noremap = true, silent = true })

-- TIP: Disable arrow keys in normal mode
vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- tabs
vim.keymap.set('n', '<leader>tn', ':tabnext<CR>', { desc = 'Next Tab', silent = true })
vim.keymap.set('n', '<leader>tp', ':tabprev<CR>', { desc = 'Previous Tab', silent = true })
vim.keymap.set('n', '<leader>tc', ':tabclose<CR>', { desc = 'Close Tab', silent = true })

-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- vim: ts=2 sts=2 sw=2 et
