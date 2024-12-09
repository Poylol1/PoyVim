-- all files called are in the lua/starter folder
-- the plugins are in the lua/plugins folder

require 'starter.configuration'

require 'starter.newCmd'

require 'starter.autoCmd'

require 'starter.lazyconfig'

require 'plugins.oilPl.oilSetup'

require 'plugins.bufferlineSetup'

require 'LSP.LSPsetup'

--Godot
require 'LSP.godotConfig'

--
--	Plans to rewrite the config
--
-- alpha -> the folke startup screen
-- bufferline -> mini line or smth honestly I do no really want a buffer
-- line. Prefer doing this by telescope
-- cmp buffer,cmp latex,cmp lsp,cmp path, cmp vimtex, cmp luasnip keep
-- Comment.nvim -> I think there is native support so I wont keep it
-- Conform.nvim -> I will probably keep it. Unless there is a better alt
-- figet.nvim -> keep it. although is pretty heavy
-- gitsigns.nvim -> search for alternative. although I like it
-- harpoon I want a better way to implement it in my work flow. I have
-- heard of better alternatives and I maybe try those and I also
-- want more telescope in my workflow
-- lualine.nvim -> search for alternative probably keep it
-- Luasnip -> actually get how to use it bruh
-- markview keep and get image.nvim working
-- mason-lsp mason dap mason tool mason keep
-- mini use more
-- noice I like it. I like how is in the center still if it consumes too
-- much I can take it out
-- nui keep
-- autopairs cmp dap dap-go dap-ui lint lspconfig notify nio keep
-- notify surround treesitter
-- web-icons -> change for the mini plugin
-- oil probably change although I like I like it
-- telescope fzf native, telecope ui select
-- todo comments -> check for alternatives
-- tokyonight -> take out
-- vim-be-good ->take out is fun but is bloat
-- startuptime -> check if there is alternative
-- vimtex -> keep
-- which key see more config
-- lazydev probably change
-- luvit-meta idk
-- neo-tree take out
