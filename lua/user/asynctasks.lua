local status_ok, _ = pcall(require, "skywind3000/asynctasks.vim")
if not status_ok then
	return
end

vim.g.asyncrun_open = 6
vim.g.asyncrun_rootmarks = { ".git", ".projectile", ".gitignore" }
