return {
  'tpope/vim-sleuth', -- Detect tabstop and shiftwidth automatically

  {
    'smoka7/hop.nvim',
    version = '*',
    opts = {
      keys = 'asdfghjkløqwertyuiopzxcvbnmå',
    },
    config = function()
      require('hop').setup { keys = 'asdfghjkløqwertyuiopzxcvbnm' }
      vim.keymap.set('n', 'ø', ':HopChar1<Enter>', { noremap = true, silent = true })
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

      -- For text object actions like gcii
      require('mini.indentscope').setup {
        draw = {
          predicate = function()
            return false
          end,
        },
      }

      -- Add surrounding in Normal and Visual modes
      require('mini.surround').setup {
        mappings = {
          add = 'S',
        },
        respect_selection_type = true,
      }

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

  {
    'chrisgrieser/nvim-spider',
    config = function()
      vim.keymap.set({ 'n', 'o', 'x' }, 'w', "<cmd>lua require('spider').motion('w')<CR>")
      vim.keymap.set({ 'n', 'o', 'x' }, 'e', "<cmd>lua require('spider').motion('e')<CR>")
      vim.keymap.set({ 'n', 'o', 'x' }, 'b', "<cmd>lua require('spider').motion('b')<CR>")
    end,
  },
  {
    'chrisgrieser/nvim-various-textobjs',
    opts = {
      keymaps = {
        useDefaults = true,
      },
    },
    config = function()
      vim.keymap.set({ 'o', 'x' }, 'as', '<cmd>lua require("various-textobjs").subword("outer")<CR>')
      vim.keymap.set({ 'o', 'x' }, 'is', '<cmd>lua require("various-textobjs").subword("inner")<CR>')
    end,
  },
}
