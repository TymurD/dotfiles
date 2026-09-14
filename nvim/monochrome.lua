-- Minimal monochrome colorscheme matching the desktop grayscale theme
-- (foot terminal, waybar, fuzzel, sway all share this palette: #111111 base,
-- #f2f2f2 bright text, and shades of gray in between)
-- Deliberately minimal: only core UI + syntax groups. No per-plugin
-- overrides, no transparency tricks -- those caused more problems than
-- they solved.

vim.cmd("hi clear")
if vim.fn.exists("syntax_on") == 1 then
  vim.cmd("syntax reset")
end

vim.o.background = "dark"
vim.o.termguicolors = true
vim.g.colors_name = "monochrome"

local c = {
  bg = "#111111",
  bg_alt = "#1a1a1a",
  bg_highlight = "#242424",
  bg_visual = "#2e2e2e",
  fg = "#f2f2f2",
  fg_dim = "#cccccc",
  fg_dimmer = "#999999",
  fg_dimmest = "#666666",
  border = "#444444",
  muted = "#4a4a4a",
  bright = "#ffffff",

  keyword = "#c9a26d", -- warm amber: keywords/control flow
  string = "#84a9ae", -- muted teal: strings/characters
  func = "#9cbf8a", -- soft sage: functions/methods
}

local function hl(group, opts)
  vim.api.nvim_set_hl(0, group, opts)
end

-- Core editor UI
hl("Normal", { fg = c.fg_dim, bg = c.bg })
hl("NormalFloat", { fg = c.fg_dim, bg = c.bg_alt })
hl("FloatBorder", { fg = c.border, bg = c.bg_alt })
hl("Cursor", { fg = c.bg, bg = c.fg })
hl("CursorLine", { bg = c.bg_highlight })
hl("CursorLineNr", { fg = c.fg, bold = true })
hl("LineNr", { fg = c.muted })
hl("Visual", { bg = c.bg_visual })
hl("Search", { fg = c.bg, bg = c.fg_dimmer })
hl("IncSearch", { fg = c.bg, bg = c.fg })
hl("MatchParen", { fg = c.bright, bold = true, underline = true })
hl("WinSeparator", { fg = c.border })
hl("StatusLine", { fg = c.fg_dim, bg = c.bg_alt })
hl("StatusLineNC", { fg = c.fg_dimmest, bg = c.bg_alt })
hl("Pmenu", { fg = c.fg_dim, bg = c.bg_alt })
hl("PmenuSel", { fg = c.bright, bg = c.bg_visual, bold = true })
hl("NonText", { fg = c.muted })
hl("Directory", { fg = c.fg_dim, bold = true })
hl("Title", { fg = c.fg, bold = true })

-- Diagnostics: severity via brightness only, no undercurl
hl("DiagnosticError", { fg = c.bright })
hl("DiagnosticWarn", { fg = c.fg_dim })
hl("DiagnosticInfo", { fg = c.fg_dimmer })
hl("DiagnosticHint", { fg = c.fg_dimmest })

-- Syntax
hl("Comment", { fg = c.fg_dimmest, italic = true })
hl("Constant", { fg = c.fg_dim })
hl("String", { fg = c.string, italic = true })
hl("Number", { fg = c.fg_dim })
hl("Boolean", { fg = c.fg_dim, bold = true })
hl("Identifier", { fg = c.fg_dim })
hl("Function", { fg = c.func, bold = true })
hl("Statement", { fg = c.keyword, bold = true })
hl("Conditional", { fg = c.keyword, bold = true })
hl("Repeat", { fg = c.keyword, bold = true })
hl("Operator", { fg = c.fg_dimmer })
hl("Keyword", { fg = c.keyword, bold = true })
hl("PreProc", { fg = c.fg_dimmer })
hl("Type", { fg = c.fg_dim, bold = true })
hl("Special", { fg = c.fg_dimmer })
hl("Delimiter", { fg = c.fg_dimmest })
hl("Todo", { fg = c.bright, bold = true, bg = c.bg_highlight })
