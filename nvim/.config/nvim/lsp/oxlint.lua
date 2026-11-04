-- Uses the project's oxlint (the language server ships inside it).
-- Fallback for projects without a local install: npm install -g oxlint
local js_root = require("js_root")

local config_files = { ".oxlintrc.json", ".oxlintrc.jsonc", "oxlint.config.ts" }

---@param pkg table
---@return boolean
local function uses_oxlint(pkg)
	return (pkg.devDependencies or {}).oxlint ~= nil or (pkg.dependencies or {}).oxlint ~= nil
end

---@param root string
---@return string?
local function find_binary(root)
	local installed = vim.fs.find("node_modules/.bin/oxlint", { path = root, upward = true })[1]
	if installed then
		return installed
	end
	return vim.fn.executable("oxlint") == 1 and "oxlint" or nil
end

---@type vim.lsp.Config
return {
	cmd = function(dispatchers, config)
		return vim.lsp.rpc.start({ find_binary(config.root_dir), "--lsp" }, dispatchers, { cwd = config.root_dir })
	end,
	filetypes = {
		"javascript",
		"javascriptreact",
		"typescript",
		"typescriptreact",
		"astro",
		"vue",
		"svelte",
	},
	root_dir = function(bufnr, on_dir)
		local root = js_root.find(bufnr, config_files, uses_oxlint)
		if not root then
			return
		end
		if find_binary(root) then
			on_dir(root)
		else
			vim.notify_once("LSP[oxlint]: oxlint not found. Install the project's dependencies.", vim.log.levels.WARN)
		end
	end,
}
