local status_ok, lsp_saga = pcall(require, "lspsaga")
if not status_ok then
	return
end

lsp_saga.setup({
	lightbulb = {
		enable = false,
	},
})
