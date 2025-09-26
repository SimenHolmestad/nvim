vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

require 'basic_configuration'

require 'neovide'

require 'lazy_bootstrap'

require('lazy').setup {
  require 'packages.basic_packages',

  require 'packages.oil',

  require 'packages.yanky',

  require 'packages.which_key',

  require 'packages.themes',

  require 'packages.telescope',

  require 'packages.quicker',

  require 'packages.lsp',

  require 'packages.treesitter',

  require 'packages.autoformat',

  require 'packages.autocompletion',

  require 'packages.bookmarks',

  require 'packages.git',

  require 'packages.orgmode',

  require 'packages.copilot',

  require 'packages.codecompanion',

  require 'packages.autopairs',

  require 'packages.indent_line',

  require 'packages.lint',
}
