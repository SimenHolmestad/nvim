return {
  {
    'nvim-mini/mini.nvim',
    version = '*',
    config = function()
      require('mini.surround').setup {
        mappings = {
          add = 'S', -- Add surrounding in Normal and Visual modes
        },
      }
    end,
  },
}
