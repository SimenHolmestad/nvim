return {
  {
    'stevearc/oil.nvim',
    ---@module 'oil'
    opts = {},
    dependencies = { { 'echasnovski/mini.icons', opts = {} } },
    lazy = false,
    config = function()
      require('oil').setup {
        keymaps = {
          ['l'] = { 'actions.select', mode = 'n' },
          ['h'] = { 'actions.parent', mode = 'n' },
        },
        view_options = {
          show_hidden = true,
        },
      }
      vim.keymap.set('n', '<leader>ff', ':Oil<Enter>', { noremap = true, silent = true })
    end,
  },
}
