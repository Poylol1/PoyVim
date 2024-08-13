return {
  'lervag/vimtex',
  lazy = false, -- we don't want to lazy load VimTeX
  tag = 'v2.15', -- uncomment to pin to a specific release
  init = function()
    Current = 0
    -- VimTeX configuration goes here, e.g.
    -- Viewer options: One may configure the viewer either by specifying a built-in
    -- viewer method:
    vim.g.vimtex_view_method = 'zathura'

    vim.cmd 'set shiftwidth=2'
    vim.cmd 'set tabstop=2'

    vim.cmd 'set conceallevel=1'
    vim.cmd 'let g:tex_conceal="abdmgs"'

    -- Or with a generic interface:
    vim.g.vimtex_view_general_viewer = 'okular'
    vim.g.vimtex_view_general_options = 'unique file:@pdf\\#src:@line@tex'

    -- VimTeX uses latexmk as the default compiler backend. If you use it, which is
    -- strongly recommended, you probably don't need to configure anything. If you
    -- want another compiler backend, you can change it as follows. The list of
    -- supported backends and further explanation is provided in the documentation,
    -- see ":help vimtex-compiler".
    vim.g.vimtex_compiler_method = 'latexmk'

    -- simple utils functions
    function Split(str, divider)
      Turner = {}
      Currentstr = ''
      for i = 1, #str do
        local currentchar = str:sub(i, i)
        if divider ~= currentchar then
          Currentstr = Currentstr .. currentchar
        else
          table.insert(Turner, Currentstr)
          Currentstr = ''
        end
      end
      table.insert(Turner, Currentstr)
      return Turner
    end

    function Getfilename(testpat)
      for i = #testpat, 1, -1 do
        if testpat:sub(i, i) == '/' then
          return string.sub(testpat, i + 1, -5)
        end
      end
      return error 'invalid string'
    end

    function Getrelativepath(str, objective, side)
      for i = 1, #str - #objective, 1 do
        if str:sub(i, i + #objective - 1) == objective then
          if side == 1 then
            return str:sub(i + #objective)
          end
          if side == -1 then
            return str:sub(1, i - 2)
          end
          return str:sub(i)
        end
      end
      return error 'invalid string'
    end

    -- stops the latex sesison
    function Run_cleartex()
      BufferName = vim.api.nvim_buf_get_name(Current)
      -- Get the current buffer name
      local file_path = string.sub(BufferName, 1, -5)
      --extensions for lua
      local extensions = { 'aux', 'fdb_latexmk', 'fls', 'log', 'synctex.gz' }
      -- removes all trash files
      print(file_path .. '.file')
      for i = 1, #extensions do
        os.remove(file_path .. '.' .. extensions[i])
      end
      -- moves the pdf file to the pdf directory'
      -- ~2/3D4o5c6u7m8e9n10t11s12/13c14a15l16c17_18n19o20t21e22s23/24l25a26t27e28x29/30
      local relativepath = Getrelativepath(BufferName, 'latex', 1)
      local pdfpath = Split(relativepath, '/')

      local buildingpath = Getrelativepath(BufferName, 'latex', -1) .. '/pdf'
      local filename = Getfilename(BufferName)
      for i = 1, #pdfpath - 1 do
        buildingpath = buildingpath .. '/' .. pdfpath[i]
        os.execute('if ! [ -d ' .. buildingpath .. ' ]; then mkdir ' .. buildingpath .. ' ; fi')
      end

      os.execute('mv ' .. file_path .. '.pdf ' .. buildingpath .. '/' .. filename .. '.pdf')
      -- closes zathura
      os.execute 'pkill -f zathura'
    end
    -- util to simpler commands
    local function texcommands(key, action, opts)
      vim.api.nvim_buf_set_keymap(Current, 'n', key, action, opts)
    end
    -- actual commands
    local function vimtex_keymaps()
      texcommands('\\c', '<ESC>:VimtexCompile<CR>', { desc = '[C]ompiles the file' })

      texcommands('\\k', '', { noremap = true, silent = true, callback = Run_cleartex, desc = '[K]ills the compilation' })
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
    --opens stuff
    --vim.api.nvim_create_autocmd('BufEnter', {
    --  callback = function()
    --    if vim.api.nvim_buf_get_name(Current):match '%.tex$' then
    --      vim.cmd 'VimtexCompile'
    --    end
    --  end,
    --})
    -- closes stuff
    --vim.api.nvim_create_autocmd({ 'BufLeave', 'VimLeave' }, {
    --callback = function()
    --if vim.api.nvim_buf_get_name(Current):match '%.tex$' then
    --Run_cleartex()
    --end
    --end,
    --})
  end,
}
