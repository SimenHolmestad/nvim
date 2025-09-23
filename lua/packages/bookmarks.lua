return {
  {
    'crusj/bookmarks.nvim',
    branch = 'main',
    dependencies = { 'nvim-web-devicons' },
    config = function()
      require('bookmarks').setup {
        keymap = {
          add_global = '<leader>ba', -- Add global bookmarks(global keymap), global bookmarks will appear in all projects. Identified with the symbol '󰯾'
          toggle = '<leader>bl', -- Toggle bookmarks(global keymap)
          close = 'q', -- close bookmarks (buf keymap)
        },
      }
      require('telescope').load_extension 'bookmarks'
      vim.keymap.set('n', '<leader><enter>', ':Telescope bookmarks<Enter>', { noremap = true, silent = true })
    end,
  },
}
