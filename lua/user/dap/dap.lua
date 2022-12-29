local dap_status_ok, dap = pcall(require, "dap")
if not dap_status_ok then
	return
end
local utils_status_ok, utils = pcall(require, "user.utils")
if not utils_status_ok then
	return
end

-- Note December 16 2022
-- Manually installed netcoredbg for Mac M1 ARM64
-- https://github.com/codeprefect/netcoredbg/releases/
--
-- Remember to allow execution of unsigned netcoredbg executabe on macOS
--
-- If you are using amd64/x86 computer, you may install netcoredbg with Mason.

local netcore_debugger_location = "~/.local/share/nvim/mason/packages/netcoredbg/build/netcoredbg"

dap.adapters.coreclr = {
	type = "executable",
	command = vim.fn.expandcmd(netcore_debugger_location),
	args = { "--interpreter=vscode" },
}

dap.adapters.netcoredbg = {
	type = "executable",
	command = vim.fn.expandcmd(netcore_debugger_location),
	args = { "--interpreter=vscode" },
}

dap.configurations.cs = utils.get_debug_config()

if dap.configurations.cs == nil then
	dap.configurations.cs = {
		{
			type = "coreclr",
			name = "launch - netcoredbg",
			request = "launch",
			program = function()
				utils.dotnet_build_project()
				return utils.get_debug_program()
			end,
		},
	}
end
