local dap_status_ok, dap = pcall(require, "dap")
if not dap_status_ok then
	return
end
local utils_status_ok, utils = pcall(require, "user.utils")
if not utils_status_ok then
	return
end

dap.adapters.coreclr = {
	type = "executable",
	command = vim.fn.expandcmd("~/.local/share/nvim/mason/packages/netcoredbg/build/netcoredbg"),
	args = { "--interpreter=vscode" },
}
-- Neotest requires a netcoredbg adapter for some reason.
dap.adapters.netcoredbg = dap.adapters.coreclr

dap.configurations.cs = utils.get_debug_config()

if dap.configurations.cs == nil then
	dap.configurations.cs = {
		{
			type = "coreclr",
			name = "Debug",
			request = "launch",
			program = function()
				utils.dotnet_build_project()
				return utils.get_debug_program()
			end,
		},
	}
end
