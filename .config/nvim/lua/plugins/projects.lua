return {
    "ahmedkhalf/project.nvim",
    config = function()
        require("project_nvim").setup {
            patterns = { ".git" },
        }

        require('telescope').load_extension('projects')
        vim.keymap.set('n', '<leader>fp',  require('telescope').extensions.projects.projects, {desc = "Find project"})
    end
}
