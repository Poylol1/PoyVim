local M = {}
-- ensured installed LSP servers
M['mason'] = { 'csharp_ls', 'pyright' }

-- Formatters by ft
M['autoformat'] = {
  lua = { 'stylua' },
  -- Conform can also run multiple formatters sequentially
  python = { 'isort', 'black' },
  --
  -- You can use a sub-list to tell conform to run *until* a formatter
  -- is found.
  csharp = { 'csharpier' },
  javascript = { { 'prettierd', 'prettier' } },
}

M['servers'] = {
  -- clangd = {},
  -- gopls = {},
  csharp_ls = {},
  pyright = {},
  -- rust_analyzer = {},
  -- ... etc. See `:help lspconfig-all` for a list of all the pre-configured LSPs
  --
  -- Some languages (like typescript) have entire language plugins that can be useful:
  --    https://github.com/pmizio/typescript-tools.nvim
  --
  -- But for many setups, the LSP (`tsserver`) will work just fine
  tsserver = {},
  --
  lua_ls = {
    -- cmd = {...},
    -- filetypes = { ...},
    -- capabilities = {},
    settings = {
      Lua = {
        runtime = { version = 'LuaJIT' },
        workspace = { checkThirdParty = false, library = { '${3rd}/luv/library', unpack(vim.api.nvim_get_runtime_file('', true)) } },
        completion = {
          callSnippet = 'Replace',
        },
        -- You can toggle below to ignore Lua_LS's noisy `missing-fields` warnings
        -- diagnostics = { disable = { 'missing-fields' } },
      },
    },
  },
}

M['serverFunction'] = function()
  require('lspconfig').csharp_ls.setup {}
end

-- { 'bash', 'c', 'diff', 'html', 'lua', 'luadoc', 'markdown', 'vim', 'vimdoc', 'python', 'toml', 'c#' }
M['treesitter_installed'] = 'all'

M['treesitter_indent'] = { enable = true, disable = { 'ruby' } }

M['treesitter_highlight'] = {
  enable = true,
  -- Some languages depend on vim's regex highlighting system (such as Ruby) for indent rules.
  --  If you are experiencing weird indenting issues, add the language to
  --  the list of additional_vim_regex_highlighting and disabled languages for indent.
  additional_vim_regex_highlighting = { 'ruby' },
}

return M
