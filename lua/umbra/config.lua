---@alias Variant "umbra" | "penumbra" | "antumbra"
---@alias Palette { umbra: string, penumbra: string, antumbra: string, eclipse: string, occult: string, transit: string, corona: string, halo: string, astral: string, twilight: string, aurora: string, nebula: string, nova: string, solar: string, stellar: string, aldebaran: string, celaeno: string, helios: string, io: string }
---@alias PaletteColor "umbra" | "penumbra" | "antumbra" | "eclipse" | "occult" | "transit" | "corona" | "halo" | "astral" | "twilight" | "aurora" | "nebula" | "nova" | "solar" | "stellar" | "aldebaran" | "celaeno" | "helios" | "io"
---@alias Highlight { link: string, inherit: boolean } | { fg: string, bg: string, sp: string, bold: boolean, italic: boolean, undercurl: boolean, underline: boolean, underdouble: boolean, underdotted: boolean, underdashed: boolean, strikethrough: boolean, inherit: boolean }

local config = {}

---@class Options
config.options = {
  ---Set the desired variant: "auto" will follow the vim background,
  ---defaulting to `dark_variant` or "umbra" for dark and "penumbra" for light.
  ---@type "auto" | Variant
  variant = "auto",

  ---Set the desired dark variant when `options.variant` is set to "auto".
  ---@type Variant
  dark_variant = "umbra",

  ---Differentiate between active and inactive windows and panels.
  dim_inactive_windows = false,

  ---Extend background behind borders. Appearance differs based on which
  ---border characters you are using.
  extend_background_behind_borders = true,

  enable = {
    legacy_highlights = true,
    migrations = true,
    terminal = true,
  },

  styles = {
    bold = true,
    italic = true,
    transparency = false,
  },

  ---@type table<string, table<string, string>>
  palette = {},

  ---@type table<string, string | PaletteColor>
  groups = {
    border = "twilight",
    link = "io",
    panel = "penumbra",

    error = "aldebaran",
    hint = "io",
    info = "helios",
    ok = "aurora",
    warn = "solar",
    note = "nebula",
    todo = "solar",

    git_add = "aurora",
    git_change = "solar",
    git_delete = "aldebaran",
    git_dirty = "solar",
    git_ignore = "twilight",
    git_merge = "nova",
    git_rename = "nebula",
    git_stage = "nova",
    git_text = "solar",
    git_untracked = "halo",

    ---@type string | PaletteColor
    h1 = "nova",
    h2 = "helios",
    h3 = "solar",
    h4 = "stellar",
    h5 = "aurora",
    h6 = "nebula",
  },

  ---@type table<string, Highlight>
  highlight_groups = {},

  ---Called before each highlight group, before setting the highlight.
  ---@param group string
  ---@param highlight Highlight
  ---@param palette Palette
  ---@diagnostic disable-next-line: unused-local
  before_highlight = function(group, highlight, palette) end,
}

local function migrate(options)
  -- Handle backward compatibility
  if options.disable_background then
    options.highlight_groups["Normal"] = { bg = "NONE" }
  end

  if options.disable_float_background then
    options.highlight_groups["NormalFloat"] = { bg = "NONE" }
  end

  options.dim_inactive_windows = options.dim_nc_background or options.dim_inactive_windows

  if options.groups.background ~= nil then
    options.highlight_groups["Normal"] = { bg = options.groups.background }
  end

  if options.groups.comment ~= nil then
    options.highlight_groups["Comment"] = { fg = options.groups.comment }
  end

  if options.groups.punctuation ~= nil then
    options.highlight_groups["@punctuation"] = { fg = options.groups.punctuation }
  end

  options.styles.transparency = (options.disable_background and options.disable_float_background)
    or options.styles.transparency

  -- Handle bold style options
  options.styles.bold = not (options.disable_bold or options.disable_bolds) and options.styles.bold or false

  -- Handle italic style options
  options.styles.italic = not (options.disable_italic or options.disable_italics) and options.styles.italic or false

  -- Set h1 through h6 to the same color if only one is specified
  if type(options.groups.headings) == "string" then
    options.groups.h1 = options.groups.headings
    options.groups.h2 = options.groups.headings
    options.groups.h3 = options.groups.headings
    options.groups.h4 = options.groups.headings
    options.groups.h5 = options.groups.headings
    options.groups.h6 = options.groups.headings
  elseif type(options.groups.headings) == "table" then
    options.groups.h1 = options.groups.headings.h1 or options.groups.h1
    options.groups.h2 = options.groups.headings.h2 or options.groups.h2
    options.groups.h3 = options.groups.headings.h3 or options.groups.h3
    options.groups.h4 = options.groups.headings.h4 or options.groups.h4
    options.groups.h5 = options.groups.headings.h5 or options.groups.h5
    options.groups.h6 = options.groups.headings.h6 or options.groups.h6
  end
  options.groups.headings = nil

  return options
end

---@param options Options | nil
function config.extend_options(options)
  config.options = vim.tbl_deep_extend("force", config.options, options or {})

  if config.options.enable.migrations then
    config.options = migrate(config.options)
  end
end

return config
