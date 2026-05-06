local function grep_quickfix_files()
  local qflist = vim.fn.getqflist()
  if vim.tbl_isempty(qflist) then
    vim.notify('Quickfix list is empty', vim.log.levels.WARN)
    return
  end

  local files = {}
  local seen = {}

  for _, item in ipairs(qflist) do
    if item.bufnr and item.bufnr > 0 then
      local name = vim.api.nvim_buf_get_name(item.bufnr)
      if name ~= '' and not seen[name] then
        seen[name] = true
        table.insert(files, name)
      end
    end
  end

  require('telescope.builtin').live_grep {
    search_dirs = files,
    prompt_title = 'Grep Quickfix Files',
  }
end

local centered = {
  layout_strategy = 'center',
  layout_config = {
    anchor = 'S',
    height = 0.40,
    width = 0.97,
    preview_cutoff = 1,
  },
}

return {
  { -- Fuzzy Finder (files, lsp, etc)
    'nvim-telescope/telescope.nvim',
    event = 'VimEnter',
    branch = '0.1.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'make',

        -- `cond` is a condition used to determine whether this plugin should be
        -- installed and loaded.
        cond = function()
          return vim.fn.executable 'make' == 1
        end,
      },
      { 'nvim-telescope/telescope-ui-select.nvim' },

      -- -- Useful for getting pretty icons, but requires a Nerd Font.
      { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
    },
    config = function()
      -- Telescope is a fuzzy finder that comes with a lot of different things that
      -- it can fuzzy find! It's more than just a "file finder", it can search
      -- many different aspects of Neovim, your workspace, LSP, and more!
      --
      -- The easiest way to use Telescope, is to start by doing something like:
      --  :Telescope help_tags
      --
      -- After running this command, a window will open up and you're able to
      -- type in the prompt window. You'll see a list of `help_tags` options and
      -- a corresponding preview of the help.
      --
      -- Two important keymaps to use while in Telescope are:
      --  - Insert mode: <c-/>
      --  - Normal mode: ?
      --
      -- This opens a window that shows you all of the keymaps for the current
      -- Telescope picker. This is really useful to discover what Telescope can
      -- do as well as how to actually do it!

      -- [[ Configure Telescope ]]
      -- See `:help telescope` and `:help telescope.setup()`
      require('telescope').setup {
        defaults = {
          prompt_prefix = '   ',
          selection_caret = '❯ ',
          path_display = { 'truncate' },
          preview = {
            treesitter = false,
          },

          file_ignore_patterns = {
            'node_modules',
            'vendor',
            '.git/',
            'dist',
            'build',
          },

          border = true,
          borderchars = {
            prompt = { '─', '│', '─', '│', '┌', '┐', '┼', '┼' },
            results = { '─', '│', '─', '│', '├', '┤', '┘', '└' },
            preview = { '─', '│', '─', '│', '┌', '┐', '┘', '└' },
          },
        },

        pickers = {
          find_files = centered,
          buffers = centered,
          oldfiles = centered,
          live_grep = centered,
          grep_string = centered,
          diagnostics = centered,
          help_tags = centered,
        },

        extensions = { ['ui-select'] = require('telescope.themes').get_cursor() },
      }

      -- Enable Telescope extensions if they are installed
      pcall(require('telescope').load_extension, 'fzf')
      pcall(require('telescope').load_extension, 'ui-select')
      pcall(require('telescope').load_extension, 'projects')

      -- See `:help telescope.b.startinguiltin`
      local builtin = require 'telescope.builtin'
      vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = '[F]ind [H]elp' })
      vim.keymap.set('n', '<leader>fk', builtin.keymaps, { desc = '[F]ind [K]eymaps' })
      vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = '[F]ind [F]iles' })
      vim.keymap.set('n', '<leader>fs', builtin.builtin, { desc = '[F]ind [S]elect Telescope' })
      vim.keymap.set('n', '<leader>fw', builtin.grep_string, { desc = '[F]ind current [W]ord' })
      vim.keymap.set('n', '<leader>fd', builtin.diagnostics, { desc = '[F]ind [D]iagnostics' })
      vim.keymap.set('n', '<leader>fr', builtin.resume, { desc = '[F]ind [R]esume' })
      vim.keymap.set('n', '<leader>f.', builtin.oldfiles, { desc = '[F]ind Recent Files ("." for repeat)' })
      vim.keymap.set('n', '<leader><leader>', builtin.buffers, { desc = '[ ] Find existing buffers' })

      -- Slightly advanced example of overriding default behavior and theme
      vim.keymap.set('n', '<leader>/', function()
        -- You can pass additional configuration to Telescope to change the theme, layout, etc.
        builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
          previewer = false,
          layout_config = {
            anchor = 'center',
          },
        })
      end, { desc = '[/] Fuzzily search in current buffer' })

      -- It's also possible to pass additional configuration options.
      --  See `:help telescope.builtin.live_grep()` for information about particular keys
      vim.keymap.set('n', '<leader>f/', function()
        builtin.live_grep {
          grep_open_files = true,
          prompt_title = 'Live Grep in Open Files',
        }
      end, { desc = '[F]ind [/] in Open Files' })

      -- Shortcut for searching your Neovim configuration files
      vim.keymap.set('n', '<leader>fn', function()
        builtin.find_files { cwd = vim.fn.stdpath 'config' }
      end, { desc = '[F]ind [N]eovim files' })

      -- NOTE: MINE
      vim.keymap.set('n', '<leader>q', grep_quickfix_files, { desc = 'Grep inside quickfix files' })

      vim.keymap.set('n', '<leader>fg', function()
        local utils = require 'telescope.utils'

        local ok, cwd = pcall(utils.get_git_root)

        if not ok then
          -- fallback: look for pom.xml or build.gradle (Java project markers)
          cwd = vim.fn.getcwd() -- search from cwd, not current file dir
        end

        builtin.live_grep { cwd = cwd }
      end, { desc = '[F]ind by [G]rep (git → fallback)' })

      vim.keymap.set('n', '<leader>fp', function()
        require('telescope').extensions.projects.projects {
          layout_config = {
            width = 0.7,
          },
          borderchars = {
            prompt = { '─', '│', '─', '│', '┌', '┐', '╯', '╰' },
            results = { '─', '│', '─', '│', '╭', '╮', '┘', '└' },
            -- preview will stay default
          },
        }
      end, { desc = '[F]ind [P]rojects' })

      vim.keymap.set('n', '<leader>fl', function()
        local utils = require 'telescope.utils'

        local ok, cwd = pcall(utils.get_git_root)
        cwd = ok and cwd or vim.fn.expand '%:p:h'

        local success = pcall(builtin.git_files, centered, { cwd = cwd })
        if not success then
          builtin.find_files { centered, cwd = cwd }
        end
      end, { desc = '[F]ind [L]ocal files (git → fallback)' })
    end,
  },
}
