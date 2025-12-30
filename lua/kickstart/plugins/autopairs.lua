-- autopairs
-- https://github.com/windwp/nvim-autopairs

return {
  'windwp/nvim-autopairs',
  event = 'InsertEnter',
  config = function()
    local npairs = require 'nvim-autopairs'
    npairs.setup()

    npairs.remove_rule '('
    npairs.remove_rule '['
    npairs.remove_rule '"'
    npairs.remove_rule "'"
    npairs.remove_rule '`'
  end,
}
