return {
  'nvim-treesitter/nvim-treesitter',
  lazy = false,
  branch = 'main',
  build = ':TSUpdate',
  -- We define our parsers in opts so they are easy to find/edit
  opts = {
    ensure_installed = {
      'bash',
      'c',
      'diff',
      'html',
      'lua',
      'luadoc',
      'markdown',
      'markdown_inline',
      'query',
      'vim',
      'vimdoc',
      'go',
      'typescript',
      'javascript',
    },
    preview = true,
  },
  config = function(_, opts)
    local ts = require 'nvim-treesitter'

    -- 1. Install parsers from our opts table
    ts.install(opts.ensure_installed)

    -- 2. Define the attachment logic (from your Kickstart code)
    local function treesitter_try_attach(buf, language)
      if not vim.treesitter.language.add(language) then
        return
      end

      -- Enable highlighting
      vim.treesitter.start(buf, language)

      -- Enable indentation if a query exists for that language
      if vim.treesitter.query.get(language, 'indents') then
        vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
      end
    end

    -- 3. Set up the Autocmd to trigger the above logic
    vim.api.nvim_create_autocmd('FileType', {
      callback = function(args)
        local lang = vim.treesitter.language.get_lang(args.match) or args.match

        -- Check if it's already installed or available to be installed
        if vim.tbl_contains(ts.get_installed(), lang) then
          treesitter_try_attach(args.buf, lang)
        elseif vim.tbl_contains(ts.get_available(), lang) then
          ts.install(lang):await(function()
            treesitter_try_attach(args.buf, lang)
          end)
        end
      end,
    })
  end,
}
