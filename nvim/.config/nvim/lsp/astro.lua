-- npm install -g @astrojs/language-server typescript@6
-- (typescript 7 is the native port and has no lib/ for astro-ls to load)
---@type vim.lsp.Config
return {
    cmd = { 'astro-ls', '--stdio' },
    filetypes = { 'astro' },
    root_markers = { 'astro.config.mjs', 'astro.config.ts', 'astro.config.js', 'package.json', 'tsconfig.json', '.git' },
    init_options = { typescript = {} },
    before_init = function(params, config)
        -- prefer the project's typescript, fall back to the global one next to astro-ls
        local project_tsdk = vim.fs.joinpath(params.rootPath or '', 'node_modules', 'typescript', 'lib')
        if vim.uv.fs_stat(project_tsdk) then
            config.init_options.typescript.tsdk = project_tsdk
        else
            local bin = vim.fn.exepath('astro-ls')
            local global_root = vim.fs.joinpath(vim.fs.dirname(vim.fs.dirname(bin)), 'lib', 'node_modules')
            config.init_options.typescript.tsdk = vim.fs.joinpath(global_root, 'typescript', 'lib')
        end
    end,
}
