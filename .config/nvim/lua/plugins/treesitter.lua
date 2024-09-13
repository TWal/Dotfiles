return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function ()
        local treesitter = require("nvim-treesitter.configs")

        treesitter.setup({
            ensure_installed = { "arduino", "bash", "bibtex", "c", "cmake", "comment", "cpp", "css", "dockerfile", "html", "javascript", "json", "latex", "lua", "make", "nix", "ocaml", "python", "rust", "scss", "toml", "vim", "yaml"},
            sync_install = false,
            highlight = {
                enable = true,
                disable = { "latex", }, -- Handled by vimtex
            },
            indent = { enable = true },
        })
    end
}
