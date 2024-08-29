-- @param txt string[]
-- @param opts table?
local function text(txt, highlight)
  options = { position = 'center', hl = 'Type' }
  if highlight ~= nil then
    options.hl = highlight
  end

  return {
    type = 'text',
    val = txt,
    opts = options,
  }
end

-- @param lines number
local function padding(lines)
  return { type = 'padding', val = lines }
end
--- @param sc string
--- @param txt string
--- @param keybind string? optional
--- @param keybind_opts table? optional
local function button(sc, txt, keybind, keybind_opts)
  local opts = {
    position = 'center',
    shortcut = sc,
    cursor = 3,
    width = 50,
    align_shortcut = 'right',
    hl_shortcut = 'Keyword',
  }
  if keybind then
    keybind_opts = vim.F.if_nil(keybind_opts, { noremap = true, silent = true, nowait = true })
    opts.keymap = { 'n', sc, keybind, keybind_opts }
  end

  local function on_press()
    local key = vim.api.nvim_replace_termcodes(keybind or sc .. '<Ignore>', true, false, true)
    vim.api.nvim_feedkeys(key, 't', false)
  end

  return {
    type = 'button',
    val = txt,
    on_press = on_press,
    opts = opts,
  }
end

Config = {
  layout = {
    padding(1),
    text({ '󱗆  Welcome to PoyVim!! ' }, 'number'),
    padding(1),
    button('n', '  New File', '<cmd>ene<CR>'),
    button('o', '󰏇  Open Oil File Manager', '<cmd>Oil<CR>'),
    button('q', '󰈆  Quit', '<cmd>q<CR>'),
    button('s', '  Watch Poyvim startup time', '<cmd>StartupTime<CR>'),
    button('c', '  Check plugin and lsp health', '<cmd>checkhealth<CR>'),
    padding(1),
    text({ '󰭎  Telescope:' }, 'number'),
    padding(1),
    button('<leader>gh', '󰻴  Go to file with Harpoon'),
    button('<leader>sf', '  Search files through Telescope'),
    padding(2),
    text {
      [[                                    Ê                            #              ]],
      [[                                    Ø                          Æ                ]],
      [[                                    M                        Ñ                  ]],
      [[                                    Ã                      #                    ]],
      [[                                    Q                    G‹                     ]],
      [[                                    Å          Ø       õŸ                       ]],
      [[                 g             ;    N         þ      JÈ                         ]],
      [[                   Ñ           ˜    þ        ¶     ³Æ                           ]],
      [[                     Æ     b    Æ   Ž … k  ¹&    :Ñ                             ]],
      [[                       Æ    ´    0 Òp ­ 9 h[   ´Æ·                              ]],
      [[                         Œ    Æ  Þ Æý °Æ Æ­   Æî                                ]],
      [[                          …M 8 àÑÆ Æ’Æ…ÆÆ·  ÆÛ                                  ]],
      [[                          Ñ ;Æ Ø Æ ÆJÆÆÆÆ÷ÆÆ                                    ]],
      [[                            Ípµ¨ Æ“µÆÆŸÆÆÿ‚Wæˆ EÆ                               ]],
      [[                      ¿Ãß¬   Æ)¨Š¹Æ`ÆÆEÆ·Æ7Æ ¬Æ´ñ6                              ]],
      [[                        8( ÆÆÆ›´Æ<g ˆ  ’ÆvlÆŒ ±Æ/Á                              ]],
      [[      ..............·¸¹ïñÙ·°–Æ·˜ˆ…      `¬)*”«`ÆÆÆÆÆÆÆÆÆÆÆÆÆÆÆŒ¶Ý5{~;ˆ¨´`       ]],
      [[                           ´QÆÆÆÆ‘œ¸    ¸;ë;Wˆ·ÅQÆÉ                             ]],
      [[                          ´Æî ¸’Æ…ÆE“b`Æ;ÆjÆ¶…Æ…8    `                          ]],
      [[                            Ø ÌÆô…ÆÉÆlJB|Æ«þ¿ÆÆ ¦Æå                             ]],
      [[                          Æ   Æ ®ÊÆÆÆ¦–5TÆ˜Æ¬Æ      ¶Ñ                          ]],
      [[                       Á    M   3¾¬  ›¿¨Æ“ÄÆ´  Æ¹       Æ~                      ]],
      [[                          Ø     B Ã ‘8Æ· Æ   Æ   <Ë        vÞ                   ]],
      [[                        Æ      Æ    ¨èÆ   Æ    Ø    Æ          Ø                ]],
      [[                      Æ       …      ûÇ    Ê          í^          ×¯            ]],
      [[                    Æ                e      Ä                                   ]],
      [[                  M                  ô       w                                  ]],
      [[                g                    3       ¸¡                                 ]],
      [[              P                      ƒ        ¦…                                ]],
      [[            °                        í         j                                ]],
      [[                                     í          ±                               ]],
      [[                                                 Ÿ                              ]],
      [[                                                  Â                             ]],
      [[                                                   W                            ]],
    },
  },
  opts = { margin = 5 },
}
return {
  'goolord/alpha-nvim',
  config = function()
    -- require('alpha').setup(require('alpha.themes.theta').config)
    require('alpha').setup(Config)
  end,
}
