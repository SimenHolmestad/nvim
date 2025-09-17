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
        auto_close_console = false,
        auto_refresh = true,
        kind = 'replace',
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
      vim.api.nvim_set_keymap('n', '<leader>gg', ':Neogit<Enter>', { noremap = true, silent = true })
    end,
  },
}
