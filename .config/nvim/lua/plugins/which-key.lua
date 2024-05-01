return {
    "folke/which-key.nvim",
    event = "VeryLazy",
    config = function()
        vim.o.timeout = true
        vim.o.timeoutlen = 500

        local wk = require("which-key")
        wk.setup({
            -- your configuration comes here
            -- or leave it empty to use the default settings
            -- refer to the configuration section below
        })

        wk.register({
            ["<Leader>f"] = { name = "+file" },
            ["<Leader>b"] = { name = "+buffer" },
            ["<Leader>d"] = { name = "+diagnostic" },
            ["<Leader>v"] = { name = "+git" },
            ["<Leader>vs"] = { name = "+stage" },
            ["<Leader>vt"] = { name = "+toggle" },
            ["<Leader>vd"] = { name = "+diff" },
        })
    end,
}
