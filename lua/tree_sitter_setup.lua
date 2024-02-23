local M = {}

M.setup = function()
    require('nvim-treesitter.configs').setup {
        ensure_installed = { "c", "cmake", "cpp", "dart", "vim", "vimdoc", "query",
            "typescript", "zig", "go", "gomod", "javascript", "rust", "lua" },
        sync_install = true,
        indent = {
            enable = true
        },
        highlight = {
            enable = true
        }
    }

    --setup nuru-treesitter
    local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
    parser_config.nuru = {
        install_info = {
            url = "/home/brian/Workspaces/nuru-lsp/nuru-tree-sitter/",
            files = { "src/parser.c" },
            branch = "dev",
            generate_requires_npm = false,
            requires_generate_from_grammar = false
        },
        file_type = "nr"
    }
end



return M
