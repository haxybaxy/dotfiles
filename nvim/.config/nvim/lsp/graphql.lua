-- npm install -g graphql-language-service-cli
---@type vim.lsp.Config
return {
    cmd = { 'graphql-lsp', 'server', '-m', 'stream' },
    filetypes = { 'graphql' },
    root_markers = {
        '.graphqlrc', '.graphqlrc.json', '.graphqlrc.yaml', '.graphqlrc.yml',
        'graphql.config.js', 'graphql.config.ts',
        '.git',
    },
}
