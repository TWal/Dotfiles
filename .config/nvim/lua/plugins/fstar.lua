return {
    "TWal/fstar.nvim",
    dev = true,
    config = function()
        local fstar = require('fstar')

        fstar.setup({
            -- fstar_lsp_path = "/home/twallez/perso/code/fstar-lsp/proxy.sh",
            fstar_lsp_path = "/home/twallez/perso/code/fstar-lsp/target/debug/fstar-lsp",
        })

        vim.keymap.set("n", "<C-c><C-v>", fstar.commands.verify_all, { remap = false, desc = "verify buffer" })
        vim.keymap.set("n", "<C-c><C-l>", fstar.commands.lax_to_position, { remap = false, desc = "verify lax to position" })
        vim.keymap.set("n", "<C-c><CR>",  fstar.commands.verify_to_position, { remap = false, desc = "verify to position" })
        vim.keymap.set("n", "<C-c><C-c>", fstar.commands.cancel_all, { remap = false, desc = "cancel" })
        vim.keymap.set("n", "<C-c><C-r>", fstar.commands.reload_dependencies, { remap = false, desc = "reload dependencies"})
        vim.keymap.set("n", "<C-c><C-k>", fstar.commands.restart_z3, { remap = false, desc = "restart Z3" })
    end,
}
