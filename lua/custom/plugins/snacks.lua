vim.keymap.set('n', '<leader>t', function()
  require('snacks').terminal.toggle()
end, { desc = 'Toggle Terminal' })

return {
  'folke/snacks.nvim',
  priority = 1000,
  lazy = false,
  ---@type snacks.Config
  opts = {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
    dashboard = {
      enabled = true,
      preset = {
        header = [[
_____   __          ___    ______            
___  | / /____________ |  / /__(_)______ ___ 
__   |/ /_  _ \  __ \_ | / /__  /__  __ `__ \
_  /|  / /  __/ /_/ /_ |/ / _  / _  / / / / /
/_/ |_/  \___/\____/_____/  /_/  /_/ /_/ /_/ 
                                                                                           
       ]],
      },
      sections = {
        { section = 'header' },
        {
          pane = 2,
          section = 'terminal',
          cmd = 'colorscript -e square',
          height = 5,
          padding = 1,
        },
        { section = 'keys', gap = 1, padding = 1 },
        { pane = 2, icon = ' ', title = 'Recent Files', section = 'recent_files', indent = 2, padding = 1 },
        { pane = 2, icon = ' ', title = 'Projects', section = 'projects', indent = 2, padding = 1 },
        {
          pane = 2,
          icon = ' ',
          title = 'Git Status',
          section = 'terminal',
          enabled = function()
            return Snacks.git.get_root() ~= nil
          end,
          cmd = 'git status --short --branch --renames',
          height = 5,
          padding = 1,
          ttl = 5 * 60,
          indent = 3,
        },
        { section = 'startup' },
      },
    },
    explorer = { enabled = false },
    indent = { enabled = true },
    input = { enabled = false },
    picker = { enabled = true },
    notifier = { enabled = true },
    quickfile = { enabled = true },
    scope = { enabled = true },
    scroll = { enabled = false },
    statuscolumn = { enabled = true },
    words = { enabled = false },
    terminal = { enabled = true },
    animate = { enabled = true },
    bigfile = { enabled = true },
  },
}
