return {
  {
    'NeogitOrg/neogit',
    dependencies = {
      'nvim-lua/plenary.nvim', -- required
      'sindrets/diffview.nvim', -- optional - Diff integration

      'nvim-telescope/telescope.nvim',
    },
    config = function()
      require('neogit').setup {
        disable_hint = true,
        auto_show_console = true,
        auto_close_console = true,
        auto_refresh = true,
        kind = 'tab',
        commit_editor = {
          kind = 'vsplit',
          show_staged_diff = false,
        },
        commit_select_view = {
          kind = 'replace',
        },
        commit_view = {
          kind = 'replace',
          verify_commit = vim.fn.executable 'gpg' == 1,
        },
        log_view = {
          kind = 'replace',
        },
        stash = {
          kind = 'vsplit',
        },
        mappings = {
          popup = {
            ['h'] = 'HelpPopup',
            ['F'] = 'PullPopup',
          },
        },
      }
      vim.keymap.set('n', '<leader>gg', ':Neogit<Enter>', { desc = 'Open neo[G]it' })
    end,
  },

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
    config = function()
      local gitsigns = require 'gitsigns'

      vim.keymap.set('n', '<leader>gr', gitsigns.reset_buffer, { desc = '[G]it [R]eset buffer' })
      vim.keymap.set('n', '<leader>gl', gitsigns.blame_line, { desc = '[G]it blame [L]ine' })
      vim.keymap.set('n', '<leader>gb', gitsigns.blame, { desc = '[G]it [B]lame file' })
      vim.keymap.set('n', '<leader>gd', gitsigns.diffthis, { desc = '[G]it [D]iff against index' })
      vim.keymap.set('n', '<leader>gL', gitsigns.toggle_current_line_blame, { desc = '[G]it toggle show blame [L]ine' })
    end,
  },
}
