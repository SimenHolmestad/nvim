vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

require 'basic_configuration'

require 'neovide'

require 'lazy_bootstrap'

require('lazy').setup {
  require 'packages.basic_packages',

  require 'packages.which_key',

  require 'packages.themes',

  require 'packages.telescope',

  require 'packages.lsp',

  require 'packages.treesitter',

  require 'packages.autoformat',

  require 'packages.autocompletion',

  require 'packages.bookmarks',

  require 'packages.neogit',

  require 'packages.orgmode',

  require 'packages.copilot',

  require 'packages.codecompanion',

  require 'kickstart.plugins.autopairs',

  require 'kickstart.plugins.indent_line',

  -- Venter med disse, tenker kanskje at de ikke trengs:
  -- require 'kickstart.plugins.lint',
  -- require 'kickstart.plugins.debug',
  -- require 'kickstart.plugins.neo-tree',
  -- require 'kickstart.plugins.gitsigns', -- adds gitsigns recommend keymaps
}
