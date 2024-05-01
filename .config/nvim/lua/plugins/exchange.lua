return {
    "tommcdo/vim-exchange",
    init = function()
        vim.g.exchange_no_mappings = true
        vim.keymap.set("n", "gx", "<Plug>(Exchange)", {desc = "Exchange"})
        vim.keymap.set("x", "gx", "<Plug>(Exchange)", {desc = "Exchange"})
        vim.keymap.set("n", "gxx", "<Plug>(ExchangeLine)", {desc = "Exchange line"})
        vim.keymap.set("n", "gX", "<Plug>(ExchangeClear)", {desc = "Exchange clear"})
    end
}
