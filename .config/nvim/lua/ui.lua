vim.opt.scrolloff = 5 -- 5 line above / below the cursor when scrolling
-- TODO keep?
vim.opt.mat = 1 -- when typing ')', highlight the matching 0.1s '(' (also work with [] and {})
vim.opt.cursorline = true -- highlight where the cursor is

-- Numbers
-- set relative number, and absolute number where the 0 is
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.numberwidth = 4
vim.api.nvim_create_autocmd({"InsertEnter"}, {
    pattern = {"*"},
    callback = function() vim.opt.relativenumber = false end,
})
vim.api.nvim_create_autocmd({"InsertLeave"}, {
    pattern = {"*"},
    callback = function() vim.opt.relativenumber = true end,
})

-- Status line

vim.opt.statusline =
    "%f" -- File name
 .. "%m" -- Modified flag
 .. "%r" -- Readonly flag
 .. "%h" -- Help buffer flag
 .. "%w" -- Preview window flag
 .. " %y" -- Space + file type
 .. " [%{&fileformat}]" -- File format
 .. " [%{&fileencoding}]" -- File encoding
 .. "%=" -- Left / Right separator
 .. "[%b-0x%B]" -- Ascii character in decimal and hexadecimal
 .. " [%c%V," -- Cursor column
 .. " %l" -- Cursor line
 .. "/%L]" -- Total line
 .. " %P" -- Percent of the file
 .. " " -- Final space

-- Wild menu

vim.opt.wildmode = "longest:full,full"
