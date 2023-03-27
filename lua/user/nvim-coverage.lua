local status_ok, coverage = pcall(require, "coverage")
if not status_ok then
	return
end

coverage.setup()
