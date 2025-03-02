return {
  "nvim-flutter/flutter-tools.nvim",
  lazy = true,
  dependencies = {
    "nvim-lua/plenary.nvim",
    "stevearc/dressing.nvim", -- optional for vim.ui.select
  },
  config = function()
    local map = vim.keymap.set

    -- flutter run
    map("n", "<F5>", "<cmd>FlutterDebug<cr>", { desc = "Menjalankan flutter debug" })
    map("n", "<F6>", "<cmd>FlutterRestart<cr>", { desc = "Merestart aplikasi flutter" })
    map("n", "<F7>", "<cmd>FlutterOutlineToggle<cr>", { desc = "Toggle outline flutter" })
    map("n", "<F8>", "<cmd>FlutterLogToggle<cr>", { desc = "Toggle log flutter" })
    map("n", "<F9>", "<cmd>FlutterVisualDebug<cr>", { desc = "Visual debug flutter" })
  end,
}
