return {
	handlers = {
		["textDocument/definition"] = require("omnisharp_extended").handler,
	},
	cmd = { "omnisharp", "--languageserver", "--hostPID", tostring(vim.fn.getpid()) },
}
