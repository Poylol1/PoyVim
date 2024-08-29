return {
  'lervag/vimtex',
  lazy = false, -- we don't want to lazy load VimTeX
  tag = 'v2.15', -- uncomment to pin to a specific release
  init = function()
    Current = 0
    -- Current = vim.api.nvim_get_current_buf()
    -- VimTeX configuration goes here, e.g.
    -- Viewer options: One may configure the viewer either by specifying a built-in
    -- viewer method:
    vim.g.vimtex_view_method = 'zathura'

    vim.cmd 'set shiftwidth=2'
    vim.cmd 'set tabstop=2'

    vim.cmd 'set conceallevel=2'
    vim.g.vimtex_syntax_conceal = {
      accents = 1,
      ligatures = 1,
      cites = 1,
      fancy = 1,
      spacing = 1,
      greek = 1,
      math_bounds = 1,
      math_delimiters = 1,
      math_fracs = 1,
      math_symbols = 1,
      math_super_sub = 1,
      sections = 1,
      styles = 1,
    }

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
    --#region Utils

    -- Takes a filepath and retuns true if it exist or false it is does not
    -- @param file string
    -- @returns bool
    function FileExist(file_name)
      local f = io.open(file_name, 'r')
      if f ~= nil then
        io.close(f)
        return true
      else
        return false
      end
    end

    -- Takes a string and splits it based on a divider
    -- ex. Split('water.fire','.')
    -- returns {water,fire}
    -- @param str string
    -- @param divider string
    -- @return table
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

    -- Gets the file name of a path
    -- based on a file path
    --
    -- ex.
    -- testpath = 'home/user/documents/testDoc.tex'
    -- Getfilename(testpath)
    -- returns testDoc.tex
    --
    -- to get the other part of the string
    --
    -- other_part = testpath:sub{-#Getfilename(testpath)}
    --
    -- @param testpat string -- file path
    -- @return string
    function Getfilename(testpat)
      for i = #testpat, 1, -1 do
        if testpat:sub(i, i) == '/' then
          return string.sub(testpat, i + 1)
        end
      end
      return error 'invalid string'
    end

    -- Get the relative path of a file
    -- based on a str and an objective (exclusive)
    -- The side gives you one each part of the string
    --
    -- local filepath = 'home/user/Documents/latex/file'
    -- ex. GetStringSide(filepath, Documents, 1)
    -- returns 'latex/file'
    --
    -- --in contrast by using -1
    --
    -- GetStringSide(filepath, Documents, -1)
    -- returns 'home/user/'
    --
    -- @param str string
    -- @param objective string
    -- @param side int -- can be 1 or -1
    -- @return string
    function GetStringSide(str, objective, side)
      for i = 1, #str - #objective, 1 do
        if str:sub(i, i + #objective - 1) == objective then
          if side == 1 then
            return str:sub(i + #objective + 1)
          end
          if side == -1 then
            return str:sub(1, i - 1)
          end
          return str:sub(i)
        end
      end
      return error 'invalid string'
    end
    --#endregion

    -- stops the latex sesison
    function Run_cleartex()
      BufferName = vim.api.nvim_buf_get_name(Current)
      -- Get the current buffer name
      local file_path = string.sub(BufferName, 1, -5)
      --extensions for lua
      local extensions = { 'aux', 'fdb_latexmk', 'fls', 'log', 'synctex.gz' }
      -- removes all trash files
      for i = 1, #extensions do
        os.remove(file_path .. '.' .. extensions[i])
      end
      -- moves the pdf file to the pdf directory'
      local relativepath = GetStringSide(BufferName, '/latex', 1)
      local pdfpath = Split(relativepath, '/')

      local buildingpath = GetStringSide(BufferName, '/latex', -1) .. '/pdf'
      local filename = Getfilename(BufferName):sub(1, -5)
      for i = 1, #pdfpath - 1 do
        buildingpath = buildingpath .. '/' .. pdfpath[i]
        os.execute('if ! [ -d ' .. buildingpath .. ' ]; then mkdir ' .. buildingpath .. ' ; fi')
      end
      if FileExist(file_path .. '.pdf') then
        os.execute('mv ' .. file_path .. '.pdf ' .. buildingpath .. '/' .. filename .. '.pdf')
      end
      --print('PDF in ' .. buildingpath .. '/' .. filename .. '.pdf')
      -- closes zathura
      os.execute 'pkill -f zathura'
    end
    -- util to simpler commands
    local function texcommands(key, action, opts)
      vim.api.nvim_buf_set_keymap(Current, 'n', key, action, opts)
    end

    function NewSubfile()
      BufferName = vim.api.nvim_buf_get_name(Current)
      local main_path = BufferName:sub(1, -(#Getfilename(BufferName) + 1))
      if not FileExist(BufferName) then
        return
      end
      local main_file_lines = {}
      for line in io.lines(BufferName) do
        -- equivalent to this regex ^(\\subfile\{.*?\})$
        if string.match(line, '^\\subfile%{.-%}$') then
          table.insert(main_file_lines, line)
        end
      end

      -- get text on the line
      function SetUpNewFile(line_text)
        -- gets the relative file path \subfile{.*} -> .*
        local relative_path = GetStringSide(line_text, 'subfile', 1):sub(1, -2)
        local directory_split = Split(relative_path, '/')
        if FileExist(main_path .. relative_path) then
          return
        end

        local building_path = main_path
        local relative_layers = ''

        for i = 1, #directory_split - 1 do
          building_path = building_path .. '/' .. directory_split[i]
          relative_layers = relative_layers .. '../'
          os.execute('if ! [ -d ' .. building_path .. ' ]; then mkdir ' .. building_path .. '; fi')
        end

        os.execute('touch ' .. main_path .. relative_path)

        local new_subfile = io.open(main_path .. relative_path, 'w')

        if new_subfile == nil then
          return error 'IDK What happened here'
        end

        new_subfile:write('\\documentclass[ ' .. relative_layers .. Getfilename(BufferName) .. ' ]{subfiles} \n')
        new_subfile:write '\\begin{document} \n \\end{document}'
      end

      for i = 1, #main_file_lines, 1 do
        SetUpNewFile(main_file_lines[i])
      end
    end

    -- actual commands
    local function vimtex_keymaps()
      vim.cmd 'TSBufDisable highlight'
      texcommands('\\c', '<ESC>:VimtexCompile<CR>', { desc = '[C]ompiles the file' })
      texcommands('\\k', '', { noremap = true, silent = true, callback = Run_cleartex, desc = '[K]ills the compilation' })
      texcommands('\\s', '', { noremap = true, silent = true, callback = NewSubfile, desc = 'creates the [S]ubfile' })
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
    vim.api.nvim_create_autocmd({--[[ 'BufLeave',--]]
      'VimLeave',
    }, {
      callback = function()
        if vim.api.nvim_buf_get_name(Current):match '%.tex$' then
          Run_cleartex()
        end
      end,
    })
  end,
}
