-- npm install -g emmet-ls
---@type vim.lsp.Config
return {
    cmd = { 'emmet-ls', '--stdio' },
    filetypes = { 'html', 'htmldjango', 'css', 'scss' },
    root_markers = { 'package.json', '.git' },
}
