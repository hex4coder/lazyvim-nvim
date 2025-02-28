-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

require("mason").setup()

require("mason-lspconfig").setup({
  ensure_installed = { "dartls", "gopls" },
})

-- After setting up mason-lspconfig you may set up servers via lspconfig

--require("lspconfig").dartls.setup({
--  cmd = { "dart", "language-server", "--protocol=lsp" },
--  filetypes = { "dart" },
--  init_options = {
--    closingLabels = true,
--    flutterOutline = true,
--    onlyAnalyzeProjectsWithOpenFiles = true,
--    outline = true,
--    suggestFromUnimportedLibraries = true,
--  },
--  -- root_dir = root_pattern("pubspec.yaml"),
--  settings = {
--    dart = {
--      completeFunctionCalls = true,
--      showTodos = true,
--    },
--  },
--  on_attach = function(client, bufnr) end,
--})
require("lspconfig").ast_grep.setup({})
-- require("lspconfig").rust_analyzer.setup {}
require("lspconfig").html.setup({})
require("lspconfig").tailwindcss.setup({})
require("lspconfig").css_variables.setup({})
require("lspconfig").intelephense.setup({})
-- ...
--
--
require("null-ls").setup({
  debug = true,
})

-- flutter tools
local dap = require("dap")
dap.set_log_level("TRACE")

local flutterBin = vim.fn.resolve(vim.fn.exepath("flutter"))
local flutterSdk = vim.fn.fnamemodify(flutterBin, ":h:h")
local dartSdk = "$HOME/development/flutter/bin/cache/dart-sdk/bin/dart"

dap.adapters.dart = {
  type = "executable",
  command = flutterBin,
  args = { "-v", "debug-adapter" },
}

dap.configurations.dart = {
  {
    type = "dart",
    request = "launch",
    name = "Launch Flutter",
    dartSdkPath = dartSdk,
    flutterSdkPath = flutterSdk,
    program = "${workspaceFolder}\\lib\\main.dart",
    cwd = "${workspaceFolder}",
    -- toolArgs = { '-d', 'windows' },
    sendLogsToClient = true,
  },
}
-- alternatively you can override the default configs
require("flutter-tools").setup({
  ui = {
    -- the border type to use for all floating windows, the same options/formats
    -- used for ":h nvim_open_win" e.g. "single" | "shadow" | {<table-of-eight-chars>}
    border = "rounded",
    -- This determines whether notifications are show with `vim.notify` or with the plugin's custom UI
    -- please note that this option is eventually going to be deprecated and users will need to
    -- depend on plugins like `nvim-notify` instead.
    notification_style = "native",
  },
  decorations = {
    statusline = {
      -- set to true to be able use the 'flutter_tools_decorations.app_version' in your statusline
      -- this will show the current version of the flutter app from the pubspec.yaml file
      app_version = true,
      -- set to true to be able use the 'flutter_tools_decorations.device' in your statusline
      -- this will show the currently running device if an application was started with a specific
      -- device
      device = true,
      -- set to true to be able use the 'flutter_tools_decorations.project_config' in your statusline
      -- this will show the currently selected project configuration
      project_config = true,
    },
  },
  debugger = { -- integrate with nvim dap + install dart code debugger
    enabled = true,
    -- if empty dap will not stop on any exceptions, otherwise it will stop on those specified
    -- see |:help dap.set_exception_breakpoints()| for more info
    exception_breakpoints = {},
    -- Whether to call toString() on objects in debug views like hovers and the
    -- variables list.
    -- Invoking toString() has a performance cost and may introduce side-effects,
    -- although users may expected this functionality. null is treated like false.
    evaluate_to_string_in_debug_views = true,
  },
  -- flutter_path = "$HOME/development/flutter/bin/flutter", -- <-- this takes priority over the lookup
  -- flutter_lookup_cmd = nil, -- example "dirname $(which flutter)" or "asdf where flutter"
  -- root_patterns = { ".git", "pubspec.yaml" }, -- patterns to find the root of your flutter project
  -- fvm = false, -- takes priority over path, uses <workspace>/.fvm/flutter_sdk if enabled
  widget_guides = {
    enabled = true,
  },
  closing_tags = {
    -- highlight = "ErrorMsg", -- highlight for the closing tag
    prefix = "//", -- character to use for close tag e.g. > Widget
    priority = 10, -- priority of virtual text in current line
    -- consider to configure this when there is a possibility of multiple virtual text items in one line
    -- see `priority` option in |:help nvim_buf_set_extmark| for more info
    enabled = true, -- set to false to disable
  },
  dev_log = {
    enabled = true,
    filter = nil, -- optional callback to filter the log
    -- takes a log_line as string argument; returns a boolean or nil;
    -- the log_line is only added to the output if the function returns true
    notify_errors = true, -- if there is an error whilst running then notify the user
    open_cmd = "15split", -- command to use to open the log buffer
    focus_on_open = true, -- focus on the newly opened log window
  },
  dev_tools = {
    autostart = false, -- autostart devtools server if not detected
    auto_open_browser = false, -- Automatically opens devtools in the browser
  },
  outline = {
    open_cmd = "30vnew", -- command to use to open the outline buffer
    auto_open = false, -- if true this will open the outline automatically when it is first populated
  },
  lsp = {
    color = { -- show the derived colours for dart variables
      enabled = true, -- whether or not to highlight color variables at all, only supported on flutter >= 2.10
      background = true, -- highlight the background
      background_color = nil, -- required, when background is transparent (i.e. background_color = { r = 19, g = 17, b = 24},)
      foreground = false, -- highlight the foreground
      virtual_text = true, -- show the highlight using virtual text
      virtual_text_str = "■", -- the virtual text character to highlight
    },
    -- on_attach = function() end,
    --- OR you can specify a function to deactivate or change or control how the config is created
    capabilities = function(config)
      --   config.specificThingIDontWant = false
      return config
    end,
    -- see the link below for details on each option:
    -- https://github.com/dart-lang/sdk/blob/master/pkg/analysis_server/tool/lsp_spec/README.md#client-workspace-configuration
    settings = {
      showTodos = true,
      completeFunctionCalls = true,
      -- analysisExcludedFolders = {"<path-to-flutter-sdk-packages>"},
      renameFilesWithClasses = "prompt", -- "always"
      enableSnippets = true,
      updateImportsOnRename = true, -- Whether to update imports and other directives when files are renamed. Required for `FlutterRename` command.
    },
  },
}) --

-- todo comments
--
require("todo-comments").setup({
  signs = true, -- show icons in the signs column
  sign_priority = 8, -- sign priority
  -- keywords recognized as todo comments
  keywords = {
    FIX = {
      icon = " ", -- icon used for the sign, and in search results
      color = "error", -- can be a hex color, or a named color (see below)
      alt = { "FIXME", "BUG", "FIXIT", "ISSUE" }, -- a set of other keywords that all map to this FIX keywords
      -- signs = false, -- configure signs for some keywords individually
    },
    TODO = { icon = " ", color = "info" },
    HACK = { icon = " ", color = "warning" },
    WARN = { icon = " ", color = "warning", alt = { "WARNING", "XXX" } },
    PERF = { icon = " ", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
    NOTE = { icon = " ", color = "hint", alt = { "INFO" } },
    TEST = { icon = "⏲ ", color = "test", alt = { "TESTING", "PASSED", "FAILED" } },
  },
  gui_style = {
    fg = "NONE", -- The gui style to use for the fg highlight group.
    bg = "BOLD", -- The gui style to use for the bg highlight group.
  },
  merge_keywords = true, -- when true, custom keywords will be merged with the defaults
  -- highlighting of the line containing the todo comment
  -- * before: highlights before the keyword (typically comment characters)
  -- * keyword: highlights of the keyword
  -- * after: highlights after the keyword (todo text)
  highlight = {
    multiline = true, -- enable multine todo comments
    multiline_pattern = "^.", -- lua pattern to match the next multiline from the start of the matched keyword
    multiline_context = 10, -- extra lines that will be re-evaluated when changing a line
    before = "", -- "fg" or "bg" or empty
    keyword = "wide", -- "fg", "bg", "wide", "wide_bg", "wide_fg" or empty. (wide and wide_bg is the same as bg, but will also highlight surrounding characters, wide_fg acts accordingly but with fg)
    after = "fg", -- "fg" or "bg" or empty
    pattern = [[.*<(KEYWORDS)\s*:]], -- pattern or table of patterns, used for highlighting (vim regex)
    comments_only = true, -- uses treesitter to match keywords in comments only
    max_line_len = 400, -- ignore lines longer than this
    exclude = {}, -- list of file types to exclude highlighting
  },
  -- list of named colors where we try to extract the guifg from the
  -- list of highlight groups or use the hex color if hl not found as a fallback
  colors = {
    error = { "DiagnosticError", "ErrorMsg", "#DC2626" },
    warning = { "DiagnosticWarn", "WarningMsg", "#FBBF24" },
    info = { "DiagnosticInfo", "#2563EB" },
    hint = { "DiagnosticHint", "#10B981" },
    default = { "Identifier", "#7C3AED" },
    test = { "Identifier", "#FF00FF" },
  },
  search = {
    command = "rg",
    args = {
      "--color=never",
      "--no-heading",
      "--with-filename",
      "--line-number",
      "--column",
    },
    -- regex that will be used to match keywords.
    -- don't replace the (KEYWORDS) placeholder
    pattern = [[\b(KEYWORDS):]], -- ripgrep regex
    -- pattern = [[\b(KEYWORDS)\b]], -- match without the extra colon. You'll likely get false positives
  },
})
