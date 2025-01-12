return {
    "folke/which-key.nvim",
    event = "VeryLazy",
    config = function()
        vim.o.timeout = true
        vim.o.timeoutlen = 500

        local wk = require("which-key")
        wk.setup({
            icons = {
                mappings = false,
            },
            defer = function(ctx)
                return ctx.mode == "v" or ctx.mode == "V" or ctx.mode == "<C-V>"
            end,
        })

        wk.add({
            { "<Leader>f", group = "file" },
            { "<Leader>b", group = "buffer" },
            { "<Leader>d", group = "diagnostic" },
            { "<Leader>v", group = "git" },
            { "<Leader>vs", group = "stage" },
            { "<Leader>vt", group = "toggle" },
            { "<Leader>vd", group = "diff" },
            { "<Leader>oe", group = "edit org" },
        })
    end,
}
