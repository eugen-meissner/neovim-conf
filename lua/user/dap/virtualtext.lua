local vt_status_ok, vt = pcall(require, "nvim-dap-virtual-text")
if not vt_status_ok then
	return
end

vt.setup()
