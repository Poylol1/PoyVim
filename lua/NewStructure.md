.
├── coc-settings.json - Erase
├── init.lua
├── LICENSE.md
├── lua
│   ├── kickstart
│   │   ├── health.lua - pass to Lazy
│   │   └── plugins
│   │       ├── autopairs.lua - pass to lazy
│   │       ├── debug.lua - pass to LSP and REWORK
│   │       ├── gitsigns.lua - Pass to lazy
│   │       ├── indent_line.lua - IDK
│   │       ├── lint.lua - pass to LSP and REWORK
│   │       └── neo-tree.lua - Erase
│   ├── LSP
│   │   ├── autocompleteI.lua - Set LuaSnipI and actually make it work - Total Rework
│   │   ├── autoformatI.lua - Probably combine with lspI or something
│   │   ├── cocI.lua - Erase as I will probably use luasnip
│   │   ├── godotConfig.lua - probably put with the dap file or smth
│   │   ├── LSPconfig.lua - IDK what to do with this 
│   │   ├── lspI.lua - maintain
│   │   ├── LSPsetup.lua - Combine with LSPconfig
│   │   ├── LuaSnipI.lua - TOTAL REWORK 
│   │   ├── masonI.lua
│   │   ├── Snippets
│   │   │   └── all.lua
│   │   ├── treesitterI.lua - Keep maybe combine with others
│   │   └── vimtexI.lua - Partial Rework
│   ├── other
│   │   ├── EOTU.lua - Necessary
│   │   └── luasnip-jsregexp.so - Necessary
│   ├── plugins
│   │   ├── alphaI.lua - Partial Rework
│   │   ├── bufferlineSetup.lua - Bloat?
│   │   ├── harpoonI.lua ?? Change Keybinds ??
│   │   ├── lualineI.lua  - Bloat?
│   │   ├── miniPluginsI.lua - Erase
│   │   ├── noiceI.lua   - Bloat
│   │   ├── oilPl            -|
│   │   │   ├── oilI.lua      |- Join into one and put in lazyconfig
│   │   │   └── oilSetup.lua -|
│   │   └── telescopeI.lua - Total Rework
│   └── Main
│       ├── autoCmd.lua         -|
│       ├── configuration.lua    |- Join into one put them in init.lua
│       ├── newCmd.lua          -|
│       └── lazyconfig.lua -- Change for a shorter faster lazyconfig
├── other
│   └── packages.jl - IDK
└── README.md

.
├── coc-settings.json - Erase
├── init.lua
       ├── autoCmd.lua
       ├── configuration.lua
       └── newCmd.lua
├── LICENSE.md
├── other
│   ├── EOTU.lua - Necessary
│   ├── Snippets
│   │   └── all.lua
│   └── luasnip-jsregexp.so - Necessary
├── lua
│   ├── lazyconfig.lua -- Change for a shorter faster lazyconfig
│   ├── LSP
│   │   ├── autocompleteI.lua - Set LuaSnipI and actually make it work - Total Rework
│   │   ├── autoformatI.lua - Probably combine with lspI or something
│   │   ├── lint.lua - pass to LSP and REWORK
│   │   ├── godotConfig.lua - probably put with the dap file or smth
│   │   ├── debug.lua - pass to LSP and REWORK
│   │   ├── LSPconfig.lua - IDK what to do with this 
│   │   ├── lspI.lua - maintain
│   │   ├── LSPsetup.lua - Combine with LSPconfig
│   │   ├── LuaSnipI.lua - TOTAL REWORK 
│   │   ├── masonI.lua
│   │   ├── treesitterI.lua - Keep maybe combine with others
│   │   └── vimtexI.lua - Partial Rework
│   ├── plugins
│   │   ├── health.lua - pass to Lazy
│   │   ├── gitsigns.lua - Pass to lazy
│   │   ├── autopairs.lua - pass to lazy
│   │   ├── alphaI.lua - Partial Rework
│   │   ├── bufferlineSetup.lua - Bloat?
│   │   ├── harpoonI.lua ?? Change Keybinds ??
│   │   ├── lualineI.lua  - Bloat?
│   │   ├── miniPluginsI.lua - Erase
│   │   ├── noiceI.lua   - Bloat
│   │   ├── indent_line.lua - IDK
│   │   ├── oilPl            -|
│   │   │   ├── oilI.lua      |- Join into one and put in lazyconfig
│   │   │   └── oilSetup.lua -|
│   │   └── telescopeI.lua - Total Rework
│   └── Main
│       ├── autoCmd.lua         -|
│       ├── configuration.lua    |- Join into one put them in init.lua
│       ├── newCmd.lua          -|
│       └── lazyconfig.lua -- Change for a shorter faster lazyconfig
├── other
│   └── packages.jl - IDK
└── README.md

