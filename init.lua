-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

require("mason").setup()

require("mason-lspconfig").setup({
  ensure_installed = { "dartls", "gopls" },
})

-- After setting up mason-lspconfig you may set up servers via lspconfig

require("lspconfig").dartls.setup({
  cmd = { "dart", "language-server", "--protocol=lsp" },
  filetypes = { "dart" },
  init_options = {
    closingLabels = true,
    flutterOutline = true,
    onlyAnalyzeProjectsWithOpenFiles = true,
    outline = true,
    suggestFromUnimportedLibraries = true,
  },
  -- root_dir = root_pattern("pubspec.yaml"),
  settings = {
    dart = {
      completeFunctionCalls = true,
      showTodos = true,
    },
  },
  on_attach = function(client, bufnr) end,
})
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
