return {
  'ThePrimeagen/harpoon',
  branch = 'harpoon2',
  dependencies = { 'nvim-lua/plenary.nvim', 'nvim-telescope/telescope.nvim' },
  config = function()
    local harpoon = require 'harpoon'
    function SetKey(n)
      vim.keymap.set('n', '<Leader>g' .. n, function()
        harpoon:list():select(n)
      end, { desc = 'index [' .. n .. ']' })
    end
    -- REQUIRED
    harpoon:setup()
    -- REQUIRED

    vim.keymap.set('n', '<leader>ga', function()
      harpoon:list():add()
    end, { desc = '[A]dd a new target' })
    vim.keymap.set('n', '<Leader>gm', function()
      harpoon.ui:toggle_quick_menu(harpoon:list())
    end, { desc = 'quick [M]enu' })
    -- Set keys 1-9 for the bookmarks
    for i = 1, 9 do
      SetKey(i)
    end

    -- Toggle previous & next buffers stored within Harpoon list
    vim.keymap.set('n', '<Leader>gp', function()
      harpoon:list():prev()
    end, { desc = '[P]revious' })
    vim.keymap.set('n', '<Leader>gn', function()
      harpoon:list():next()
    end, { desc = '[N]ext' })

    -- basic telescope configuration
    local conf = require('telescope.config').values
    local function toggle_telescope(harpoon_files)
      local file_paths = {}
      for _, item in ipairs(harpoon_files.items) do
        table.insert(file_paths, item.value)
      end

      require('telescope.pickers')
        .new({}, {
          prompt_title = 'Harpoon',
          finder = require('telescope.finders').new_table {
            results = file_paths,
          },
          previewer = conf.file_previewer {},
          sorter = conf.generic_sorter {},
        })
        :find()
    end

    vim.keymap.set('n', '<Leader>gh', function()
      toggle_telescope(harpoon:list())
    end, { desc = '[H]arpoon window' })
  end,
}
