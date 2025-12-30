return {
  { -- You can easily change to a different colorscheme.
    -- Change the name of the colorscheme plugin below, and then
    -- change the command in the config to whatever the name of that colorscheme is.
    --
    -- If you want to see what colorschemes are already installed, you can use `:Telescope colorscheme`.
    'samharju/synthweave.nvim',
    priority = 1000, -- Make sure to load this before all the other start plugins.
    config = function()
      ---@diagnostic disable-next-line: missing-fields
      require('synthweave').setup {
        styles = {
          comments = { italic = true }, -- Disable italics in comments
        },
      }

      -- Load the colorscheme here.
      -- Like many other themes, this one has different styles, and you could load
      -- any other, such as 'tokyonight-storm', 'tokyonight-moon', or 'tokyonight-day'.
      vim.cmd.colorscheme 'synthweave-transparent'

      vim.api.nvim_set_hl(0, 'TelescopePromptTitle', {
        fg = '#16161e',
        bg = '#f472b6',
        bold = true,
      })

      vim.api.nvim_set_hl(0, 'TelescopePreviewTitle', {
        fg = '#16161e',
        bg = '#c099ff',
        bold = true,
      })

      vim.api.nvim_set_hl(0, 'TelescopeResultsTitle', {
        fg = '#16161e',
        bg = '#7aa2f7',
        bold = true,
      })
    end,
  },
}
