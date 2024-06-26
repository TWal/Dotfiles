return {
    'navarasu/onedark.nvim',
    lazy = false, -- load this during startup because it is the main colorscheme
    priority = 1000, -- make sure to load this before all the other start plugins
    config = function()
        require('onedark').setup({
            style = 'warmer',
        })
        require('onedark').load()
    end,
}
