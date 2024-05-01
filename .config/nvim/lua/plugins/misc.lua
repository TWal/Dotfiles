return {
    { "ap/vim-you-keep-using-that-word" },
    { "tpope/vim-repeat" },
    { "chaoren/vim-wordmotion",
        init = function ()
            vim.g.wordmotion_prefix = "-"
        end
    }
}
