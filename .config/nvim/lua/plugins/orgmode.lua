return {
    'nvim-orgmode/orgmode',
    dependencies = {
        { 'nvim-treesitter/nvim-treesitter', lazy = true },
    },
    -- event = 'VeryLazy',
    config = function()
        -- Setup cmp
        -- require('cmp').setup({
        --     sources = {
        --         { name = 'orgmode' }
        --     }
        -- })

        -- Setup orgmode
        require('orgmode').setup({
            org_agenda_files = { '~/perso/org/gtd.org', '~/perso/org/tickler.org' },
            org_default_notes_file = '~/perso/org/inbox.org',
            org_todo_keywords = { "TODO(t)", "WAITING(w)", "|", "DONE(d)", "CANCELLED(c)" },
            org_capture_templates = {
                t = {
                    description = 'Task',
                    template = '* TODO %?\n'
                },
                e = {
                    description = 'Event',
                    template = '** %?\n %U',
                    target = '~/perso/org/tickler.org',
                    -- headline = 'One-time',
                }
            }
        })
    end,
}
