return {
  'lervag/vimtex',
  lazy = false, -- we don't want to lazy load VimTeX
  tag = 'v2.15', -- uncomment to pin to a specific release
  init = function()
    -- VimTeX configuration goes here, e.g.
    -- Viewer options: One may configure the viewer either by specifying a built-in
    -- viewer method:
    vim.g.vimtex_view_method = 'zathura'

    -- Or with a generic interface:
    vim.g.vimtex_view_general_viewer = 'okular'
    vim.g.vimtex_view_general_options = 'unique file:@pdf\\#src:@line@tex'

    -- VimTeX uses latexmk as the default compiler backend. If you use it, which is
    -- strongly recommended, you probably don't need to configure anything. If you
    -- want another compiler backend, you can change it as follows. The list of
    -- supported backends and further explanation is provided in the documentation,
    -- see ":help vimtex-compiler".
    vim.g.vimtex_compiler_method = 'latexmk'
    -- stops the latex sesison

    function Run_cleartex()
      -- Get the current buffer name
      local file_path = string.sub(vim.api.nvim_buf_get_name(0), 1, -5)
      --extensions for lua
      local extensions = { 'aux', 'fdb_latexmk', 'fls', 'log', 'synctex.gz' }
      -- command to stop latex compilation
      vim.cmd 'VimtexStopAll'
      -- removes all trash files
      for i = 1, #extensions do
        os.remove(file_path .. '.' .. extensions[i])
      end
      -- moves the pdf file to the pdf directory
      os.execute('mv ' .. file_path .. '.pdf ' .. '../pdf/')
      -- closes zathura
      os.execute 'pkill -f zathura'
    end
    -- util to simpler commands
    local function texcommands(key, action, opts)
      vim.api.nvim_buf_set_keymap(vim.api.nvim_get_current_buf(), 'n', key, action, opts)
    end
    -- actual commands
    local function vimtex_keymaps()
      texcommands('\\c', '<ESC>:VimtexCompile<CR>', { desc = '[C]ompiles the file' })

      texcommands('\\k', '', { noremap = true, silent = true, callback = Run_cleartex, desc = '[K]ills the compilation' })

      texcommands('\\p', ':lua print("this works")', {})
    end
    -- creates autogroup for second autocommand
    vim.api.nvim_create_augroup('TexKeymaps', { clear = true })
    -- sets the special keymaps
    vim.api.nvim_create_autocmd('FileType', { pattern = 'tex', callback = vimtex_keymaps, group = 'TexKeymaps' })

    --vim.api.nvim_create_autocmd('FileType', {
    --  pattern = 'tex',
    --  callback = function()
    --    vim.cmd 'TSBufDisable'
    --  end,
    --  group = 'TexKeymaps',
    --})
    -- compiles when open
    --vim.api.nvim_create_autocmd('VimEnter', {
    --  callback = function()
    --    if vim.api.nvim_buf_get_name(0):match '%.tex$' then
    --      vim.cmd 'VimtexCompile'
    --   end
    --  end,
    --})
    -- closes stuff
    vim.api.nvim_create_autocmd({ 'BufLeave', 'VimLeave' }, {
      callback = function()
        if vim.api.nvim_buf_get_name(0):match '%.tex$' then
          Run_cleartex()
        end
      end,
    })
  end,
}
