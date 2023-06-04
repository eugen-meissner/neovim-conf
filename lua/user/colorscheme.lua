local colorscheme = "kanagawa"

if colorscheme == "moonlight" then
	vim.g.moonlight_italic_comments = true
	vim.g.moonlight_italic_keywords = true
	vim.g.moonlight_italic_functions = true
	vim.g.moonlight_italic_variables = false
	vim.g.moonlight_contrast = true
	vim.g.moonlight_borders = true
	vim.g.moonlight_disable_background = true
end

local _, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
