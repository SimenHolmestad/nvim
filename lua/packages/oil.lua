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

      vim.api.nvim_create_autocmd('BufEnter', {
        pattern = '*',
        desc = 'Change cwd to dir in oil buffer',
        callback = function()
          local oil_buffer_path = vim.fn.expand '%:p'
          local buffer_file_path = oil_buffer_path:gsub('oil://', '')
          if vim.fn.isdirectory(buffer_file_path) == 1 then
            vim.cmd('cd ' .. buffer_file_path)
          end
        end,
      })
    end,
  },
}
