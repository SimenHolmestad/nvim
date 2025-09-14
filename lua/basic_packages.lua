return {
  'tpope/vim-sleuth', -- Detect tabstop and shiftwidth automatically

  { -- Adds git related signs to the gutter, as well as utilities for managing changes
    'lewis6991/gitsigns.nvim',
    opts = {
      signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
      },
    },
  },

  {
    'smoka7/hop.nvim',
    version = '*',
    opts = {
      keys = 'asdfghjkløqwertyuiopzxcvbnmå',
    },
    config = function()
      require('hop').setup { keys = 'asdfghjkløqwertyuiopzxcvbnm' }
      vim.api.nvim_set_keymap('n', 'ø', ':HopChar1<Enter>', { noremap = true, silent = true })
    end,
  },

  {
    'X3eRo0/dired.nvim',
    dependencies = {
      'MunifTanjim/nui.nvim',
    },
    config = function()
      require('dired').setup {
        path_separator = '/',
        show_banner = false,
        show_icons = false,
        show_hidden = true,
        show_dot_dirs = true,
        show_colors = true,
        hide_details = true,
        keybinds = {
          dired_enter = 'l',
          dired_back = 'h',
          dired_rename = 'R',
          dired_quit = 'q',
          dired_create = '+',
        },
      }
      vim.api.nvim_set_keymap('n', '<leader>fd', ':Dired<Enter>', { noremap = true, silent = true })
    end,
  },

  {
    'kelly-lin/ranger.nvim',
    config = function()
      -- require('ranger-nvim').setup { replace_netrw = true }
      vim.api.nvim_set_keymap('n', '<leader>fr', '', {
        noremap = true,
        callback = function()
          require('ranger-nvim').open(true)
        end,
      })
    end,
  },

  { -- Useful plugin to show you pending keybinds.
    'folke/which-key.nvim',
    event = 'VimEnter', -- Sets the loading event to 'VimEnter'
    opts = {
      icons = {
        -- set icon mappings to true if you have a Nerd Font
        mappings = vim.g.have_nerd_font,
        -- If you are using a Nerd Font: set icons.keys to an empty table which will use the
        -- default whick-key.nvim defined Nerd Font icons, otherwise define a string table
        keys = vim.g.have_nerd_font and {} or {
          Up = '<Up> ',
          Down = '<Down> ',
          Left = '<Left> ',
          Right = '<Right> ',
          C = '<C-…> ',
          M = '<M-…> ',
          D = '<D-…> ',
          S = '<S-…> ',
          CR = '<CR> ',
          Esc = '<Esc> ',
          ScrollWheelDown = '<ScrollWheelDown> ',
          ScrollWheelUp = '<ScrollWheelUp> ',
          NL = '<NL> ',
          BS = '<BS> ',
          Space = '<Space> ',
          Tab = '<Tab> ',
          F1 = '<F1>',
          F2 = '<F2>',
          F3 = '<F3>',
          F4 = '<F4>',
          F5 = '<F5>',
          F6 = '<F6>',
          F7 = '<F7>',
          F8 = '<F8>',
          F9 = '<F9>',
          F10 = '<F10>',
          F11 = '<F11>',
          F12 = '<F12>',
        },
      },

      -- Document existing key chains
      spec = {
        { '<leader>c', group = '[C]ode', mode = { 'n', 'x' } },
        { '<leader>d', group = '[D]ocument' },
        { '<leader>r', group = '[R]ename' },
        { '<leader>s', group = '[S]earch' },
        -- { '<leader>w', group = '[W]orkspace' },
        { '<leader>t', group = '[T]oggle' },
        { '<leader>h', group = 'Git [H]unk', mode = { 'n', 'v' } },
      },
    },
  },
}
