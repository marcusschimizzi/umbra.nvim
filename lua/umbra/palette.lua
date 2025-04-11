local options = require("umbra.config").options
local variants = {
  umbra = {
    -- Core backgrounds
    _nc = "#0d0d12",
    umbra = "#121218", -- Base background (Deep dark blue-black)
    penumbra = "#1e1e26", -- Secondary background (Slightly lighter for elevation)
    antumbra = "#2a2a36", -- Tertiary background (Highest elevation)

    -- Highlight states
    eclipse = "#1a1a23", -- Low contrast highlights (Subtle highlight for cursor line)
    occult = "#252532", -- Medium contrast highlights (Medium contrast for active elements)
    transit = "#313142", -- High contrast highlights (High contrast for selections)

    -- Text colors
    corona = "#e8e8e8", -- Primary text (Light gray)
    halo = "#909090", -- Secondary text (Medium gray)
    astral = "#6D7A8C", -- Subtle text (Additional emphasis level)
    twilight = "#3B4B5F", -- Muted text (Muted blue)

    -- Core accent colors
    aurora = "#4CAF8F", -- Primary green (Primary interaction color)
    nebula = "#61B8D6", -- Primary blue (Secondary accent)
    nova = "#9D7CD8", -- Primary purple (Tertiary accent)
    solar = "#FF9C6A", -- Primary orange (Warnings/strings)
    stellar = "#E4BF7F", -- Primary gold (Numbers/special elements)

    -- Extended accent colors
    aldebaran = "#E65A5A", -- Error red (Errors, deletions)
    celaeno = "#E6A2A2", -- Modified pink (Search highlights, modified files)
    helios = "#80C7DB", -- Info cyan (Info, git additions)
    io = "#B794E6", -- Hint purple (Hints, links, staged changes)

    -- Special colors
    none = "NONE",
  },

  penumbra = {
    -- Core backgrounds
    _nc = "#F0F0F2",
    umbra = "#FFFFFF", -- Base background (Pure white)
    penumbra = "#F5F5F7", -- Secondary background (Light gray for elevation)
    antumbra = "#E8E8EA", -- Tertiary background (Slightly darker for highest elevation)

    -- Highlight states
    eclipse = "#F9F9FC", -- Low contrast highlights
    occult = "#EDEDF0", -- Medium contrast highlights
    transit = "#E0E0E5", -- High contrast highlights

    -- Text colors
    corona = "#1A1A1F", -- Primary text (Near black)
    halo = "#4A4A57", -- Secondary text (Dark gray)
    astral = "#57647A", -- Subtle text (Additional emphasis level)
    twilight = "#6B7D93", -- Muted text (Muted blue-gray)

    -- Core accent colors
    aurora = "#2A916C", -- Primary green (Darker for contrast)
    nebula = "#2B82A3", -- Primary blue (Darker for contrast)
    nova = "#7850B4", -- Primary purple (Adjusted for light background)
    solar = "#E67E45", -- Primary orange (Muted for light background)
    stellar = "#B88D3C", -- Primary gold (Darker for contrast)

    -- Extended accent colors
    aldebaran = "#D03F3F", -- Error red
    celaeno = "#D07070", -- Modified pink
    helios = "#3E9BC2", -- Info cyan
    io = "#9F76D6", -- Hint purple

    -- Special colors
    none = "NONE",
  },

  antumbra = {
    -- Core backgrounds
    _nc = "#070711",
    umbra = "#0A0A14", -- Base background (Deeper dark)
    penumbra = "#151522", -- Secondary background (Elevated dark)
    antumbra = "#1E1E2F", -- Tertiary background (Highest elevation)

    -- Highlight states
    eclipse = "#11111C", -- Low contrast highlights
    occult = "#1A1A2A", -- Medium contrast highlights
    transit = "#23233A", -- High contrast highlights

    -- Text colors
    corona = "#F8F8FF", -- Primary text (Bright white)
    halo = "#A0A0B2", -- Secondary text (Light gray)
    astral = "#8A96A8", -- Subtle text (Additional emphasis level)
    twilight = "#4B6280", -- Muted text (Brightened muted blue)

    -- Core accent colors
    aurora = "#56DBA9", -- Primary green (Brighter, more saturated)
    nebula = "#7CD4F1", -- Primary blue (More luminous)
    nova = "#B794F6", -- Primary purple (More vibrant)
    solar = "#FFB182", -- Primary orange (Brighter)
    stellar = "#FFD700", -- Primary gold (More vivid)

    -- Extended accent colors
    aldebaran = "#FF6B6B", -- Error red (Brighter)
    celaeno = "#FFB3B3", -- Modified pink (Brighter)
    helios = "#99E3F9", -- Info cyan (Brighter)
    io = "#D0BCFF", -- Hint purple (Brighter)

    -- Special colors
    none = "NONE",
  },
}

if options.palette ~= nil and next(options.palette) then
  -- Handle variant specific overrides
  for variant_name, override_palette in pairs(options.palette) do
    if variants[variant_name] then
      variants[variant_name] = vim.tbl_extend("force", variants[variant_name], override_palette or {})
    end
  end
end

if variants[options.variant] ~= nil then
  return variants[options.variant]
end

return vim.o.background == "light" and variants.penumbra or variants[options.dark_variant or "umbra"]
