-- brew install llvm (or: xcode-select --install)
---@type vim.lsp.Config
return {
    cmd = {
        'clangd',
        '--background-index',
        '--clang-tidy',
        '--header-insertion=iwyu',
        '--completion-style=detailed',
        '--function-arg-placeholders',
        '--fallback-style=llvm',
    },
    filetypes = { 'c', 'cpp', 'objc', 'objcpp', 'cuda', 'proto' },
    root_markers = {
        '.clangd', '.clang-tidy', '.clang-format',
        'compile_commands.json', 'compile_flags.txt',
        'configure.ac', '.git',
    },
    init_options = {
        usePlaceholders = true,
        completeUnimported = true,
        clangdFileStatus = true,
    },
}
