-- npm install -g vscode-langservers-extracted
---@type vim.lsp.Config
return {
    cmd = { 'vscode-css-language-server', '--stdio' },
    filetypes = { 'css', 'scss', 'less' },
    root_markers = { 'package.json', '.git' },
    init_options = { provideFormatter = true },
    -- the server skips validation entirely unless these are set
    settings = {
        css = { validate = true },
        scss = { validate = true },
        less = { validate = true },
    },
}
