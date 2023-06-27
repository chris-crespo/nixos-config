local lib = require 'nvim-tree.lib'
local view = require 'nvim-tree.view'

local function collapse_all()
  require 'nvim-tree.actions.tree-modifiers.collapse-all'.fn()
end

local function vsplit_preview()
  local action = 'vsplit'
  local node = lib.get_node_at_cursor()

  if node.link_to and not node.nodes then
    require 'nvim-tree.actions.node.open-file'.fn(action, node.link_to)
  elseif node.nodes ~= nil then
    lib.expand_or_collapse(node)
  else
    require 'nvim-tree.actions.node.open-file'.fn(action, node.absolute_path)
  end

  view.focus()
end

require 'nvim-tree'.setup {
  diagnostics = {
    enable = true
  },
  sort_by = 'case_sensitive',
  view = {
    mappings = {
      list = {
        { key = 'h', action = 'close_node' },
        { key = 'H', action = 'collapse_all',   action_cb = collapse_all },
        { key = 'l', action = 'open_node' },
        { key = 'L', action = 'vsplit_preview', action_cb = vsplit_preview }
      }
    }
  }
}
