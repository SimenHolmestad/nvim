return {
  { -- Fuzzy Finder (files, lsp, etc)
    'nvim-telescope/telescope.nvim',
    event = 'VimEnter',
    branch = '0.1.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      { -- If encountering errors, see telescope-fzf-native README for installation instructions
        'nvim-telescope/telescope-fzf-native.nvim',

        -- `build` is used to run some command when the plugin is installed/updated.
        -- This is only run then, not every time Neovim starts up.
        build = 'make',

        -- `cond` is a condition used to determine whether this plugin should be
        -- installed and loaded.
        cond = function()
          return vim.fn.executable 'make' == 1
        end,
      },
      { 'nvim-telescope/telescope-ui-select.nvim' },

      -- Useful for getting pretty icons, but requires a Nerd Font.
      { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
    },
    config = function()
      -- [[ Configure Telescope ]]
      -- See `:help telescope` and `:help telescope.setup()`
      require('telescope').setup {
        defaults = {
          mappings = {
            i = {
              ['<C-j>'] = 'move_selection_next',
              ['<C-k>'] = 'move_selection_previous',
            },
          },
        },
        extensions = {
          ['ui-select'] = {
            require('telescope.themes').get_dropdown(),
          },
        },
      }

      -- Enable Telescope extensions if they are installed
      pcall(require('telescope').load_extension, 'fzf')
      pcall(require('telescope').load_extension, 'ui-select')

      -- See `:help telescope.builtin`
      local builtin = require 'telescope.builtin'
      vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
      vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
      vim.keymap.set('n', '<leader><leader>', builtin.git_files, { desc = '[ ] [ ] Search files in project' })
      vim.keymap.set('n', '<leader>ss', builtin.current_buffer_fuzzy_find, { desc = '[S]earch [S] file Telescope' })
      vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = '[S]earch with [G]rep from CWD' })
      vim.keymap.set('n', '<leader>s.', function()
        builtin.live_grep { additional_args = { '--no-ignore-vcs' } }
      end, { desc = '[S]earch file content from [.] CWD' })
      vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
      vim.keymap.set('n', '<leader>sn', builtin.resume, { desc = '[S]earch [N]ext' })
      vim.keymap.set('n', '<leader>fr', builtin.oldfiles, { desc = '[F]ind [R]ecent Files' })
      vim.keymap.set('n', '<leader>st', builtin.colorscheme, { desc = '[S]earch [T]hemes' })
      vim.keymap.set({ 'n', 'v' }, '<leader>gc', builtin.git_bcommits, { desc = '[G]it find [C]ommits in file' })
      vim.keymap.set({ 'n', 'v' }, '<leader>gl', builtin.git_commits, { desc = '[G]it [L]ist commits' })
      vim.keymap.set('n', '<leader>f.', function()
        builtin.find_files { cwd = vim.fn.getcwd() }
      end, { desc = '[F]ind file from [.] current directory' })
      vim.keymap.set('n', '<leader>.', function()
        builtin.find_files { cwd = vim.fn.getcwd(), no_ignore = true }
      end, { desc = '[.] Find file from current directory' })

      vim.keymap.set('n', '<D-j>', '<cmd>cnext<CR>', { desc = 'Next quickfix hit' })
      vim.keymap.set('n', '<D-k>', '<cmd>cprev<CR>', { desc = 'Previous quickfix hit' })

      vim.keymap.set('n', '<leader>s,', function()
        builtin.live_grep {
          grep_open_files = true,
          prompt_title = 'Live Grep in Open Files',
        }
      end, { desc = '[S]earch [,] in Open Files' })

      -- Shortcut for searching your Neovim configuration files
      vim.keymap.set('n', '<leader>sc', function()
        builtin.find_files { cwd = vim.fn.stdpath 'config' }
      end, { desc = '[S]earch neovim [C]onfiguration files' })

      vim.keymap.set('n', '<leader>so', function()
        builtin.find_files { cwd = vim.fs.joinpath(os.getenv 'HOME', 'Dropbox', 'org') }
      end, { desc = '[S]earch [O]rg files' })

      vim.keymap.set('n', '<leader>kf', function()
        builtin.find_files { cwd = vim.fs.joinpath(os.getenv 'HOME', 'Dropbox', 'prosjekter', 'simens_kokebok', 'oppskrifter'), no_ignore = true }
      end, { desc = '[K]okebok [F]ind' })

      vim.keymap.set('n', '<leader>ks', function()
        builtin.live_grep {
          cwd = vim.fs.joinpath(os.getenv 'HOME', 'Dropbox', 'prosjekter', 'simens_kokebok', 'oppskrifter'),
          additional_args = { '--no-ignore-vcs' },
        }
      end, { desc = '[K]okebok [S]earch' })

      vim.keymap.set('n', '<leader>sP', function()
        local data_path = vim.fn.stdpath 'data'
        if type(data_path) ~= 'string' then
          return nil
        end
        builtin.find_files { cwd = vim.fs.joinpath(data_path, 'lazy') }
      end, { desc = '[S]earch nvim [P]ackages' })

      vim.keymap.set('n', '<leader>sp', function()
        builtin.live_grep { cwd = vim.fn.system('git rev-parse --show-toplevel'):gsub('[\n\r]', '') }
      end, { desc = '[S]earch grep in [P]roject' })

      vim.keymap.set('n', '<leader>,', function()
        builtin.find_files {
          cwd = vim.fn.getcwd(),
          prompt_title = 'Folders in CWD',
          find_command = { 'fd', '--type', 'd', '--hidden', '--exclude', '.git' },
        }
      end, { desc = '[S]earch [,] Folders in CWD' })
    end,
  },
}
