return {
  {
    'olimorris/codecompanion.nvim',
    opts = {},
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
    config = function()
      require('codecompanion').setup {
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
            adapter = 'azure_openai',
          },
          inline = {
            adapter = 'azure_openai',
          },
        },
      }

      vim.keymap.set('n', '<leader>cc', '<cmd>CodeCompanionChat Toggle<cr>', { noremap = true, desc = '[C]ode [C]hat' })
      vim.keymap.set({ 'n', 'v' }, '<C-a>', '<cmd>CodeCompanionActions<cr>', { noremap = true, silent = true })
      vim.keymap.set('v', 'ga', '<cmd>CodeCompanionChat Add<cr>', { noremap = true, silent = true })
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
}
