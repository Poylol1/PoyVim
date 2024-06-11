return {
  ['basicMason'] = {
    'williamboman/mason.nvim',
    config = function()
      require('mason').setup()
    end,
  },
  ['masonlspConfig'] = {
    'williamboman/mason-lspconfig.nvim',
    config = function()
      require('mason-lspconfig').setup {
        ensure_installed = require('plugins.LSPmanager.LSPconfig')['mason'],
      }

      local lspconfig = require 'lspconfig'
      local mason_lspconfig = require 'mason-lspconfig'

      mason_lspconfig.setup_handlers {
        function(server_name)
          lspconfig[server_name].setup {}
        end,
      }
    end,
  },
}
