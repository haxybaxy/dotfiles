-- npm install -g basedpyright (or: pip install basedpyright)
---@type vim.lsp.Config
return {
    cmd = { 'basedpyright-langserver', '--stdio' },
    filetypes = { 'python' },
    root_markers = { 'pyrightconfig.json', 'pyproject.toml', 'setup.py', 'setup.cfg', '.git' },
    settings = {
        basedpyright = {
            analysis = {
                typeCheckingMode = 'strict',
                autoSearchPaths = true,
                useLibraryCodeForTypes = true,
                diagnosticMode = 'workspace',
            },
        },
        python = {
            analysis = {
                inlayHints = {
                    variableTypes = true,
                    functionReturnTypes = true,
                    callArgumentNames = true,
                    pytestParameters = true,
                },
            },
        },
    },
}
