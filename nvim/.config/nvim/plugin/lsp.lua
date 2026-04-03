vim.pack.add({ "https://github.com/b0o/SchemaStore.nvim" })

-- Diagnostics configuration
vim.diagnostic.config({
	virtual_text = true,
	float = { source = true },
	severity_sort = true,
	signs = true,
})

-- LSP keymaps on attach
vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(args)
		local bufnr = args.buf
		local client = vim.lsp.get_client_by_id(args.data.client_id)
		if not client then
			return
		end

		local map = function(mode, lhs, rhs, desc)
			vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
		end

		map("n", "K", vim.lsp.buf.hover, "Hover info")
		map("n", "<leader>ca", vim.lsp.buf.code_action, "Code action")
		map("n", "<leader>gn", vim.lsp.buf.rename, "Rename symbol")
		map("n", "<leader>D", vim.lsp.buf.type_definition, "Type definition")
		map("n", "<leader>ds", vim.diagnostic.open_float, "Show diagnostics")
		map("n", "<leader>ih", function()
			vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
		end, "Toggle inlay hints")

		-- Document highlighting
		if client:supports_method("textDocument/documentHighlight") then
			vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
				buffer = bufnr,
				callback = vim.lsp.buf.document_highlight,
			})
			vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
				buffer = bufnr,
				callback = vim.lsp.buf.clear_references,
			})
		end
	end,
})

-- Inject blink.cmp capabilities into all servers
vim.lsp.config("*", {
	capabilities = require("blink.cmp").get_lsp_capabilities(),
})

-- Discover and enable all servers from lsp/ directory
local servers = vim.iter(vim.api.nvim_get_runtime_file("lsp/*.lua", true))
	:map(function(file)
		return vim.fn.fnamemodify(file, ":t:r")
	end)
	:totable()
vim.lsp.enable(servers)
