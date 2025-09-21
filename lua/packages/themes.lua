return {
  'morhetz/gruvbox',
  'rebelot/kanagawa.nvim',
  'sainnhe/everforest',
  'altercation/vim-colors-solarized',
  {
    'folke/tokyonight.nvim',
    priority = 1000, -- Make sure to load this before all the other start plugins.
    init = function()
      vim.api.nvim_create_autocmd('ColorScheme', {
        pattern = '*',
        callback = function()
          vim.cmd 'highlight Folded guibg=NONE guibg=NONE'
          vim.cmd 'highlight FoldColumn guibg=NONE guifg=NONE'
        end,
      })

      vim.g.my_current_theme_num = 1

      local theme_funcs = {}

      -- tokyonight dark
      table.insert(theme_funcs, function()
        vim.cmd.colorscheme 'tokyonight-night'
        vim.cmd 'set background=dark'
      end)

      -- kanagawa dark
      table.insert(theme_funcs, function()
        vim.cmd.colorscheme 'kanagawa'
        vim.cmd 'set background=dark'
      end)

      -- kanagawa light
      table.insert(theme_funcs, function()
        vim.cmd.colorscheme 'kanagawa'
        vim.cmd 'set background=light'
      end)

      -- everforest light
      table.insert(theme_funcs, function()
        vim.cmd.colorscheme 'everforest'
        vim.cmd 'set background=light'
      end)

      -- solarized light
      table.insert(theme_funcs, function()
        vim.cmd.colorscheme 'solarized'
        vim.cmd 'set background=light'
      end)

      vim.keymap.set('n', '<leader>t', function()
        vim.g.my_current_theme_num = (vim.g.my_current_theme_num % #theme_funcs) + 1
        theme_funcs[vim.g.my_current_theme_num]()
      end, { noremap = true, desc = '[T]oggle [T]hemes' })

      vim.cmd.colorscheme 'tokyonight-night'
    end,
  },
}
