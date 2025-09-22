return {
  {
    'olimorris/codecompanion.nvim',
    opts = {},
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
    config = function()
      require('codecompanion').setup {
        display = {
          chat = {
            start_in_insert_mode = true,
          },
        },
        adapters = {
          http = {
            azure_openai = function()
              return require('codecompanion.adapters').extend('azure_openai', {
                env = {
                  -- Se https://codecompanion.olimorris.dev/getting-started#setting-an-api-key
                  endpoint = 'cmd:op read op://Employee/AzureAICredentials/url --no-newline',
                  api_key = 'cmd:op read op://Employee/AzureAICredentials/credential --no-newline',
                  api_version = '2025-03-01-preview',
                },
                schema = {
                  model = {
                    default = 'gpt-5',
                  },
                },
              })
            end,
          },
        },
        strategies = {
          chat = {
            adapter = 'copilot',
            opts = {
              completion_provider = 'cmp',
            },
            keymaps = {
              send = { modes = { n = '<C-enter>', i = '<C-enter>' } },
              close = { modes = { n = '<leader>ld', i = '<leader>ld' } },
              next_chat = { modes = { n = '<leader>lj' } },
              previous_chat = { modes = { n = '<leader>lk' } },
              next_header = { modes = { n = '<C-j>' } },
              previous_header = { modes = { n = '<C-k>' } },
            },
            tools = {
              ['create_file'] = {
                opts = {
                  requires_approval = false,
                },
              },
              ['insert_edit_into_file'] = {
                opts = {
                  requires_approval = {
                    buffer = false,
                    file = false,
                  },
                  user_confirmation = false,
                },
              },
            },
          },
          inline = {
            adapter = 'copilot',
          },
        },
      }

      vim.keymap.set('n', '<leader>ll', '<cmd>CodeCompanionChat Toggle<cr>', { noremap = true, desc = '[L]lm [L] Toggle chat' })
      vim.keymap.set('n', '<leader>lc', '<cmd>CodeCompanionChat<cr>', { noremap = true, desc = '[L]lm new [C]hat' })
      vim.keymap.set({ 'n', 'v' }, '<leader>la', '<cmd>CodeCompanionActions<cr>', { noremap = true, desc = '[L]lm code [A]ction' })
      vim.keymap.set('v', 'gl', '<cmd>CodeCompanionChat Add<cr><esc>', { noremap = true, desc = 'Add to [L]lm chat' })
      vim.keymap.set('n', '<leader>li', '<cmd>CodeCompanion ', { noremap = true, desc = '[L]lm code [I]nline chat' })
      vim.cmd [[cab cc CodeCompanion]]
    end,
  },
  {
    'echasnovski/mini.diff',
    config = function()
      local diff = require 'mini.diff'
      diff.setup {
        -- Disabled by default
        source = diff.gen_source.none(),
      }
    end,
  },
  { -- For å kunne lime inn bilder i chat tydeligvis
    'HakonHarnes/img-clip.nvim',
    opts = {
      filetypes = {
        codecompanion = {
          prompt_for_file_name = false,
          template = '[Image]($FILE_PATH)',
          use_absolute_path = true,
        },
      },
    },
  },
  {
    'OXY2DEV/markview.nvim',
    lazy = false,
    opts = {
      preview = {
        filetypes = {
          -- 'markdown',
          'codecompanion',
        },
        ignore_buftypes = {},
      },
    },
  },
}
