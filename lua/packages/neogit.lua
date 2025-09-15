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
        auto_refresh = true,
        kind = 'replace',
        commit_editor = {
          kind = 'replace',
          staged_diff_split_kind = 'auto',
        },
        commit_select_view = {
          kind = 'replace',
        },
        log_view = {
          kind = 'replace',
        },
      }
      vim.api.nvim_set_keymap('n', '<leader>gg', ':Neogit<Enter>', { noremap = true, silent = true })

      vim.api.nvim_create_autocmd('User', {
        pattern = 'NeogitCommitComplete',
        desc = 'Move back to Neogit status buffer after creating commit',
        callback = function()
          vim.cmd 'bd'
          vim.cmd 'Neogit'
        end,
      })
    end,
  },
}
