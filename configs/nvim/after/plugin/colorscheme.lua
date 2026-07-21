local ok = pcall(vim.cmd.colorscheme, "flexoki")
if not ok then
  vim.cmd.colorscheme("habamax")
end

local transparent_groups = {
  "Normal",
  "NormalNC",
  "EndOfBuffer",
  "NormalFloat",
  "FloatBorder",
  "SignColumn",
  "StatusLine",
  "StatusLineNC",
  "TabLine",
  "TabLineFill",
  "TabLineSel",
  "ColorColumn",
}

for _, group in ipairs(transparent_groups) do
  -- vim.api.nvim_set_hl(0, group, { bg = "none" })
end

vim.api.nvim_set_hl(0, "TabLineFill", { bg = "none", fg = "#767676" })
