local dap_status_ok, dap = pcall(require, "dap")
if not dap_status_ok then
	return
end
local utils_status_ok, utils = pcall(require, "user.utils")
if not utils_status_ok then
	return
end

local mason_registry = require("mason-registry")
local path = mason_registry.get_package("netcoredbg"):get_install_path() .. "/build/netcoredbg"
-- C# .NET
dap.adapters.coreclr = {
	type = "executable",
	command = path,
	args = { "--interpreter=vscode" },
}
-- Neotest requires a netcoredbg adapter for some reason.
dap.adapters.netcoredbg = dap.adapters.coreclr
dap.configurations.cs = {
	{
		type = "coreclr",
		name = "launch - netcoredbg",
		request = "launch",
		justMyCode = false,
		args = {
			"--urls=https://localhost:7035/",
		},
		cwd = "{workspaceFolder}",
		env = {
			ASPNETCORE_ENVIRONMENT = "Development",
		},
		program = function()
			utils.dotnet_build_project()
			return utils.get_debug_program()
		end,
	},
}
