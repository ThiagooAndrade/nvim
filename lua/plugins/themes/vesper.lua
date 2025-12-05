return {
  "datsfilipe/vesper.nvim",
  lazy = false,
  config = function()
    require('vesper').setup({
      transparent = true, -- Boolean: Sets the background to transparent
      italics = {
        comments = true,  -- Boolean: Italicizes comments
        keywords = true,  -- Boolean: Italicizes keywords
        functions = false, -- Boolean: Italicizes functions
        strings = false,   -- Boolean: Italicizes strings
        variables = false, -- Boolean: Italicizes variables
      },
      overrides = {},     -- A dictionary of group names, can be a function returning a dictionary or a table.
      palette_overrides = {

      }
    })
    require('bufferline').setup({
      highlights = require('vesper').bufferline.highlights,
    })
  end
}
