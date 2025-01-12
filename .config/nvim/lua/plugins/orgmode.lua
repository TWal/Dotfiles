return {
    {
        'nvim-orgmode/orgmode',
        dependencies = {
            { 'nvim-treesitter/nvim-treesitter', lazy = true },
        },
        -- event = 'VeryLazy',
        config = function()
            -- Setup cmp
            -- require('cmp').setup({
            --     sources = {
            --         { name = 'orgmode' }
            --     }
            -- })

            -- Setup orgmode
            require('orgmode').setup({
                org_agenda_files = { '~/perso/org/gtd/*' },
                org_default_notes_file = '~/perso/org/inbox.org',
                org_todo_keywords = { "TODO(t)", "WAITING(w)", "|", "DONE(d)", "CANCELLED(c)" },
                org_capture_templates = {
                    c = {
                        description = 'Calendar',
                        template = '** %?\n %U',
                        target = '~/perso/org/gtd/calendar.org',
                        headline = 'One-time'
                    }
                },
                mappings = {
                    agenda = {
                        -- more consistent mapping wrt calendar input mode
                        org_agenda_later = ">",
                        org_agenda_earlier = "<",
                    },
                    org = {
                        org_export = false, -- free <Leader>oe for "edit file" (below)
                        org_refile = false,  -- use telescope-orgmode instead
                    }
                }
            })

            vim.keymap.set("n", "<leader>oei", ":e ~/perso/org/inbox.org<cr>", { silent = true, remap = false, desc = "Inbox" })
            vim.keymap.set("n", "<leader>oeg", ":e ~/perso/org/gtd/gtd.org<cr>", { silent = true, remap = false, desc = "GTD" })
            vim.keymap.set("n", "<leader>oec", ":e ~/perso/org/gtd/calendar.org<cr>", { silent = true, remap = false, desc = "Calendar" })
        end,
    },
    {
        "nvim-orgmode/telescope-orgmode.nvim",
        event = "VeryLazy",
        dependencies = {
            "nvim-orgmode/orgmode",
            "nvim-telescope/telescope.nvim",
        },
        config = function()
            require("telescope").load_extension("orgmode")

            vim.api.nvim_create_autocmd('FileType', {
                pattern = 'org',
                callback = function()
                    vim.keymap.set("n", "<leader>or", require("telescope").extensions.orgmode.refile_heading, { buffer = true, desc = "Refile" })
                    vim.keymap.set("n", "<leader>li", require("telescope").extensions.orgmode.insert_link, { buffer = true, desc = "Insert link" })
                end,
            })
            vim.keymap.set("n", "<leader>oh", require("telescope").extensions.orgmode.search_headings, { desc = "Search headings" })
        end,
    }
}
