-- cargo install tinymist (or: brew install tinymist)
---@type vim.lsp.Config
return {
    cmd = { 'tinymist' },
    filetypes = { 'typst' },
    root_markers = { '.git' },
    settings = {
        formatterMode = 'typstyle',
        exportPdf = 'onType',
        semanticTokens = 'disable',
    },
    on_attach = function(client, bufnr)
        vim.keymap.set('n', '<leader>tp', function()
            client:exec_cmd({
                title = 'pin',
                command = 'tinymist.pinMain',
                arguments = { vim.api.nvim_buf_get_name(0) },
            }, { bufnr = bufnr })
        end, { buffer = bufnr, desc = '[T]inymist [P]in' })

        vim.keymap.set('n', '<leader>tu', function()
            client:exec_cmd({
                title = 'unpin',
                command = 'tinymist.pinMain',
                arguments = { vim.v.null },
            }, { bufnr = bufnr })
        end, { buffer = bufnr, desc = '[T]inymist [U]npin' })
    end,
}
