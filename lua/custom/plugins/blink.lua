local blink_colors = {
  -- UI
  bg = '#20212c', -- lighter, matches your bg_soft
  fg = '#e6e9ff', -- crisp text
  border = '#7aa2f7', -- subtle blue frame

  -- Selection (visible but calm)
  selection = '#4c5270',

  -- Matching
  match = '#ff9edb', -- bright synth pink
  deprecated = '#6b7089',

  -- Kinds (balanced synthwave)
  class = '#ffb86c', -- warm orange
  field = '#7de8e8', -- bright teal
  func = '#c099ff', -- lilac (no blue overload)
  keyword = '#bb9af7', -- purple
  operator = '#7dcfff', -- light cyan
  variable = '#e0af68', -- yellow
  snippet = '#f472b6', -- your pink
  text = '#9aa5ce',

  -- IMPORTANT: source / detail column
  source = '#7dcfff', -- bright, readable, not boring
}

return {
  'saghen/blink.cmp',
  -- optional: provides snippets for the snippet source
  dependencies = { 'rafamadriz/friendly-snippets' },

  -- use a release tag to download pre-built binaries
  version = '1.*',
  -- AND/OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
  -- build = 'cargo build --release',
  -- If you use nix, you can build from source using latest nightly rust with:
  -- build = 'nix run .#build-plugin',

  ---@module 'blink.cmp'
  ---@type blink.cmp.Config
  opts = {
    -- 'default' (recommended) for mappings similar to built-in completions (C-y to accept)
    -- 'super-tab' for mappings similar to vscode (tab to accept)
    -- 'enter' for enter to accept
    -- 'none' for no mappings
    --
    -- All presets have the following mappings:
    -- C-space: Open menu or open docs if already open
    -- C-n/C-p or Up/Down: Select next/previous item
    -- C-e: Hide menu
    -- C-k: Toggle signature help (if signature.enabled = true)
    --
    -- See :h blink-cmp-config-keymap for defining your own keymap
    keymap = { preset = 'default' },

    appearance = {
      -- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
      -- Adjusts spacing to ensure icons are aligned
      nerd_font_variant = 'mono',
    },

    -- (Default) Only show the documentation popup when manually triggered
    completion = { documentation = { auto_show = false } },

    -- Default list of enabled providers defined so that you can extend it
    -- elsewhere in your config, without redefining it, due to `opts_extend`
    sources = {
      default = { 'lsp', 'path', 'snippets', 'buffer' },
    },

    -- (Default) Rust fuzzy matcher for typo resistance and significantly better performance
    -- You may use a lua implementation instead by using `implementation = "lua"` or fallback to the lua implementation,
    -- when the Rust fuzzy matcher is not available, by using `implementation = "prefer_rust"`
    --
    -- See the fuzzy documentation for more information
    fuzzy = { implementation = 'prefer_rust_with_warning' },
  },
  opts_extend = { 'sources.default' },
  init = function()
    -- Custom highlights for BlinkCmp
    -- We wrap this in a ColorScheme autocmd to ensure it runs *after* the colorscheme loads
    -- and re-applies if you change themes.
    vim.api.nvim_create_autocmd('ColorScheme', {
      callback = function()
        local hl = vim.api.nvim_set_hl

        -- Menu
        hl(0, 'BlinkCmpMenu', { bg = 'NONE', fg = blink_colors.fg })
        hl(0, 'BlinkCmpMenuBorder', { fg = blink_colors.border, bg = blink_colors.bg })
        hl(0, 'BlinkCmpMenuSelection', {
          bg = blink_colors.selection,
          fg = blink_colors.fg,
          bold = true,
        })

        -- Labels
        hl(0, 'BlinkCmpLabel', { fg = blink_colors.fg })
        hl(0, 'BlinkCmpLabelMatch', { fg = blink_colors.match, bold = true })
        hl(0, 'BlinkCmpLabelDeprecated', {
          fg = blink_colors.deprecated,
          strikethrough = true,
        })

        -- Source / detail column (THIS is what you asked for)
        hl(0, 'BlinkCmpLabelDetail', { fg = blink_colors.source })
        hl(0, 'BlinkCmpLabelDescription', { fg = blink_colors.source })

        -- Kinds
        hl(0, 'BlinkCmpKind', { fg = blink_colors.text })
        hl(0, 'BlinkCmpKindClass', { fg = blink_colors.class })
        hl(0, 'BlinkCmpKindConstant', { fg = blink_colors.class })
        hl(0, 'BlinkCmpKindEnum', { fg = blink_colors.class })
        hl(0, 'BlinkCmpKindEnumMember', { fg = blink_colors.class })

        hl(0, 'BlinkCmpKindField', { fg = blink_colors.field })
        hl(0, 'BlinkCmpKindProperty', { fg = blink_colors.field })
        hl(0, 'BlinkCmpKindEvent', { fg = blink_colors.field })

        hl(0, 'BlinkCmpKindFunction', { fg = blink_colors.func })
        hl(0, 'BlinkCmpKindMethod', { fg = blink_colors.func })

        hl(0, 'BlinkCmpKindKeyword', { fg = blink_colors.keyword })
        hl(0, 'BlinkCmpKindOperator', { fg = blink_colors.operator })
        hl(0, 'BlinkCmpKindTypeParameter', { fg = blink_colors.keyword })

        hl(0, 'BlinkCmpKindVariable', { fg = blink_colors.variable })
        hl(0, 'BlinkCmpKindFile', { fg = blink_colors.source })
        hl(0, 'BlinkCmpKindSnippet', { fg = blink_colors.snippet })
        hl(0, 'BlinkCmpKindText', { fg = blink_colors.text })
      end,
    })
  end,
}
