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

      local theme_funcs = {}

      -- tokyonight dark
      table.insert(theme_funcs, function()
        vim.cmd.colorscheme 'tokyonight-night'
        vim.cmd 'set background=dark'
        vim.api.nvim_set_hl(0, '@org.headline.level1', { link = 'Title' })
        vim.api.nvim_set_hl(0, '@org.headline.level2', { link = 'Constant' })
        vim.api.nvim_set_hl(0, '@org.headline.level3', { link = 'Identifier' })
        vim.api.nvim_set_hl(0, '@org.headline.level4', { link = 'Statement' })
        vim.api.nvim_set_hl(0, '@org.headline.level5', { link = 'PreProc' })
        vim.api.nvim_set_hl(0, '@org.plan', { link = 'LineNr' })
      end)

      -- everforest light
      table.insert(theme_funcs, function()
        vim.g.everforest_background = 'hard'
        vim.g.everforest_enable_italic = true
        vim.cmd.colorscheme 'everforest'
        vim.cmd 'set background=light'
        vim.api.nvim_set_hl(0, '@org.headline.level1', { link = 'Identifier' })
        vim.api.nvim_set_hl(0, '@org.headline.level2', { link = 'Title' })
        vim.api.nvim_set_hl(0, '@org.headline.level3', { link = 'Constant' })
        vim.api.nvim_set_hl(0, '@org.headline.level4', { link = 'Identifier' })
        vim.api.nvim_set_hl(0, '@org.headline.level5', { link = 'Title' })
        vim.api.nvim_set_hl(0, '@org.plan', { link = 'LineNr' })
      end)

      local function toggle_theme()
        vim.g.my_current_theme_num = (vim.g.my_current_theme_num % #theme_funcs) + 1
        theme_funcs[vim.g.my_current_theme_num]()
      end

      vim.keymap.set('n', '<leader>t', toggle_theme, { noremap = true, desc = '[T]oggle [T]hemes' })

      vim.g.my_current_theme_num = 0
      toggle_theme()
    end,
  },
}
