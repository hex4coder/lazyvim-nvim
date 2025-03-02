return {
  {
    "jose-elias-alvarez/null-ls.nvim",
    lazy = true,

    config = function()
      local nl = require("null-ls")

      nl.setup({})
    end,
  },
}
