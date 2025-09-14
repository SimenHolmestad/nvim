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
        kind = 'vsplit',
      }
      vim.api.nvim_set_keymap('n', '<leader>gg', ':Neogit<Enter>', { noremap = true, silent = true })
    end,
  },
}
