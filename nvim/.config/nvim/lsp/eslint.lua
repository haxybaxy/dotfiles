-- npm install -g vscode-langservers-extracted
---@type vim.lsp.Config
return {
	cmd = { "vscode-eslint-language-server", "--stdio" },
	filetypes = {
		"javascript",
		"javascriptreact",
		"typescript",
		"typescriptreact",
	},
	root_markers = {
		"eslint.config.js",
		"eslint.config.mjs",
		"eslint.config.cjs",
		".eslintrc",
		".eslintrc.js",
		".eslintrc.json",
		".eslintrc.yml",
		"package.json",
		".git",
	},
	settings = {
		validate = "on",
		packageManager = vim.NIL,
		useESLintClass = false,
		experimental = { useFlatConfig = false },
		codeActionOnSave = { enable = false, mode = "all" },
		format = false,
		quiet = false,
		onIgnoredFiles = "off",
		options = {},
		rulesCustomizations = {},
		run = "onType",
		problems = { shortenToSingleLine = false },
		nodePath = "",
		workingDirectory = { mode = "location" },
		codeAction = {
			disableRuleComment = { enable = true, location = "separateLine" },
			showDocumentation = { enable = true },
		},
	},
	before_init = function(params, config)
		config.settings.workspaceFolder = {
			uri = params.rootPath,
			name = vim.fn.fnamemodify(params.rootPath, ":t"),
		}
	end,
	handlers = {
		["eslint/openDoc"] = function(_, params)
			vim.ui.open(params.url)
			return {}
		end,
		["eslint/probeFailed"] = function()
			vim.notify("LSP[eslint]: Probe failed.", vim.log.levels.WARN)
			return {}
		end,
		["eslint/noLibrary"] = function()
			vim.notify("LSP[eslint]: Unable to load ESLint library.", vim.log.levels.WARN)
			return {}
		end,
	},
}
