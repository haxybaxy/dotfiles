-- npm install -g @astrojs/language-server typescript@6
-- (typescript 7 is the native port and has no lib/ for astro-ls to load)
---@type vim.lsp.Config
return {
    cmd = { 'astro-ls', '--stdio' },
    filetypes = { 'astro' },
    root_markers = { 'astro.config.mjs', 'astro.config.ts', 'astro.config.js', 'package.json', 'tsconfig.json', '.git' },
    init_options = { typescript = {} },
    before_init = function(params, config)
        -- set tsdk on this table, not a new one: params.initializationOptions shares it
        local typescript = config.init_options.typescript --[[@as table]]
        -- rootPath is vim.NIL, which is truthy, when no root marker matched
        local root = params.rootPath
        local project_tsdk = type(root) == 'string' and vim.fs.joinpath(root, 'node_modules', 'typescript', 'lib')
        -- prefer the project's typescript, fall back to the global one next to astro-ls
        if project_tsdk and vim.uv.fs_stat(project_tsdk) then
            typescript.tsdk = project_tsdk
        else
            local bin = vim.fn.exepath('astro-ls')
            local global_root = vim.fs.joinpath(vim.fs.dirname(vim.fs.dirname(bin)), 'lib', 'node_modules')
            typescript.tsdk = vim.fs.joinpath(global_root, 'typescript', 'lib')
        end
    end,
}
