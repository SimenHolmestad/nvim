return {
  {
    'nvim-orgmode/orgmode',
    event = 'VeryLazy',
    ft = { 'org' },
    dependencies = {
      'nvim-orgmode/org-bullets.nvim',
      'lukas-reineke/headlines.nvim',
    },
    config = function()
      require('orgmode').setup {
        org_agenda_files = '~/org/**/*',
        org_default_notes_file = '~/org/refile.org',
        mappings = {
          org = {
            org_meta_return = '<C-enter>',
            org_toggle_checkbox = '<C-c><C-c>',
            org_open_at_point = '<C-c><C-o>',
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
            org_todo = '<leader>t',
          },
        },
        org_todo_keywords = { 'TODO(t)', 'WAIT(w)', '|', 'DONE(d)' },
      }
      require('org-bullets').setup()
      -- require('headlines').setup()
    end,
  },
}
