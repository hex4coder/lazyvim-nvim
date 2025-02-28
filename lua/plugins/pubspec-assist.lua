return {
  "akinsho/pubspec-assist.nvim",
  lazy = true,
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    require("pubspec-assist").setup()
  end,
}
