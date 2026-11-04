local M = {}

---@param path string
---@return table?
local function read_package_json(path)
	local ok, pkg = pcall(function()
		return vim.json.decode(table.concat(vim.fn.readfile(path), "\n"), { luanil = { object = true } })
	end)
	return ok and type(pkg) == "table" and pkg or nil
end

--- Finds the root of the project that uses a JS tool. A config file anywhere
--- upward wins over package.json, so a monorepo's root config isn't skipped for
--- a package that only lists the dependency.
---@param bufnr integer
---@param config_files string[]
---@param accepts fun(pkg: table): boolean Whether a package.json uses the tool.
---@return string?
function M.find(bufnr, config_files, accepts)
	return vim.fs.root(bufnr, config_files)
		or vim.fs.root(bufnr, function(name, dir)
			if name ~= "package.json" then
				return false
			end
			local pkg = read_package_json(vim.fs.joinpath(dir, name))
			return pkg ~= nil and accepts(pkg)
		end)
end

return M
