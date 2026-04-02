-- brew install hashicorp/tap/terraform-ls
---@type vim.lsp.Config
return {
    cmd = { 'terraform-ls', 'serve' },
    filetypes = { 'terraform', 'tf', 'hcl' },
    root_markers = { '.terraform', 'main.tf', '.git' },
}
