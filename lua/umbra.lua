local M = {}
local config = require("umbra.config")

local function set_highlights()
  local utilities = require("umbra.utilities")
  local palette = require("umbra.palette")
  local styles = config.options.styles

  local groups = {}
  for group, color in pairs(config.options.groups) do
    groups[group] = utilities.parse_color(color)
  end

  local function make_border(fg)
    fg = fg or groups.border
    return {
      fg = fg,
      bg = (config.options.extend_background_behind_borders and not styles.transparency) and palette.surface or "NONE",
    }
  end

  local highlights = {}
  local default_highlights = {
    -- Editor UI
    ColorColumn = { bg = palette.eclipse },
    Conceal = { bg = "NONE" },
    CursorColumn = { bg = palette.eclipse },
    CursorLine = { bg = palette.eclipse },
    CursorLineNr = { fg = palette.astral, bold = styles.bold },
    DiffAdd = { bg = groups.git_add, blend = 20 },
    DiffChange = { bg = groups.git_change, blend = 20 },
    DiffDelete = { bg = groups.git_delete, blend = 20 },
    DiffText = { bg = groups.git_text, blend = 40 },
    diffAdded = { link = "DiffAdd" },
    diffChanged = { link = "DiffChange" },
    diffRemoved = { link = "DiffDelete" },
    Directory = { fg = palette.nebula, bold = styles.bold },
    ErrorMsg = { fg = groups.error, bold = styles.bold },
    FloatBorder = make_border(),
    FloatTitle = { fg = palette.nebula, bg = groups.panel, bold = styles.bold },
    FoldColumn = { fg = palette.twilight },
    Folded = { fg = palette.corona, bg = groups.panel },
    IncSearch = { fg = palette.umbra, bg = palette.celaeno },
    LineNr = { fg = palette.twilight },
    MatchParen = { fg = palette.corona, bg = palette.transit },
    ModeMsg = { fg = palette.halo },
    MoreMsg = { fg = palette.nova },
    NonText = { fg = palette.twilight },
    Normal = { fg = palette.corona, bg = palette.umbra },
    NormalFloat = { bg = groups.panel },
    NormalNC = { fg = palette.corona, bg = config.options.dim_inactive_windows and palette._nc or palette.umbra },
    Pmenu = { fg = palette.halo, bg = groups.panel },
    PmenuSbar = { bg = groups.panel },
    PmenuSel = { fg = palette.corona, bg = palette.penumbra },
    PmenuThumb = { bg = palette.astral },
    Question = { fg = palette.stellar },
    Search = { fg = palette.umbra, bg = palette.celaeno, blend = 20 },
    SignColumn = { fg = palette.corona, bg = "NONE" },
    SpecialKey = { fg = palette.nebula },
    SpellBad = { sp = palette.halo, undercurl = true },
    SpellCap = { sp = palette.halo, undercurl = true },
    SpellLocal = { sp = palette.halo, undercurl = true },
    SpellRare = { sp = palette.halo, undercurl = true },
    StatusLine = { fg = palette.halo, bg = groups.panel },
    StatusLineNC = { fg = palette.twilight, bg = groups.panel, blend = 60 },
    TabLine = { fg = palette.halo, bg = groups.panel },
    TabLineFill = { bg = groups.panel },
    TabLineSel = { fg = palette.corona, bg = palette.penumbra, bold = styles.bold },
    Title = { fg = palette.nebula, bold = styles.bold },
    VertSplit = { fg = groups.border },
    Visual = { bg = palette.transit },
    WarningMsg = { fg = groups.warn, bold = styles.bold },
    WinBar = { fg = palette.halo, bg = groups.panel },
    WinBarNC = { fg = palette.twilight, bg = groups.panel, blend = 60 },
    WinSeparator = { fg = groups.border },

    -- Diagnostics
    DiagnosticError = { fg = groups.error },
    DiagnosticHint = { fg = groups.hint },
    DiagnosticInfo = { fg = groups.info },
    DiagnosticOk = { fg = groups.ok },
    DiagnosticWarn = { fg = groups.warn },
    DiagnosticDefaultError = { link = "DiagnosticError" },
    DiagnosticDefaultHint = { link = "DiagnosticHint" },
    DiagnosticDefaultInfo = { link = "DiagnosticInfo" },
    DiagnosticDefaultOk = { link = "DiagnosticOk" },
    DiagnosticDefaultWarn = { link = "DiagnosticWarn" },
    DiagnosticFloatingError = { link = "DiagnosticError" },
    DiagnosticFloatingHint = { link = "DiagnosticHint" },
    DiagnosticFloatingInfo = { link = "DiagnosticInfo" },
    DiagnosticFloatingOk = { link = "DiagnosticOk" },
    DiagnosticFloatingWarn = { link = "DiagnosticWarn" },
    DiagnosticSignError = { link = "DiagnosticError" },
    DiagnosticSignHint = { link = "DiagnosticHint" },
    DiagnosticSignInfo = { link = "DiagnosticInfo" },
    DiagnosticSignOk = { link = "DiagnosticOk" },
    DiagnosticSignWarn = { link = "DiagnosticWarn" },
    DiagnosticUnderlineError = { sp = groups.error, undercurl = true },
    DiagnosticUnderlineHint = { sp = groups.hint, undercurl = true },
    DiagnosticUnderlineInfo = { sp = groups.info, undercurl = true },
    DiagnosticUnderlineOk = { sp = groups.ok, undercurl = true },
    DiagnosticUnderlineWarn = { sp = groups.warn, undercurl = true },
    DiagnosticVirtualTextError = { fg = groups.error, bg = groups.error, blend = 10 },
    DiagnosticVirtualTextHint = { fg = groups.hint, bg = groups.hint, blend = 10 },
    DiagnosticVirtualTextInfo = { fg = groups.info, bg = groups.info, blend = 10 },
    DiagnosticVirtualTextOk = { fg = groups.ok, bg = groups.ok, blend = 10 },
    DiagnosticVirtualTextWarn = { fg = groups.warn, bg = groups.warn, blend = 10 },

    -- Syntax Highlighting
    Boolean = { fg = palette.nova },
    Character = { fg = palette.stellar },
    Comment = { fg = palette.twilight, italic = styles.italic },
    Conditional = { fg = palette.aurora },
    Constant = { fg = palette.stellar },
    Debug = { fg = palette.solar },
    Define = { fg = palette.nova },
    Delimiter = { fg = palette.halo },
    Error = { fg = palette.aldebaran },
    Exception = { fg = palette.aurora },
    Float = { fg = palette.stellar },
    Function = { fg = palette.nebula },
    Identifier = { fg = palette.corona },
    Include = { fg = palette.aurora },
    Keyword = { fg = palette.aurora },
    Label = { fg = palette.nebula },
    LspCodeLens = { fg = palette.halo },
    LspCodeLensSeparator = { fg = palette.twilight },
    LspInlayHint = { fg = palette.twilight, bg = palette.twilight, blend = 10 },
    LspReferenceRead = { bg = palette.occult },
    LspReferenceText = { bg = palette.occult },
    LspReferenceWrite = { bg = palette.occult },
    Macro = { fg = palette.nova },
    Number = { fg = palette.stellar },
    Operator = { fg = palette.halo },
    PreCondit = { fg = palette.nova },
    PreProc = { link = "PreCondit" },
    Repeat = { fg = palette.aurora },
    Special = { fg = palette.nebula },
    SpecialChar = { link = "Special" },
    SpecialComment = { fg = palette.nova },
    Statement = { fg = palette.aurora, bold = styles.bold },
    StorageClass = { fg = palette.nebula },
    String = { fg = palette.solar },
    Structure = { fg = palette.nebula },
    Tag = { fg = palette.nebula },
    Todo = { fg = palette.solar, bg = palette.solar, blend = 20 },
    Type = { fg = palette.io },
    TypeDef = { link = "Type" },
    Underlined = { fg = palette.nova, underline = true },

    -- Health Check
    healthError = { fg = groups.error },
    healthSuccess = { fg = groups.info },
    healthWarning = { fg = groups.warn },

    -- HTML & Markup
    htmlArg = { fg = palette.nova },
    htmlBold = { bold = styles.bold },
    htmlEndTag = { fg = palette.halo },
    htmlH1 = { link = "markdownH1" },
    htmlH2 = { link = "markdownH2" },
    htmlH3 = { link = "markdownH3" },
    htmlH4 = { link = "markdownH4" },
    htmlH5 = { link = "markdownH5" },
    htmlItalic = { italic = styles.italic },
    htmlLink = { link = "markdownUrl" },
    htmlTag = { fg = palette.halo },
    htmlTagN = { fg = palette.corona },
    htmlTagName = { fg = palette.nebula },

    -- Markdown
    markdownDelimiter = { fg = palette.halo },
    markdownH1 = { fg = groups.h1, bold = styles.bold },
    markdownH1Delimiter = { link = "markdownH1" },
    markdownH2 = { fg = groups.h2, bold = styles.bold },
    markdownH2Delimiter = { link = "markdownH2" },
    markdownH3 = { fg = groups.h3, bold = styles.bold },
    markdownH3Delimiter = { link = "markdownH3" },
    markdownH4 = { fg = groups.h4, bold = styles.bold },
    markdownH4Delimiter = { link = "markdownH4" },
    markdownH5 = { fg = groups.h5, bold = styles.bold },
    markdownH5Delimiter = { link = "markdownH5" },
    markdownH6 = { fg = groups.h6, bold = styles.bold },
    markdownH6Delimiter = { link = "markdownH6" },
    markdownLinkText = { link = "markdownUrl" },
    markdownUrl = { fg = groups.link, sp = groups.link, underline = true },

    -- Treesitter
    ["@variable"] = { fg = palette.corona, italic = styles.italic },
    ["@variable.builtin"] = { fg = palette.aldebaran, italic = styles.italic, bold = styles.bold },
    ["@variable.parameter"] = { fg = palette.nova, italic = styles.italic },
    ["@variable.parameter.builtin"] = { fg = palette.nova, italic = styles.italic, bold = styles.bold },
    ["@variable.member"] = { fg = palette.nebula },

    ["@constant"] = { fg = palette.stellar },
    ["@constant.builtin"] = { fg = palette.stellar, bold = styles.bold },
    ["@constant.macro"] = { fg = palette.stellar },

    ["@module"] = { fg = palette.corona },
    ["@module.builtin"] = { fg = palette.corona, bold = styles.bold },
    ["@label"] = { link = "Label" },

    ["@string"] = { link = "String" },
    ["@string.regexp"] = { fg = palette.nova },
    ["@string.escape"] = { fg = palette.aurora },
    ["@string.special"] = { link = "String" },
    ["@string.special.symbol"] = { link = "Identifier" },
    ["@string.special.url"] = { fg = groups.link },

    ["@character"] = { link = "Character" },
    ["@character.special"] = { link = "Character" },

    ["@boolean"] = { link = "Boolean" },
    ["@number"] = { link = "Number" },
    ["@number.float"] = { link = "Number" },
    ["@float"] = { link = "Number" },

    ["@type"] = { fg = palette.nebula },
    ["@type.builtin"] = { fg = palette.nebula, bold = styles.bold },

    ["@attribute"] = { fg = palette.nova },
    ["@attribute.builtin"] = { fg = palette.nova, bold = styles.bold },
    ["@property"] = { fg = palette.nebula, italic = styles.italic },

    ["@function"] = { fg = palette.nebula },
    ["@function.builtin"] = { fg = palette.nebula, bold = styles.bold },
    ["@function.macro"] = { link = "Function" },

    ["@function.method"] = { fg = palette.nebula },
    ["@function.method.call"] = { fg = palette.nova },

    ["@constructor"] = { fg = palette.nebula },
    ["@operator"] = { link = "Operator" },

    ["@keyword"] = { link = "Keyword" },
    ["@keyword.operator"] = { fg = palette.halo },
    ["@keyword.import"] = { fg = palette.aurora },
    ["@keyword.storage"] = { fg = palette.nebula },
    ["@keyword.repeat"] = { fg = palette.aurora },
    ["@keyword.return"] = { fg = palette.aurora },
    ["@keyword.debug"] = { fg = palette.solar },
    ["@keyword.exception"] = { fg = palette.aurora },

    ["@keyword.conditional"] = { fg = palette.aurora },
    ["@keyword.conditional.ternary"] = { fg = palette.aurora },

    ["@keyword.directive"] = { fg = palette.nova },
    ["@keyword.directive.define"] = { fg = palette.nova },

    -- Punctuation
    ["@punctuation.delimiter"] = { fg = palette.halo },
    ["@punctuation.bracket"] = { fg = palette.halo },
    ["@punctuation.special"] = { fg = palette.halo },

    -- Comments
    ["@comment"] = { link = "Comment" },
    ["@comment.error"] = { fg = groups.error },
    ["@comment.warning"] = { fg = groups.warn },
    ["@comment.todo"] = { fg = groups.todo, bg = groups.todo, blend = 15 },
    ["@comment.hint"] = { fg = groups.hint, bg = groups.hint, blend = 15 },
    ["@comment.info"] = { fg = groups.info, bg = groups.info, blend = 15 },
    ["@comment.note"] = { fg = groups.note, bg = groups.note, blend = 15 },

    -- Markup
    ["@markup.strong"] = { bold = styles.bold },
    ["@markup.italic"] = { italic = styles.italic },
    ["@markup.strikethrough"] = { strikethrough = true },
    ["@markup.underline"] = { underline = true },

    ["@markup.heading"] = { fg = palette.nebula, bold = styles.bold },

    ["@markup.quote"] = { fg = palette.corona },
    ["@markup.math"] = { link = "Special" },
    ["@markup.environment"] = { link = "Macro" },
    ["@markup.environment.name"] = { link = "@type" },

    ["@markup.link.url"] = { fg = groups.link },

    ["@markup.raw.delimiter.markdown"] = { fg = palette.halo },

    ["@markup.list"] = { fg = palette.aurora },
    ["@markup.list.checked"] = { fg = palette.nebula, bg = palette.nebula, blend = 10 },
    ["@markup.list.unchecked"] = { fg = palette.corona },

    -- Markdown headings
    ["@markup.heading.1.markdown"] = { link = "markdownH1" },
    ["@markup.heading.2.markdown"] = { link = "markdownH2" },
    ["@markup.heading.3.markdown"] = { link = "markdownH3" },
    ["@markup.heading.4.markdown"] = { link = "markdownH4" },
    ["@markup.heading.5.markdown"] = { link = "markdownH5" },
    ["@markup.heading.6.markdown"] = { link = "markdownH6" },
    ["@markup.heading.1.marker.markdown"] = { link = "markdownH1Delimiter" },
    ["@markup.heading.2.marker.markdown"] = { link = "markdownH2Delimiter" },
    ["@markup.heading.3.marker.markdown"] = { link = "markdownH3Delimiter" },
    ["@markup.heading.4.marker.markdown"] = { link = "markdownH4Delimiter" },
    ["@markup.heading.5.marker.markdown"] = { link = "markdownH5Delimiter" },
    ["@markup.heading.6.marker.markdown"] = { link = "markdownH6Delimiter" },

    -- Diffs
    ["@diff.plus"] = { fg = groups.git_add, bg = groups.git_add, blend = 20 },
    ["@diff.minus"] = { fg = groups.git_delete, bg = groups.git_delete, blend = 20 },
    ["@diff.delta"] = { bg = groups.git_change, blend = 20 },

    ["@tag"] = { link = "Tag" },
    ["@tag.attribute"] = { fg = palette.nova },
    ["@tag.delimiter"] = { fg = palette.halo },

    -- Non-highlighting captures
    ["@conceal"] = { link = "Conceal" },
    ["@conceal.markdown"] = { fg = palette.halo },

    -- LSP Semantic tokens
    ["@lsp.type.comment"] = {},
    ["@lsp.type.enum"] = { link = "@type" },
    ["@lsp.type.interface"] = { link = "@interface" },
    ["@lsp.type.keyword"] = { link = "@keyword" },
    ["@lsp.type.namespace"] = { link = "@namespace" },
    ["@lsp.type.parameter"] = { link = "@parameter" },
    ["@lsp.type.property"] = { link = "@property" },
    ["@lsp.type.variable"] = {}, -- defer to treesitter for regular variables
    ["@lsp.typemod.function.defaultLibrary"] = { link = "@function.builtin" },
    ["@lsp.typemod.operator.injected"] = { link = "@operator" },
    ["@lsp.typemod.string.injected"] = { link = "@string" },
    ["@lsp.typemod.variable.constant"] = { link = "@constant" },
    ["@lsp.typemod.variable.defaultLibrary"] = { link = "@variable.builtin" },
    ["@lsp.typemod.variable.injected"] = { link = "@variable" },

    -- Plugin Specific Highlights
    -- These are just a few examples - plugin support can be extended as needed

    -- gitsigns.nvim
    GitSignsAdd = { fg = groups.git_add, bg = "NONE" },
    GitSignsChange = { fg = groups.git_change, bg = "NONE" },
    GitSignsDelete = { fg = groups.git_delete, bg = "NONE" },
    SignAdd = { fg = groups.git_add, bg = "NONE" },
    SignChange = { fg = groups.git_change, bg = "NONE" },
    SignDelete = { fg = groups.git_delete, bg = "NONE" },

    -- indent-blankline.nvim
    IblIndent = { fg = palette.penumbra },
    IblScope = { fg = palette.aurora },
    IblWhitespace = { fg = palette.penumbra },

    -- nvim-cmp
    CmpItemAbbr = { fg = palette.halo },
    CmpItemAbbrDeprecated = { fg = palette.halo, strikethrough = true },
    CmpItemAbbrMatch = { fg = palette.corona, bold = styles.bold },
    CmpItemAbbrMatchFuzzy = { fg = palette.corona, bold = styles.bold },
    CmpItemKind = { fg = palette.halo },
    CmpItemKindClass = { link = "StorageClass" },
    CmpItemKindFunction = { link = "Function" },
    CmpItemKindInterface = { link = "Type" },
    CmpItemKindMethod = { link = "PreProc" },
    CmpItemKindSnippet = { link = "String" },
    CmpItemKindVariable = { link = "Identifier" },

    -- Telescope
    TelescopeBorder = make_border(),
    TelescopeMatching = { fg = palette.solar },
    TelescopeNormal = { link = "NormalFloat" },
    TelescopePromptNormal = { link = "TelescopeNormal" },
    TelescopePromptPrefix = { fg = palette.halo },
    TelescopeSelection = { fg = palette.corona, bg = palette.penumbra },
    TelescopeSelectionCaret = { fg = palette.solar, bg = palette.penumbra },
    TelescopeTitle = { fg = palette.nebula, bold = styles.bold },
  }

  -- Transparency Highlights (applied when transparency is enabled)
  local transparency_highlights = {
    DiagnosticVirtualTextError = { fg = groups.error },
    DiagnosticVirtualTextHint = { fg = groups.hint },
    DiagnosticVirtualTextInfo = { fg = groups.info },
    DiagnosticVirtualTextOk = { fg = groups.ok },
    DiagnosticVirtualTextWarn = { fg = groups.warn },

    FloatBorder = { fg = palette.twilight, bg = "NONE" },
    FloatTitle = { fg = palette.nebula, bg = "NONE", bold = styles.bold },
    Folded = { fg = palette.corona, bg = "NONE" },
    NormalFloat = { bg = "NONE" },
    Normal = { fg = palette.corona, bg = "NONE" },
    NormalNC = { fg = palette.corona, bg = config.options.dim_inactive_windows and palette._nc or "NONE" },
    Pmenu = { fg = palette.halo, bg = "NONE" },
    SignColumn = { fg = palette.corona, bg = "NONE" },
    StatusLine = { fg = palette.halo, bg = "NONE" },
    StatusLineNC = { fg = palette.twilight, bg = "NONE" },
    TabLine = { bg = "NONE", fg = palette.halo },
    TabLineFill = { bg = "NONE" },
    TabLineSel = { fg = palette.corona, bg = "NONE", bold = styles.bold },

    TelescopeNormal = { fg = palette.halo, bg = "NONE" },
    TelescopePromptNormal = { fg = palette.corona, bg = "NONE" },
    TelescopeSelection = { fg = palette.corona, bg = "NONE", bold = styles.bold },
    TelescopeSelectionCaret = { fg = palette.solar },

    IblIndent = { fg = palette.penumbra, bg = "NONE" },
    IblScope = { fg = palette.aurora, bg = "NONE" },
    IblWhitespace = { fg = palette.penumbra, bg = "NONE" },
  }

  -- Add default highlights to the final highlights table
  for group, highlight in pairs(default_highlights) do
    highlights[group] = highlight
  end

  -- Apply transparency if enabled
  if styles.transparency then
    for group, highlight in pairs(transparency_highlights) do
      highlights[group] = highlight
    end
  end

  -- Apply user-defined highlight groups
  if config.options.highlight_groups ~= nil and next(config.options.highlight_groups) ~= nil then
    for group, highlight in pairs(config.options.highlight_groups) do
      local existing = highlights[group] or {}
      -- Traverse link due to
      -- "If link is used in combination with other attributes; only the link will take effect"
      -- see: https://neovim.io/doc/user/api.html#nvim_set_hl()
      while existing.link ~= nil do
        existing = highlights[existing.link] or {}
      end
      local parsed = vim.tbl_extend("force", {}, highlight)

      if highlight.fg ~= nil then
        parsed.fg = utilities.parse_color(highlight.fg) or highlight.fg
      end
      if highlight.bg ~= nil then
        parsed.bg = utilities.parse_color(highlight.bg) or highlight.bg
      end
      if highlight.sp ~= nil then
        parsed.sp = utilities.parse_color(highlight.sp) or highlight.sp
      end

      if (highlight.inherit == nil or highlight.inherit) and existing ~= nil then
        parsed.inherit = nil
        highlights[group] = vim.tbl_extend("force", existing, parsed)
      else
        parsed.inherit = nil
        highlights[group] = parsed
      end
    end
  end

  -- Apply highlights
  for group, highlight in pairs(highlights) do
    if config.options.before_highlight ~= nil then
      config.options.before_highlight(group, highlight, palette)
    end

    if highlight.blend ~= nil and (highlight.blend >= 0 and highlight.blend <= 100) and highlight.bg ~= nil then
      highlight.bg = utilities.blend(highlight.bg, highlight.blend_on or palette.umbra, highlight.blend / 100)
    end

    highlight.blend = nil
    highlight.blend_on = nil

    vim.api.nvim_set_hl(0, group, highlight)
  end

  -- Terminal colors
  if config.options.enable.terminal then
    vim.g.terminal_color_0 = palette.umbra -- black
    vim.g.terminal_color_8 = palette.twilight -- bright black
    vim.g.terminal_color_1 = palette.aldebaran -- red
    vim.g.terminal_color_9 = "#FF6B6B" -- bright red
    vim.g.terminal_color_2 = palette.aurora -- green
    vim.g.terminal_color_10 = "#56CFA7" -- bright green
    vim.g.terminal_color_3 = palette.stellar -- yellow
    vim.g.terminal_color_11 = "#FFD494" -- bright yellow
    vim.g.terminal_color_4 = palette.nebula -- blue
    vim.g.terminal_color_12 = "#75D4F0" -- bright blue
    vim.g.terminal_color_5 = palette.nova -- magenta
    vim.g.terminal_color_13 = "#B794F6" -- bright magenta
    vim.g.terminal_color_6 = palette.helios -- cyan
    vim.g.terminal_color_14 = "#99E3F9" -- bright cyan
    vim.g.terminal_color_7 = palette.corona -- white
    vim.g.terminal_color_15 = "#FFFFFF" -- bright white

    -- Support StatusLineTerm & StatusLineTermNC from vim
    vim.cmd([[
        augroup umbra-theme
            autocmd!
            autocmd TermOpen * if &buftype=='terminal'
                \|setlocal winhighlight=StatusLine:StatusLineTerm,StatusLineNC:StatusLineTermNC
                \|else|setlocal winhighlight=|endif
            autocmd ColorSchemePre * autocmd! umbra-theme
        augroup END
        ]])
  end
end

---@param variant Variant | nil
function M.colorscheme(variant)
  config.extend_options({ variant = variant })

  vim.opt.termguicolors = true
  if vim.g.colors_name then
    vim.cmd("hi clear")
    vim.cmd("syntax reset")
  end
  vim.g.colors_name = "umbra"

  if variant == "penumbra" then
    vim.o.background = "light"
  elseif variant == "umbra" or variant == "antumbra" then
    vim.o.background = "dark"
  end

  set_highlights()
end

---@param options Options
function M.setup(options)
  config.extend_options(options or {})
end

return M
