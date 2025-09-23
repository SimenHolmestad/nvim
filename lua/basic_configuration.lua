-- [[ Setting options ]]
-- See `:help vim.opt`

vim.opt.number = true
-- vim.opt.reltivenumber = true

-- Enable mouse mode, can be useful for resizing splits for example!
vim.opt.mouse = 'a'

-- Don't show the mode, since it's already in the status line
vim.opt.showmode = false

-- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.have_nerd_font = true

-- Sync clipboard between OS and Neovim.
--  Schedule the setting after `UiEnter` because it can increase startup-time.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.schedule(function()
  vim.opt.clipboard = 'unnamedplus'
end)

-- Enable break indent
vim.opt.breakindent = true

-- Enable autochdir so that the current file in buffer is always the working directory
vim.opt.autochdir = true

-- Save undo history
vim.opt.undofile = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Keep signcolumn on by default
vim.opt.signcolumn = 'yes'

-- Decrease update time
vim.opt.updatetime = 250

-- Decrease mapped sequence wait time
-- Displays which-key popup sooner
vim.opt.timeoutlen = 300

-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Preview substitutions live, as you type!
vim.opt.inccommand = 'split'

-- Show which line your cursor is on
vim.opt.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 8

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
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

--  Disable arrow keys in normal mode
vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

-- Slett ord bakover på alt-backspace (som jeg har mappet til ctrl-backspace med karabiner)
vim.keymap.set({ 'i', 'c' }, '<M-bs>', '<C-w>', { noremap = false, silent = true })

--  See `:help wincmd` for a list of all window commands
vim.keymap.set('n', '<leader>w', '<C-w>')
vim.keymap.set('n', '<leader>wd', '<C-w>q')
vim.keymap.set('n', '-', '/')

vim.keymap.set({ 'n', 'v', 'x', 's', 'o', 'i', 'c', 't', 'l' }, '<C-g>', '<Esc>')

vim.keymap.set('n', '<leader>fs', ':w<Enter>', { noremap = true, silent = true })

vim.keymap.set('n', '<leader>ss', '/', { desc = '[S]earch [S] current file' })

vim.keymap.set('n', 's', '/', {})

vim.keymap.set('n', '<leader>ff', ':e.<Enter>', { silent = true })

vim.keymap.set('n', '<leader>en', ':tabnew<Enter>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>el', 'gt', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>eh', 'gT', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>ed', ':tabclose<Enter>', { noremap = true, silent = true })

vim.keymap.set('n', '<leader>ot', ':terminal<Enter>', { noremap = true, desc = '[O]pen [T]erminal' })

vim.keymap.set('n', '<leader>oo', function()
  os.execute 'open .'
end, { noremap = true, desc = '[O]pen [O] current folder in finder' })

vim.keymap.set('n', '<leader>oi', function()
  os.execute(string.format('open -a iTerm %s', vim.fn.getcwd()))
end, { noremap = true, desc = '[O]pen [I]Term' })

vim.keymap.set('n', '<D-S-k>', ':bprev<Enter>')

vim.keymap.set('n', '<D-S-j>', ':bnext<Enter>')

-- Highlight when yanking (copying) text
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- From https://www.reddit.com/r/neovim/comments/17eomi1/how_do_you_deal_with_vertical_scrolloff_not_being/
vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI', 'BufEnter' }, {
  group = vim.api.nvim_create_augroup('ScrollOffEOF', {}),
  callback = function()
    local win_h = vim.api.nvim_win_get_height(0)
    local off = math.min(vim.o.scrolloff, math.floor(win_h / 2))
    local dist = vim.fn.line '$' - vim.fn.line '.'
    local rem = vim.fn.line 'w$' - vim.fn.line 'w0' + 1
    if dist < off and win_h - rem + dist < off then
      local view = vim.fn.winsaveview()
      view.topline = view.topline + off - (win_h - rem + dist)
      vim.fn.winrestview(view)
    end
  end,
})

-- From https://stackoverflow.com/questions/77747363/remove-white-spaces-added-in-nvim-on-save
vim.api.nvim_create_autocmd('FileType', {
  group = vim.api.nvim_create_augroup('trim_whitespaces', { clear = true }),
  desc = 'Trim trailing white spaces',
  pattern = '*',
  callback = function()
    vim.api.nvim_create_autocmd('BufWritePre', {
      pattern = '<buffer>',
      -- Trim trailing whitespaces
      callback = function()
        -- Save cursor position to restore later
        local curpos = vim.api.nvim_win_get_cursor(0)
        -- Search and replace trailing whitespaces
        vim.cmd [[keeppatterns %s/\s\+$//e]]
        vim.api.nvim_win_set_cursor(0, curpos)
      end,
    })
  end,
})

vim.keymap.set('n', '<leader>rl', 'vip:lua<Enter>', { desc = '[R]un lua [B]lock' })
