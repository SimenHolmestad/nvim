-- Se https://neovide.dev/configuration.html for mer konfigurasjon
vim.g.neovide_macos_simple_fullscreen = true
vim.g.neovide_cursor_animation_length = 0
vim.api.nvim_set_keymap('n', '<c-ø>', ':let g:neovide_macos_simple_fullscreen = v:false<Enter>', { noremap = true, silent = true })
vim.g.neovide_scroll_animation_length = 0.2
