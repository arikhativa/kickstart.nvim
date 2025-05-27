-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- nvim tabs
vim.keymap.set('n', '<leader>tc', ':tabclose<CR>', { desc = 'Close curent tab' })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: custom
vim.keymap.set('t', '<Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })
vim.api.nvim_set_keymap('v', 'q', '"_d', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'q', '"_d', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-q>', '"_dd', { noremap = true })
vim.api.nvim_set_keymap('i', '<C-q>', '<Esc>"_dd<CR>ki', { noremap = true })
vim.api.nvim_set_keymap('n', '<C-a>', ':copy .<CR>', { noremap = true })
vim.api.nvim_set_keymap('i', '<C-a>', '<Esc>:copy .<CR>i', { noremap = true })
-- vim.api.nvim_set_keymap('n', '<C-b>', ':bd<CR>', { noremap = true })
vim.keymap.set('i', '<C-Right>', '<Esc>ea')
vim.keymap.set('i', '<C-Left>', '<Esc>bi')

vim.keymap.set('n', '<C-d>', '<C-d>zz', { desc = 'Move down and keep curser at center' })
vim.keymap.set('n', '<C-u>', '<C-u>zz', { desc = 'Move up and keep curser at center' })

-- NOTE: move cmd
vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv")
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv")
vim.keymap.set('n', '<A-j>', ':m .+1<CR>==')
vim.keymap.set('n', '<A-k>', ':m .-2<CR>==')

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
vim.keymap.set('n', '<leader>nw', ':vnew<CR>', { desc = 'New window right' })
vim.keymap.set('n', '<C-n>', ':lua vim.diagnostic.goto_next()<CR>', { desc = 'Next error', silent = true })
vim.keymap.set('n', '<C-p>', ':lua vim.diagnostic.goto_prev()<CR>', { desc = 'Prev error', silent = true })

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

-- NOTE: custom file path
vim.api.nvim_create_user_command('ShowFullPath', function()
  print(vim.fn.expand '%:p')
end, {})

vim.api.nvim_create_user_command('ShowRelativePath', function()
  print(vim.fn.expand '%')
end, {})

vim.api.nvim_create_user_command('CopyFileName', function()
  local filename = vim.fn.expand '%:t'
  vim.fn.setreg('+', filename) -- copies to system clipboard
  print('Copied file name: ' .. filename)
end, {})

vim.keymap.set('n', '<leader>pf', ':ShowFullPath<CR>', { desc = 'Show full path', silent = true })
vim.keymap.set('n', '<leader>pr', ':ShowRelativePath<CR>', { desc = 'Show relative path', silent = true })
vim.keymap.set('n', '<leader>yfn', ':CopyFileName<CR>', { desc = 'Copy file name', silent = true })

-- NOTE: load curent file
vim.api.nvim_create_user_command('RunBufferAsLua', function()
  local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
  local code = table.concat(lines, '\n')
  local ok, err = pcall(load(code))
  if not ok then
    print('Lua Error: ' .. err)
  end
end, {})

vim.keymap.set('n', '<leader>ll', ':RunBufferAsLua<CR>', { desc = 'Run whole buffer as Lua', silent = true })

vim.api.nvim_create_user_command('CopyFileContent', function()
  local content = vim.api.nvim_buf_get_lines(0, 0, -1, false)
  local text = table.concat(content, '\n')
  vim.fn.setreg('+', text) -- copy to system clipboard
  print 'Copied entire file to clipboard.'
end, {})

vim.keymap.set('n', '<leader>yfc', ':CopyFileContent<CR>', { desc = 'Copy entire file', silent = true })

-- NOTE: custom cmd s
vim.api.nvim_create_user_command('InsertRNComponent', function()
  local filename = vim.fn.expand '%:t:r' -- current file name without extension

  local component = string.format(
    [[
import { PropsWithChildren } from "react"
import { View } from "react-native"

type Props = PropsWithChildren & {
}

export function %s({}: Props) {
  return <View></View>
}
]],
    filename
  )

  vim.api.nvim_buf_set_lines(0, 0, 0, false, vim.split(component, '\n'))
  print('Inserted component template for: ' .. filename)
end, {
  desc = 'Insert a React Native component template using current filename',
})

-- NOTE: keymap for tabs
local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

-- Move to previous/next
map('n', '<A-h>', '<Cmd>BufferPrevious<CR>', opts)
map('n', '<A-l>', '<Cmd>BufferNext<CR>', opts)

-- Re-order to previous/next
map('n', '<A-,>', '<Cmd>BufferMovePrevious<CR>', opts)
map('n', '<A-.>', '<Cmd>BufferMoveNext<CR>', opts)

-- Close buffer
map('n', '<A-w>', '<Cmd>BufferClose<CR>', opts)
map('n', '<A-q>', '<Cmd>BufferCloseAllButCurrent<CR>', opts)

-- Magic buffer-picking mode
map('n', '<A-p>', '<Cmd>BufferPick<CR>', opts)

-- vim: ts=2 sts=2 sw=2 et
