return {
  options = {
    -- without this, the bufferline renders under nvim-tree's sidebar instead of starting after it
    offsets = {
      {
        filetype = "NvimTree",
        text = "File Explorer",
        text_align = "center",
        separator = true,
      },
    },
  },
}
