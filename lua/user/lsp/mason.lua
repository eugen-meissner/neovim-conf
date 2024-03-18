local lsp_servers = {
	"lua_ls",
	"omnisharp",
	"cssls",
	"html",
	"tailwindcss",
	"tsserver",
	"pyright",
	"bashls",
	"jsonls",
	"yamlls",
	"hls",
	"rust_analyzer",
	"eslint",
	"terraformls",
	"lemminx",
}

local settings = {
	ui = {
		border = "none",
		icons = {
			package_installed = "◍",
			package_pending = "◍",
			package_uninstalled = "◍",
		},
	},
	log_level = vim.log.levels.INFO,
	max_concurrent_installers = 4,
}

require("mason").setup(settings)
-- require("mason-lspconfig").setup({
-- 	ensure_installed = lsp_servers,
-- 	automatic_installation = true,
-- })
require("mason-nvim-dap").setup({
	-- Makes a best effort to setup the various debuggers with
	-- reasonable debug configurations
	automatic_setup = true,

	-- You can provide additional configuration to the handlers,
	-- see mason-nvim-dap README for more information
	handlers = {},

	-- You'll need to check that you have the required things installed
	-- online, please don't ask me how to install them :)
	ensure_installed = {
		"codelldb",
		"netcoredbg",
	},
})

require("overseer").setup()
require("dap.ext.vscode").json_decode = require("overseer.json").decode

local lspconfig_status_ok, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status_ok then
	return
end

local opts = {}

for _, server in pairs(lsp_servers) do
	opts = {
		on_attach = require("user.lsp.handlers").on_attach,
		capabilities = require("user.lsp.handlers").capabilities,
	}

	server = vim.split(server, "@")[1]

	local require_ok, conf_opts = pcall(require, "user.lsp.settings." .. server)
	if require_ok then
		opts = vim.tbl_deep_extend("force", conf_opts, opts)
	end

	lspconfig[server].setup(opts)
end
