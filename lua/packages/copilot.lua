return {
  'zbirenbaum/copilot.lua',
  cmd = 'Copilot',
  event = 'InsertEnter',
  config = function()
    require('copilot').setup {
      suggestion = {
        auto_trigger = true,
        keymap = {
          accept = false,
          next = false,
          prev = false,
        },
      },
    }

    -- Custom keymaps
    local suggestion = require 'copilot.suggestion'
    vim.keymap.set({ 'x', 'i' }, '<C-i>', function()
      if suggestion.is_visible() then
        suggestion.dismiss()
      else
        suggestion.next()
      end
    end, { desc = 'Show/hide Copilot suggestion' })
    vim.keymap.set({ 'n', 'x', 'i' }, '<C-ø>', suggestion.accept, { desc = 'Accept Copilot suggestion' })
    vim.keymap.set({ 'x', 'i' }, '<C-n>', suggestion.prev, { desc = 'Previous Copilot suggestion' })
    vim.keymap.set({ 'x', 'i' }, '<C-p>', suggestion.next, { desc = 'Next Copilot suggestion' })
    vim.keymap.set({ 'n' }, '<leader>lk', ':Copilot toggle<CR>', { desc = '[L]lm [K]opilot toggle' })
  end,
}
