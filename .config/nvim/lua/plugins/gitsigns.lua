return {
    "lewis6991/gitsigns.nvim",
    config = function()
        require("gitsigns").setup({
            current_line_blame_opts = {
                delay = 0,
            },
            on_attach = function(bufnr)
                local gitsigns = package.loaded.gitsigns

                local function map(mode, l, r, opts)
                    opts = opts or {}
                    opts.buffer = bufnr
                    vim.keymap.set(mode, l, r, opts)
                end

                -- Navigation
                map("n", "<Leader>vp", gitsigns.prev_hunk, { desc = "Previous hunk" })
                map("n", "<Leader>vn", gitsigns.next_hunk, { desc = "Next hunk" })

                -- Staging
                map("n", "<Leader>vss", gitsigns.stage_hunk, { desc = "Stage hunk" })
                map("v", "<Leader>vss", function() gitsigns.stage_hunk {vim.fn.line("."), vim.fn.line("v")} end, { desc = "Stage hunk" })
                map("n", "<Leader>vsr", gitsigns.reset_hunk, { desc = "Reset hunk" })
                map("v", "<Leader>vsr", function() gitsigns.reset_hunk {vim.fn.line("."), vim.fn.line("v")} end, { desc = "Reset hunk" })
                map("n", "<Leader>vsS", gitsigns.stage_buffer, { desc = "Stage buffer" })
                map("n", "<Leader>vsu", gitsigns.undo_stage_hunk, { desc = "Undo stage hunk"})
                map("n", "<Leader>vsR", gitsigns.reset_buffer, { desc = "Reset buffer"})

                -- Toggles
                map("n", "<Leader>vtb", gitsigns.toggle_current_line_blame, { desc = "Current line blame" })
                map("n", "<Leader>vtd", gitsigns.toggle_deleted, { desc = "Deleted" })
                map("n", "<Leader>vts", gitsigns.toggle_signs, { desc = "Signs" })
                map("n", "<Leader>vtn", gitsigns.toggle_numhl, { desc = "Number highlight" })
                map("n", "<Leader>vtl", gitsigns.toggle_linehl, { desc = "Line highlight" })
                map("n", "<Leader>vtw", gitsigns.toggle_word_diff, { desc = "Word diff" })

                -- Diff
                map("n", "<Leader>vdh", gitsigns.diffthis, { desc = "With HEAD" })
                map("n", "<Leader>vdH", function() gitsigns.diffthis("~") end, { desc = "With HEAD~" })
                map("n", "<Leader>vdc", function() vim.ui.input({ prompt = "Commit id: "}, function(input) gitsigns.diffthis(input) end) end, { desc = "Diff" })

                map("n", "<Leader>vP", gitsigns.preview_hunk, { desc = "Preview hunk"})
                map("n", "<Leader>vb", function() gitsigns.blame_line{full=true} end, { desc = "Blame line" })

                -- Text object
                map({"o", "x"}, "ih", ":<C-U>Gitsigns select_hunk<CR>")
            end
        })
    end,
}
