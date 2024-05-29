local status_ok, neogit = pcall(require, "neogit")
if not status_ok then
	print("neofit not here")
	return
end

neogit.setup()
