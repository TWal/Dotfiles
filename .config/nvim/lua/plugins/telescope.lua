--TODO fzy sorter
return {
    'nvim-telescope/telescope.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
        local telescope = require('telescope.builtin')

        -- File
        vim.keymap.set('n', '<leader>ff', telescope.find_files, {desc = "Find file"})
        vim.keymap.set('n', '<leader>.',  telescope.find_files, {desc = "Find file"})
        vim.keymap.set('n', '<leader>fr', telescope.oldfiles, {desc = "Find recent"})

        -- Buffer
        vim.keymap.set('n', '<leader>bb', telescope.buffers, {desc = "Find buffer"})
        vim.keymap.set('n', '<leader>,',  telescope.buffers, {desc = "Find buffer"})

        -- Diagnostics
        vim.keymap.set('n', '<leader>dl', function() telescope.diagnostics({bufnr = 0}) end, {desc = "List (buffer)"})
        vim.keymap.set('n', '<leader>dL', telescope.diagnostics, {desc = "List (project)"})

        -- Misc
        vim.keymap.set('n', '<leader>/',  telescope.live_grep, {desc = "Search text"})
        vim.keymap.set('n', '<leader>*',  telescope.grep_string, {desc = "Search text under cursor"})
    end
}
