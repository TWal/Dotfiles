-- General

vim.opt.modeline = false -- disable modelines for security

-- Search

vim.opt.ignorecase = true -- ignore case
vim.opt.smartcase = true -- but do smart case matching

-- Tabs

vim.opt.expandtab = true
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.api.nvim_create_autocmd({"BufEnter"}, {
    pattern = {"Makefile", "keywords.txt"},
    callback = function() vim.opt.expandtab = false end,
})

