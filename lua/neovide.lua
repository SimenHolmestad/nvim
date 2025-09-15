-- Se https://neovide.dev/configuration.html for mer konfigurasjon
vim.g.neovide_macos_simple_fullscreen = true
vim.g.neovide_cursor_animation_length = 0
vim.g.neovide_scroll_animation_length = 0.2

vim.keymap.set('n', '<D-C-Ø>', function()
  vim.g.neovide_macos_simple_fullscreen = not vim.g.neovide_macos_simple_fullscreen
end, { noremap = true, desc = 'Toggle fullscreen' })
