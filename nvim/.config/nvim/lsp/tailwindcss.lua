-- npm install -g @tailwindcss/language-server
---@type vim.lsp.Config
return {
    cmd = { 'tailwindcss-language-server', '--stdio' },
    filetypes = { 'html', 'css', 'scss', 'javascript', 'javascriptreact', 'typescript', 'typescriptreact' },
    root_markers = { 'tailwind.config.js', 'tailwind.config.ts', 'tailwind.config.cjs', 'tailwind.config.mjs', '.git' },
}
