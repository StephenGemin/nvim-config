local hooks = require "ibl.hooks"

-- hide the leftmost indent guide on blank/whitespace-only lines, so an empty line inside
-- an indented block doesn't show a stray guide character at the first level
hooks.register(hooks.type.WHITESPACE, hooks.builtin.hide_first_space_indent_level)

-- ibl's default indent char ("▎", a quarter-block) renders as a thick bar; use a thin
-- box-drawing line instead. scope.char stays nil so the current-scope highlight
-- (IblScope) reuses this same thin char.
require("ibl").setup {
  indent = { char = "│" },
}
