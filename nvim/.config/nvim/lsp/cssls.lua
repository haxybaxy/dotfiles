-- npm install -g vscode-langservers-extracted
---@type vim.lsp.Config
return {
    cmd = { 'vscode-css-language-server', '--stdio' },
    filetypes = { 'css', 'scss', 'less' },
    root_markers = { 'package.json', '.git' },
}
