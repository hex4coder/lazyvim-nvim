return {
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    lazy = true,
    config = true,
    keys = {
      { "<leader>t", "<cmd>ToggleTerm<cr>", { desc = "Terminal (Root Dir)" } },
    },
  },
}
