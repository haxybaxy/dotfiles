vim.pack.add({
	"https://github.com/mfussenegger/nvim-dap",
	"https://github.com/mfussenegger/nvim-dap-python",
	"https://github.com/rcarriga/nvim-dap-ui",
	"https://github.com/theHamsta/nvim-dap-virtual-text",
	"https://github.com/nvim-neotest/nvim-nio",
})

local dap = require("dap")
local dapui = require("dapui")

dapui.setup()
require("nvim-dap-virtual-text").setup({})

-- Resolve the python interpreter from whichever project venv is currently
-- active. debugpy needs to be installed in that venv: `pip install debugpy`.
-- Checks $VIRTUAL_ENV first, then ./.venv, then ./venv.
local function project_python()
	local venv = os.getenv("VIRTUAL_ENV")
	if venv and vim.fn.executable(venv .. "/bin/python") == 1 then
		return venv .. "/bin/python"
	end
	local cwd = vim.fn.getcwd()
	for _, name in ipairs({ ".venv", "venv" }) do
		local p = cwd .. "/" .. name .. "/bin/python"
		if vim.fn.executable(p) == 1 then
			return p
		end
	end
	return "python3"
end

require("dap-python").setup("python3", { resolve_python = project_python })

dap.adapters.python = function(cb)
	cb({
		type = "executable",
		command = project_python(),
		args = { "-m", "debugpy.adapter" },
	})
end

dap.listeners.before.attach.dapui_config = function()
	dapui.open()
end
dap.listeners.before.launch.dapui_config = function()
	dapui.open()
end
dap.listeners.before.event_terminated.dapui_config = function()
	dapui.close()
end
dap.listeners.before.event_exited.dapui_config = function()
	dapui.close()
end

vim.fn.sign_define("DapBreakpoint", { text = "●", texthl = "DiagnosticError" })
vim.fn.sign_define("DapBreakpointCondition", { text = "◆", texthl = "DiagnosticWarn" })
vim.fn.sign_define("DapLogPoint", { text = "◆", texthl = "DiagnosticInfo" })
vim.fn.sign_define("DapStopped", { text = "→", texthl = "DiagnosticOk" })

local map = vim.keymap.set
map("n", "<leader>db", dap.toggle_breakpoint, { desc = "Toggle breakpoint" })
map("n", "<leader>dB", function()
	dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
end, { desc = "Conditional breakpoint" })
map("n", "<leader>dc", dap.continue, { desc = "Continue / start" })
map("n", "<leader>di", dap.step_into, { desc = "Step into" })
map("n", "<leader>do", dap.step_over, { desc = "Step over" })
map("n", "<leader>dO", dap.step_out, { desc = "Step out" })
map("n", "<leader>dl", dap.run_last, { desc = "Run last" })
map("n", "<leader>dr", dap.repl.toggle, { desc = "Toggle REPL" })
map("n", "<leader>dt", dap.terminate, { desc = "Terminate session" })
map("n", "<leader>du", dapui.toggle, { desc = "Toggle DAP UI" })
map({ "n", "v" }, "<leader>de", function()
	require("dapui").eval()
end, { desc = "Evaluate expression" })
