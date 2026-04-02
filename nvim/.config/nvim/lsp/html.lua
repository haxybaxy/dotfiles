-- npm install -g vscode-langservers-extracted
---@type vim.lsp.Config
return {
    cmd = { 'vscode-html-language-server', '--stdio' },
    filetypes = { 'html', 'htmldjango' },
    root_markers = { 'package.json', '.git' },
}
