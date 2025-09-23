return {
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
      vim.keymap.set('n', '<leader>fd', ':Dired<Enter>', { noremap = true, silent = true })
    end,
  },
}
