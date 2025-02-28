-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local map = vim.keymap.set

-- flutter run
map("n", "<F5>", "<cmd>FlutterDebug<cr>", { desc = "Menjalankan flutter debug" })
map("n", "<F6>", "<cmd>FlutterRestart<cr>", { desc = "Merestart aplikasi flutter" })
map("n", "<F7>", "<cmd>FlutterOutlineToggle<cr>", { desc = "Toggle outline flutter" })
map("n", "<F8>", "<cmd>FlutterLogToggle<cr>", { desc = "Toggle log flutter" })
map("n", "<F9>", "<cmd>FlutterVisualDebug<cr>", { desc = "Visual debug flutter" })
