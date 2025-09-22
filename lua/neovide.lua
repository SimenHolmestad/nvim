-- Se https://neovide.dev/configuration.html for mer konfigurasjon
vim.g.neovide_macos_simple_fullscreen = true
vim.g.neovide_cursor_animation_length = 0
vim.g.neovide_scroll_animation_length = 0.2

vim.keymap.set('n', '<D-C-Ø>', function()
  vim.g.neovide_macos_simple_fullscreen = not vim.g.neovide_macos_simple_fullscreen
end, { noremap = true, desc = 'Toggle fullscreen' })

vim.g.neovide_scale_factor = 1.0
local change_scale_factor = function(delta)
  vim.g.neovide_scale_factor = vim.g.neovide_scale_factor * delta
end
vim.keymap.set({ 'n', 'i' }, '<C-+>', function()
  change_scale_factor(1.10)
end, { desc = 'Increase font size' })
vim.keymap.set({ 'n', 'i' }, '<C-->', function()
  change_scale_factor(1 / 1.10)
end, { desc = 'Decrease font size' })
vim.keymap.set({ 'n', 'i' }, '<C-0>', function()
  vim.g.neovide_scale_factor = 1.0
end, { desc = 'Reset scale to default' })
