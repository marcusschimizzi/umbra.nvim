local colors = require("umbra.colors")

local M = {}

-- Helper function to generate highlight groups
local function highlight(group, opts)
  local fg = opts.fg and "guifg=" .. opts.fg or "guifg=NONE"
  local bg = opts.bg and "guibg=" .. opts.bg or "guibg=NONE"
  local sp = opts.sp and "guisp=" .. opts.sp or ""
  local style = opts.style and "gui=" .. opts.style or "gui=NONE"

  vim.cmd(string.format("highlight %s %s %s %s %s", group, fg, bg, sp, style))
end

function M.setup()
  vim.opt.termguicolors = true
  if vim.g.colors_name then
    vim.cmd("hi clear")
    vim.cmd("syntax reset")
  end
  vim.g.colors_name = "umbra"

  -- Editor highlights
  local groups = {
    -- UI elements
    Normal = { fg = colors.corona, bg = colors.umbra },
    NormalFloat = { fg = colors.corona, bg = colors.bg_dark },
    ColorColumn = { bg = colors.eclipse },
    Cursor = { fg = colors.umbra, bg = colors.corona },
    CursorLine = { bg = colors.eclipse },
    CursorColumn = { bg = colors.eclipse },
    Directory = { fg = colors.nebula, style = "bold" },
    DiffAdd = { fg = colors.aurora, bg = colors.eclipse },
    DiffChange = { fg = colors.celaeno, bg = colors.eclipse },
    DiffDelete = { fg = colors.aldebaran, bg = colors.eclipse },
    DiffText = { fg = colors.corona, bg = colors.eclipse },
    EndOfBuffer = { fg = colors.twilight },
    TermCursor = { fg = colors.umbra, bg = colors.corona },
    TermCursorNC = { fg = colors.umbra, bg = colors.halo },
    ErrorMsg = { fg = colors.aldebaran },
    VertSplit = { fg = colors.twilight },
    Folded = { fg = colors.astral, bg = colors.eclipse },
    FoldColumn = { fg = colors.astral },
    SignColumn = { bg = colors.umbra },
    IncSearch = { fg = colors.umbra, bg = colors.celaeno },
    Substitute = { fg = colors.umbra, bg = colors.celaeno },
    LineNr = { fg = colors.twilight },
    CursorLineNr = { fg = colors.astral },
    MatchParen = { fg = colors.corona, bg = colors.transit },
    ModeMsg = { fg = colors.corona },
    MsgArea = { fg = colors.corona },
    MoreMsg = { fg = colors.aurora },
    NonText = { fg = colors.twilight },
    Pmenu = { fg = colors.corona, bg = colors.penumbra },
    PmenuSel = { fg = colors.corona, bg = colors.antumbra },
    PmenuSbar = { bg = colors.penumbra },
    PmenuThumb = { bg = colors.astral },
    Question = { fg = colors.aurora },
    QuickFixLine = { bg = colors.eclipse },
    Search = { fg = colors.umbra, bg = colors.celaeno },
    SpecialKey = { fg = colors.twilight },
    SpellBad = { sp = colors.aldebaran, style = "undercurl" },
    SpellCap = { sp = colors.stellar, style = "undercurl" },
    SpellLocal = { sp = colors.aurora, style = "undercurl" },
    SpellRare = { sp = colors.nova, style = "undercurl" },
    StatusLine = { fg = colors.aurora, bg = colors.penumbra },
    StatusLineNC = { fg = colors.halo, bg = colors.penumbra },
    TabLine = { fg = colors.halo, bg = colors.penumbra },
    TabLineFill = { bg = colors.penumbra },
    TabLineSel = { fg = colors.corona, bg = colors.antumbra },
    Title = { fg = colors.aurora, style = "bold" },
    Visual = { bg = colors.transit },
    VisualNOS = { bg = colors.transit },
    WarningMsg = { fg = colors.solar },
    Whitespace = { fg = colors.twilight },
    WildMenu = { fg = colors.corona, bg = colors.transit },

    -- Syntax Highlighting
    Comment = { fg = colors.twilight, style = "italic" },
    Constant = { fg = colors.stellar },
    String = { fg = colors.solar },
    Character = { fg = colors.solar },
    Number = { fg = colors.stellar },
    Boolean = { fg = colors.stellar },
    Float = { fg = colors.stellar },
    Identifier = { fg = colors.corona },
    Function = { fg = colors.nebula },
    Statement = { fg = colors.aurora },
    Conditional = { fg = colors.aurora },
    Repeat = { fg = colors.aurora },
    Label = { fg = colors.aurora },
    Operator = { fg = colors.corona },
    Keyword = { fg = colors.aurora },
    Exception = { fg = colors.aurora },
    PreProc = { fg = colors.nova },
    Include = { fg = colors.nova },
    Define = { fg = colors.nova },
    Macro = { fg = colors.nova },
    PreCondit = { fg = colors.nova },
    Type = { fg = colors.io },
    StorageClass = { fg = colors.aurora },
    Structure = { fg = colors.io },
    Typedef = { fg = colors.io },
    Special = { fg = colors.celaeno },
    SpecialChar = { fg = colors.celaeno },
    Tag = { fg = colors.celaeno },
    Delimiter = { fg = colors.halo },
    SpecialComment = { fg = colors.astral, style = "italic" },
    Debug = { fg = colors.aldebaran },
    Underlined = { style = "underline" },
    Ignore = { fg = colors.twilight },
    Error = { fg = colors.aldebaran },
    Todo = { fg = colors.nova, style = "bold" },

    -- Diagnostics
    DiagnosticError = { fg = colors.aldebaran },
    DiagnosticWarn = { fg = colors.solar },
    DiagnosticInfo = { fg = colors.helios },
    DiagnosticHint = { fg = colors.io },

    -- Git signs
    GitSignsAdd = { fg = colors.aurora },
    GitSignsChange = { fg = colors.celaeno },
    GitSignsDelete = { fg = colors.aldebaran },

    -- LSP
    LspReferenceText = { bg = colors.eclipse },
    LspReferenceRead = { bg = colors.eclipse },
    LspReferenceWrite = { bg = colors.eclipse },
  }

  -- Set highlight groups
  for group, opts in pairs(groups) do
    highlight(group, opts)
  end
end

return M
