return {
  defaults = {
    sorting_strategy = "ascending",
    layout_config = {
      prompt_position = "top",
      width = 0.85,
      height = 0.80,
      preview_width = 0.55,
    },
    mappings = {
      n = { ["q"] = require("telescope.actions").close },
    },
  },
}
