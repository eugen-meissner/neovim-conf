local dap_status_ok, dap = pcall(require, "dap")
if not dap_status_ok then
	return
end
local utils_status_ok, utils = pcall(require, "user.utils")
if not utils_status_ok then
	return
end

-- C# .NET
dap.adapters.coreclr = {
	type = "executable",
	command = "netcoredbg",
	args = { "--interpreter=vscode" },
}
