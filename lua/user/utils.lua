local utils = {}

utils.decode_json_file = function(filename)
	if vim.fn.filereadable(filename) == 0 then
		return nil
	end

	return vim.fn.json_decode(vim.fn.readfile(filename))
end

utils.replace_string_values = function(original, to_replace, replace_with)
	if type(original) == "string" or type(original) == "number" then
		return string.gsub(tostring(original), to_replace, replace_with)
	end

	if type(original) == "table" then
		for key, value in pairs(original) do
			original[key] = utils.replace_string_values(value, to_replace, replace_with)
		end
	end

	return original
end

utils.dotnet_build_project = function()
	local path = vim.fn.getcwd() .. "/"
	local cmd = "dotnet build --configuration Debug " .. path .. " > /dev/null"
	print("")
	print("Cmd to execute: " .. cmd)
	local f = os.execute(cmd)
	if f == 0 then
		print("\nBuild: ✔️ ")
	else
		print("\nBuild: ❌ (code: " .. f .. ")")
	end
end

utils.get_debug_config = function()
	local dap_config = utils.decode_json_file(vim.fn.getcwd() .. "/.dap.json")
	if dap_config ~= nil then
		return { dap_config }
	end

	local status_ok, vscode_launch_file = pcall(utils.decode_json_file, vim.fn.getcwd() .. "/.vscode/launch.json")
	if status_ok and vscode_launch_file ~= nil then
		local configs = vscode_launch_file["configurations"]
		if configs ~= nil then
			for j = 1, #configs do
				if configs[j]["request"] == "launch" then
					local config = utils.replace_string_values(configs[j], "${workspaceRoot}", vim.fn.getcwd())
					return { config }
				end
			end
			return utils.replace_string_values(configs, "${workspaceRoot}", vim.fn.getcwd())
		end
	end

	return nil
end

utils.get_debug_program = function()
	local dap_config = utils.decode_json_file(vim.fn.getcwd() .. "/.dap.json")
	if dap_config ~= nil then
		local program = dap_config["program"]
		if program ~= nil then
			return program
		end
	end

	local status_ok, vscode_launch_file = pcall(utils.decode_json_file, vim.fn.getcwd() .. "/.vscode/launch.json")
	if status_ok and vscode_launch_file ~= nil then
		local configs = vscode_launch_file["configurations"]
		if configs ~= nil then
			for j = 1, #configs do
				if configs[j]["request"] == "launch" then
					return utils.replace_string_values(configs[j]["program"], "${workspaceRoot}", vim.fn.getcwd())
				end
			end
		end
	end

	return vim.fn.input({ "Path to program/dll: ", vim.fn.getcwd(), "/src/<>.BE.API/bin/Debug/net7.0/<>.BE.API.dll" })
end

return utils
