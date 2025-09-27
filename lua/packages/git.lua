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
        disable_context_highlighting = false,
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
    config = function()
      local gitsigns = require 'gitsigns'
      gitsigns.setup {
        signs = {
          add = { text = '+' },
          change = { text = '~' },
          delete = { text = '_' },
          topdelete = { text = '‾' },
          changedelete = { text = '~' },
        },
      }

      vim.keymap.set('n', '<leader>gr', gitsigns.reset_buffer, { desc = '[G]it [R]eset buffer' })
      vim.keymap.set('n', '<leader>gl', gitsigns.blame_line, { desc = '[G]it blame [L]ine' })
      vim.keymap.set('n', '<leader>gb', gitsigns.blame, { desc = '[G]it [B]lame file' })
      vim.keymap.set('n', '<leader>gd', gitsigns.diffthis, { desc = '[G]it [D]iff against index' })
      vim.keymap.set('n', '<leader>gL', gitsigns.toggle_current_line_blame, { desc = '[G]it toggle show blame [L]ine' })
    end,
  },

  {
    'folke/snacks.nvim',
    opts = {
      gitbrowse = {
        notify = true,
        enabled = true,
      },
    },
    config = function()
      local snacks = require 'snacks'
      vim.keymap.set({ 'n', 'x' }, '<leader>ghc', function()
        snacks.gitbrowse {
          open = function(url)
            vim.fn.setreg('+', url)
          end,
          notify = false,
        }
      end, { desc = '[G]it[H]ub [C]opy line(s) url' })
      vim.keymap.set({ 'n', 'x' }, '<leader>ghl', function()
        snacks.gitbrowse { notify = false }
      end, { desc = '[G]it[H]ub goto [L]ine(s) in browser' })
    end,
  },
}
