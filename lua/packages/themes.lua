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
      -- local my_themes = { 'tokyonight_night', 'kanagawa' }
      local theme_funcs = {}

      theme_funcs[1] = function()
        vim.cmd.colorscheme 'tokyonight-night'
        vim.cmd 'set background=dark'
      end

      theme_funcs[2] = function()
        vim.cmd.colorscheme 'kanagawa'
        vim.cmd 'set background=dark'
      end

      theme_funcs[3] = function()
        vim.cmd.colorscheme 'kanagawa'
        vim.cmd 'set background=light'
      end

      theme_funcs[4] = function()
        vim.cmd.colorscheme 'everforest'
        vim.cmd 'set background=light'
      end

      theme_funcs[5] = function()
        vim.cmd.colorscheme 'solarized'
        vim.cmd 'set background=light'
      end

      vim.keymap.set('n', '<leader>t', function()
        vim.g.my_current_theme_num = vim.g.my_current_theme_num + 1
        if vim.g.my_current_theme_num > #theme_funcs then
          vim.g.my_current_theme_num = 1
        end
        theme_funcs[vim.g.my_current_theme_num]()
      end, { noremap = true, desc = '[T]oggle [T]hemes' })

      vim.cmd.colorscheme 'tokyonight-night'
    end,
  },
}
