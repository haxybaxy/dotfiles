-- brew install lua-language-server
--
-- lazydev.nvim feeds Lua.workspace.library and Lua.runtime.path to this client.
-- .luarc.json beats client settings key by key, so setting those keys there
-- silently turns lazydev off for that workspace.
---@type vim.lsp.Config
return {
    cmd = { 'lua-language-server' },
    filetypes = { 'lua' },
    root_markers = { '.luarc.json', '.luarc.jsonc', '.stylua.toml', 'stylua.toml', '.git' },
    settings = {
        Lua = {
            hint = { enable = true }, -- off by default; needed for <leader>ih
            telemetry = { enable = false },
        },
    },
}
