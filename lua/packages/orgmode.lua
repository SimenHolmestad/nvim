return {
  {
    'nvim-orgmode/orgmode',
    event = 'VeryLazy',
    ft = { 'org' },
    dependencies = {
      'lukas-reineke/headlines.nvim',
    },
    config = function()
      require('orgmode').setup {
        org_agenda_files = '~/org/**/*',
        org_default_notes_file = '~/org/refile.org',
        org_startup_indented = true,
        org_adapt_indentation = false,
        org_ellipsis = ' [...]',
        -- org_log_done = false,
        mappings = {
          org = {
            org_meta_return = '<leader>oh',
            org_insert_heading_respect_content = '<C-Enter>',
            org_insert_todo_heading_respect_content = '<D-S-Enter>',
            org_toggle_checkbox = '<leader>t',
            org_hide_leading_stars = true,
            org_open_at_point = '<leader>ol',
            org_do_promote = '<D-h>',
            org_do_demote = '<D-l>',
            org_promote_subtree = '<D-S-h>',
            org_demote_subtree = '<D-S-l>',
            org_move_subtree_up = '<D-k>',
            org_move_subtree_down = '<D-j>',
            org_forward_heading_same_level = '<C-j>',
            org_backward_heading_same_level = '<C-k>',
            org_next_visible_heading = '<C-l>',
            outline_up_heading = '<C-h>', -- For at denne skal fungere på mac, se https://github.com/neovide/neovide/issues/1230
            org_todo = '<leader>mt',
            org_cycle_separator_lines = 0,
            org_startup_folded = 'overview',
          },
        },
        org_blank_before_new_entry = { heading = false, plain_list_item = false },
        org_todo_keywords = { 'TODO(t)', 'WAIT(w)', '|', 'DONE(d)', 'NO(n)' },
        org_todo_keyword_faces = {
          WAIT = ':foreground #dfc18b :weight bold',
          TODO = ':foreground #9bd2a1 :weight bold',
          DONE = ':foreground #5a6878 :weight bold',
          NO = ':foreground #c95d6a :weight bold',
        },
      }

      vim.api.nvim_create_autocmd('ColorScheme', {
        pattern = '*',
        callback = function()
          -- Define own colors
          vim.api.nvim_set_hl(0, '@org.headline.level1', { bg = nil })
          vim.api.nvim_set_hl(0, '@org.headline.level2', { bg = nil })
          vim.api.nvim_set_hl(0, '@org.headline.level3', { bg = nil })
          vim.api.nvim_set_hl(0, '@org.headline.level4', { bg = nil })
          vim.api.nvim_set_hl(0, '@org.headline.level5', { bg = nil })
          vim.api.nvim_set_hl(0, '@org.plan', { fg = '#5a6878' })
        end,
      })

      vim.api.nvim_create_autocmd('BufReadPost', {
        pattern = '*.org',
        callback = function()
          vim.opt_local.number = false
          vim.opt_local.relativenumber = false
        end,
      })

      require('headlines').setup {
        org = {
          bullets = { '○', '○', '○', '○' },
          fat_headlines = false,
        },
      }

      vim.cmd [[highlight Folded guibg=#222222]]
    end,
  },
}
