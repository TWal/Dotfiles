return {
    "neovim/nvim-lspconfig",
    event = { "BufRead", "BufNewFile" },
    config = function()
        local neodev = require('neodev')
        neodev.setup({})
        local lspconfig = require('lspconfig')
        -- lspconfig.pyright.setup {}
        -- lspconfig.tsserver.setup {}
        lspconfig.rust_analyzer.setup {
            -- Server-specific settings. See `:help lspconfig-setup`
            settings = {
                ['rust-analyzer'] = {},
            },
        }
        lspconfig.lua_ls.setup {}
        lspconfig.texlab.setup {}
        lspconfig.pylsp.setup {}


        -- Global mappings.
        -- See `:help vim.diagnostic.*` for documentation on any of the below functions
        vim.keymap.set('n', '<Leader>dd', vim.diagnostic.open_float, { desc = "Open window" })
        vim.keymap.set('n', '<Leader>dp', vim.diagnostic.goto_prev, { desc = "Goto previous" })
        vim.keymap.set('n', '<Leader>dn', vim.diagnostic.goto_next, { desc = "Goto next" })
        vim.keymap.set('n', '<Leader>dP', function () vim.diagnostic.goto_prev({ severity = vim.diagnostic.severity.ERROR }) end, { desc = "Goto previous error" })
        vim.keymap.set('n', '<Leader>dN', function () vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.ERROR }) end, { desc = "Goto next error" })
        vim.keymap.set('n', '<Leader>dh', function () vim.diagnostic.disable(0) end, { desc = "Hide" })
        vim.keymap.set('n', '<Leader>ds', function () vim.diagnostic.enable(0) end, { desc = "Show" })
        -- vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist)

        -- Use LspAttach autocommand to only map the following keys
        -- after the language server attaches to the current buffer
        vim.api.nvim_create_autocmd('LspAttach', {
            group = vim.api.nvim_create_augroup('UserLspConfig', {}),
            callback = function(ev)
                -- Enable completion triggered by <c-x><c-o>
                vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

                -- Buffer local mappings.
                -- See `:help vim.lsp.*` for documentation on any of the below functions
                local opts = { buffer = ev.buf }
                vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
                vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
                vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
                -- vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
                -- vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
                -- vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
                -- vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
                -- vim.keymap.set('n', '<space>wl', function()
                --     print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
                -- end, opts)
                -- vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
                -- vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
                -- vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
                -- vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
                -- vim.keymap.set('n', '<space>f', function()
                --     vim.lsp.buf.format { async = true }
                -- end, opts)
            end,
        })
    end,
}
