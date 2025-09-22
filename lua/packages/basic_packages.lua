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

  -- Hghlight todo, notes, etc in comments
  { 'folke/todo-comments.nvim', event = 'VimEnter', dependencies = { 'nvim-lua/plenary.nvim' }, opts = { signs = false } },

  { -- Collection of various small independent plugins/modules
    'echasnovski/mini.nvim',
    config = function()
      -- Better Around/Inside textobjects
      --
      -- Examples:
      --  - va)  - [V]isually select [A]round [)]paren
      --  - yinq - [Y]ank [I]nside [N]ext [Q]uote
      --  - ci'  - [C]hange [I]nside [']quote
      require('mini.ai').setup { n_lines = 500 }

      -- Simple and easy statusline.
      --  You could remove this setup call if you don't like it,
      --  and try some other statusline plugin
      local statusline = require 'mini.statusline'
      -- set use_icons to true if you have a Nerd Font
      statusline.setup { use_icons = vim.g.have_nerd_font }

      -- You can configure sections in the statusline by overriding their
      -- default behavior. For example, here we set the section for
      -- cursor location to LINE:COLUMN
      ---@diagnostic disable-next-line: duplicate-set-field
      statusline.section_location = function()
        return '%2l:%-2v'
      end

      -- ... and there is more!
      --  Check out: https://github.com/echasnovski/mini.nvim
    end,
  },
}
