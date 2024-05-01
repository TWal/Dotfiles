vim.keymap.set("n", " ", "<Nop>", { silent = true, remap = false })
vim.g.mapleader = " "
-- TODO
vim.g.maplocalleader = "\\"

vim.keymap.set("x", "<", "<gv", { silent = true, remap = false })
vim.keymap.set("x", ">", ">gv", { silent = true, remap = false })

vim.keymap.set("n", "0", "^", { silent = true, remap = false, desc = "Start of line (non-blank)" })
vim.keymap.set("n", "^", "0", { silent = true, remap = false, desc = "Start of line" })

vim.keymap.set("n", "ZW", ":w<cr>", { silent = true, remap = false, desc = "Save file" })
vim.keymap.set("n", "ZAW", ":wa<cr>", { silent = true, remap = false, desc = "Save all files" })
vim.keymap.set("n", "ZAQ", ":qa!<cr>", { silent = true, remap = false, desc = "Quit without saving (all files)" })
vim.keymap.set("n", "ZT", ":tabe ", { remap = false, desc = "Open new tab" })

vim.keymap.set("n", "<leader>`",  ":e #<cr>", { silent = true, remap = false, desc = "Switch to last buffer" })
vim.keymap.set("n", "<leader>bl", ":e #<cr>", { silent = true, remap = false, desc = "Switch to last buffer" })
vim.keymap.set("n", "<leader>bk", ":bdelete<cr>", { silent = true, remap = false, desc = "Kill buffer" })
vim.keymap.set("n", "<leader>bd", ":bdelete<cr>", { silent = true, remap = false, desc = "Kill buffer" })
vim.keymap.set("n", "<leader>b[", ":bprevious<cr>", { silent = true, remap = false, desc = "Previous buffer" })
vim.keymap.set("n", "<leader>bp", ":bprevious<cr>", { silent = true, remap = false, desc = "Previous buffer" })
vim.keymap.set("n", "<leader>b]", ":bnext<cr>", { silent = true, remap = false, desc = "Next buffer" })
vim.keymap.set("n", "<leader>bn", ":bnext<cr>", { silent = true, remap = false, desc = "Next buffer" })
