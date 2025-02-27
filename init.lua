-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

require("mason").setup()

require("mason-lspconfig").setup({
  ensure_installed = { "dartls", "gopls" },
})

-- After setting up mason-lspconfig you may set up servers via lspconfig

require("lspconfig").dartls.setup({})
require("lspconfig").ast_grep.setup({})
-- require("lspconfig").rust_analyzer.setup {}
require("lspconfig").html.setup({})
require("lspconfig").tailwindcss.setup({})
require("lspconfig").css_variables.setup({})
-- ...
--
--
require("null-ls").setup({
  debug = true,
})
