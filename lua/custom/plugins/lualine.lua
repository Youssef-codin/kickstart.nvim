return {
  'nvim-lualine/lualine.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    local theme = require 'custom.lualine-config.lualinetheme'

    local mode_names = {
      n = 'NORMAL',
      i = 'INSERT',
      v = 'VISUAL',
      V = 'V-LINE',
      [''] = 'V-BLOCK',
      c = 'COMMAND',
      R = 'REPLACE',
      t = 'TERMINAL',
    }

    local function project_name()
      local ok, project = pcall(require, 'project_nvim.project')
      if ok and project.get_project_name then
        local name = project.get_project_name()
        if name ~= '' then
          return ' ' .. name
        end
      end
      -- fallback: just dir name
      return ' ' .. vim.fn.fnamemodify(vim.fn.getcwd(), ':t')
    end

    require('lualine').setup {
      options = {
        theme = theme,
        component_separators = '',
        section_separators = { left = '', right = '' },
        globalstatus = true,
      },

      sections = {
        -- MODE: Vim logo + mode name
        lualine_a = {
          {
            function()
              return ' ' .. (mode_names[vim.fn.mode()] or 'UNKNOWN')
            end,
            separator = { left = '', right = '' },
          },
        },

        -- PROJECT + BRANCH
        lualine_b = {
          {
            project_name,
            padding = { left = 1, right = 1 },
            separator = { right = '' },
            color = { fg = '#16161e' },
          },
          { 'branch', icon = '󰘬', color = { bg = '#16161e' } },
        },

        -- CENTER — leave blank for symmetry
        lualine_c = {
          '%=',
        },

        -- DIAGNOSTICS
        lualine_x = {
          {
            'diagnostics',
            symbols = {
              error = ' ',
              warn = ' ',
              info = ' ',
              hint = ' ',
            },
            separator = { left = '' },
            color = { bg = '#20212c' },
          },
        },

        -- FILE META + GIT DIFF
        lualine_y = {
          {
            'diff',
            symbols = {
              added = ' ',
              modified = ' ',
              removed = ' ',
            },
            color = { bg = '#20212c' },
          },
          {
            function()
              return '󰯂'
            end,
            color = { fg = '#1a1b26' },
            padding = { left = 0, right = 1 }, -- no space after icon
            separator = { left = '' },
          },
          {
            'filename',
            icon = '',
            color = { bg = '#1a1b26' },
            padding = { left = 0, right = 1 }, -- no space after icon
          },

          { 'filetype', color = { bg = '#1a1b26' }, icon_only = true, padding = { left = 0, right = 0 } },
        },

        lualine_z = {
          {
            function()
              return ''
            end,
            padding = { left = 0, right = 1 },
            color = { fg = '#16161e' },
          },
          { 'location', color = { bg = '#16161e' } },
          {
            'fileformat',
            symbols = { unix = '', dos = '', mac = '' },
            color = { fg = '#94e2d5', bg = '#16161e' },
            separator = { left = '' },
          },
        },
      },

      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {},
        lualine_x = {},
        lualine_y = {},
        lualine_z = {
          function()
            return '󰣇'
          end,
        },
      },

      extensions = {},
    }
  end,
}
