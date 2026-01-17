local M = {}

M.setup = function()
    local langs = { "c3","c", "cmake", "cpp", "dart", "vim", "vimdoc", "query",
            "typescript", "zig", "go", "gomod", "javascript", "rust", "lua" }
    require('nvim-treesitter').setup()
    require('nvim-treesitter').install(langs):wait(3000000)
    vim.api.nvim_create_autocmd('FileType', {
      pattern = langs,
      callback = function()
        print("LOL!")
        vim.treesitter.start()
      end,
    })

    -- --setup nuru-treesitter
    -- local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
    -- parser_config.nuru = {
    --     install_info = {
    --         url = "/home/brian/Workspaces/nuru-lsp/nuru-tree-sitter/",
    --         files = { "src/parser.c" },
    --         branch = "dev",
    --         generate_requires_npm = false,
    --         requires_generate_from_grammar = false
    --     },
    --     file_type = "nr"
    -- }
end



return M
