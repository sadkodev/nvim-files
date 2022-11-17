--- This module will load a random colorscheme on nvim startup process.

local utils = require("utils")

local M = {}

-- Colorscheme to its directory name mapping, because colorscheme repo name is not necessarily
-- the same as the colorscheme name itself.
M.colorscheme2dir = {
  -- gruvbox8 = "vim-gruvbox8",
  -- onedark = "onedark.nvim",
  -- edge = "edge",
  -- sonokai = "sonokai",
  -- gruvbox_material = "gruvbox-material",
  nord = "nord.nvim",
  -- doom_one = "doom-one.nvim",
  -- everforest = "everforest",
  -- nightfox = "nightfox.nvim",
  -- kanagawa = "kanagawa.nvim",
  -- catppuccin = "catppuccin",
}

M.gruvbox8 = function()
  -- Italic options should be put before colorscheme setting,
  -- see https://github.com/morhetz/gruvbox/wiki/Terminal-specific#1-italics-is-disabled
  vim.g.gruvbox_italics = 1
  vim.g.gruvbox_italicize_strings = 1
  vim.g.gruvbox_filetype_hi_groups = 1
  vim.g.gruvbox_plugin_hi_groups = 1

  vim.cmd([[colorscheme gruvbox8_hard]])
end

M.onedark = function()
  vim.cmd([[colorscheme onedark]])
end

M.edge = function()
  vim.g.edge_enable_italic = 1
  vim.g.edge_better_performance = 1

  vim.cmd([[colorscheme edge]])
end

M.sonokai = function()
  vim.g.sonokai_enable_italic = 1
  vim.g.sonokai_better_performance = 1

  vim.cmd([[colorscheme sonokai]])
end

M.gruvbox_material = function()
  vim.g.gruvbox_material_enable_italic = 1
  vim.g.gruvbox_material_better_performance = 1

  vim.cmd([[colorscheme gruvbox-material]])
end

M.nord = function()
  vim.cmd([[colorscheme nord]])
end

M.doom_one = function()
  vim.cmd([[colorscheme doom-one]])
end

M.everforest = function()
  vim.g.everforest_enable_italic = 1
  vim.g.everforest_better_performance = 1

  vim.cmd([[colorscheme everforest]])
end

M.nightfox = function()
  vim.cmd([[colorscheme nordfox]])
end

M.kanagawa = function()
  vim.cmd([[colorscheme kanagawa]])
end

M.catppuccin = function()
  -- available option: latte, frappe, macchiato, mocha
  vim.g.catppuccin_flavour = "frappe"

  require("catppuccin").setup()

  vim.cmd([[colorscheme catppuccin]])
end

--- Use a random colorscheme from the pre-defined list of colorschemes.
M.rand_colorscheme = function()
  local colorscheme = utils.rand_element(vim.tbl_keys(M.colorscheme2dir))

  if not vim.tbl_contains(vim.tbl_keys(M), colorscheme) then
    local msg = "Invalid colorscheme: " .. colorscheme
    vim.notify(msg, vim.log.levels.ERROR, { title = "nvim-config" })

    return
  end

  -- Load the colorscheme, because all the colorschemes are declared as opt plugins, so the colorscheme isn't loaded yet.
  local status = utils.add_pack(M.colorscheme2dir[colorscheme])

  if not status then
    local msg = string.format("Colorscheme %s is not installed. Run PackerSync to install.", colorscheme)
    vim.notify(msg, vim.log.levels.ERROR, { title = "nvim-config" })

    return
  end

  -- Load the colorscheme and its settings
  M[colorscheme]()

  if vim.g.logging_level == "debug" then
    local msg = "Colorscheme: " .. colorscheme

    vim.notify(msg, vim.log.levels.DEBUG, { title = "nvim-config" })
  end
end

-- Load a random colorscheme
M.rand_colorscheme()
