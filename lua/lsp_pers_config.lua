local lspconfig = require('lspconfig')
local lspconfig_configurer = require('lspconfig.configs')

-- Configure to work with Ultisnips templates
vim.g.completion_enable_snippet = 'UltiSnips'

-- Configure for buffers complete
vim.g.completion_chain_complete_list = {
    { complete_items = { 'lsp' } },
    { complete_items = { 'buffers' } },
    { mode = { '<c-p>' } },
    { mode = { '<c-n>' } }
}

local map = function(type, key, value)
    vim.api.nvim_buf_set_keymap(0, type, key, value, { noremap = true, silent = true });
end

-- for renaming using lsp
vim.api.nvim_create_user_command('LspRename', vim.lsp.buf.rename, { ['bang'] = true })

-- Handle mapping and execution once LSP is attatched
local custom_on_attach_lsp = function(client)
    print('LSP ' .. client.name .. ' started')

    -- Set key mappings
    map('n', '<Space>n', '<cmd>lua vim.lsp.buf.definition()<CR>')
    --map('n', '<Space>k', '<cmd>lua require("cmp").mapping.open_docs()<CR>')
    map('n', '<Space>k', '<cmd>lua vim.lsp.buf.hover({border = "rounded"})<CR>')
    map('n', '<Space>a', '<cmd>lua vim.lsp.buf.hover();vim.lsp.buf.hover()<CR>')
    map('n', '<Space>i', '<cmd>lua vim.lsp.buf.implementation()<CR>')
    map('n', '<Space>s', '<cmd>lua vim.lsp.buf.signature_help()<CR>')
    map('n', '<Space>d', '<cmd>lua vim.lsp.buf.type_definition()<CR>')
    map('n', '<Space>r', '<cmd>lua vim.lsp.buf.references()<CR>')
    map('n', '<Space>q', '<cmd>lua vim.lsp.buf.document_symbol()<CR>')
    map('n', '<Space>w', '<cmd>lua vim.lsp.buf.format()<CR>')
    map('n', '<Space>m', '<cmd>lua vim.lsp.buf.declaration()<CR>')
    map('n', '<Space>x', '<cmd>lua vim.diagnostic.open_float()<CR>')
    map('n', '<Space>f', '<cmd>lua vim.lsp.buf.code_action()<CR>')

    fmt_augroup = vim.api.nvim_create_augroup("lsp_pers_config_fmt", {})
    vim.api.nvim_create_autocmd({ 'BufWritePost' }, {
        pattern = { '*.rs' },
        group = fmt_augroup,
        callback = function(args)

            if args.file:find("rs")~= nil then
                cmd = ("rustfmt %s"):format(vim.api.nvim_buf_get_name(args.buf))
                vim.fn.jobstart(cmd, {on_exit = function (id,code,_evnt)
                    vim.api.nvim_buf_call(args.buf, function ()
                        vim.cmd("edit")
                    end)
                end})
            end
        end
    })
end


-- setup nuru-lsp
lspconfig_configurer["nuru-lsp"] = {
    default_config = {
        cmd = { 'C:/Users/Brian/Workspaces/nuru-lsp/nuru-lsp.exe', 'C:/Users/Brian/Workspaces/nuru-lsp/lsp.log' },
        filetypes = { 'sr', 'nroff' },
        root_dir = require('lspconfig.util').find_git_ancestor,
        single_file_support = true,
    },
    docs = {
        description = [[
https://github.com/Borwe/nuru-lsp

Nuru Unofficial Language Server
        ]],
        default_config = {
            root_dir = lspconfig.util.find_git_ancestor,
        },
    },
}


vim.lsp.config.c3_lsp = {
    cmd = {'/home/brian/.local/bin/c3lsp'},
    filetypes = { 'c3', 'c3i'},
    root_markers = { 'project.json', 'manifest.json', '.git' },
}


require('mason-lspconfig').setup {
    ensure_installed = { "lua_ls", "rust_analyzer", "zls", "ts_ls" },
}

vim.lsp.config("c3_lsp", {
    capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol
        .make_client_capabilities()),
    on_attach = custom_on_attach_lsp
})
vim.lsp.enable('c3_lsp',true)

vim.lsp.config("nuru-lsp", {
    capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol
        .make_client_capabilities()),
    on_attach = custom_on_attach_lsp
})


vim.lsp.config('*', {
    capabilities = require('cmp_nvim_lsp')
        .default_capabilities(vim.lsp.protocol
            .make_client_capabilities()),
    on_attach = custom_on_attach_lsp
})

vim.lsp.config('clangd', {
    capabilities = require('cmp_nvim_lsp')
        .default_capabilities(vim.lsp.protocol
            .make_client_capabilities()),
    on_attach = custom_on_attach_lsp
})


vim.lsp.config('dartls', {
    capabilities = require('cmp_nvim_lsp')
        .default_capabilities(vim.lsp.protocol
            .make_client_capabilities()),
    on_attach = custom_on_attach_lsp
})

vim.lsp.config('rust_analyzer', {
    capabilities = require('cmp_nvim_lsp')
        .default_capabilities(vim.lsp.protocol
            .make_client_capabilities()),
    on_attach = custom_on_attach_lsp
})

vim.lsp.config('lua_ls', {
    capabilities = require('cmp_nvim_lsp').
    default_capabilities(vim.lsp.protocol.make_client_capabilities()),
    on_attach = custom_on_attach_lsp,
    settings = {
        Lua = {
            runtime = {
                version = "LuaJIT",
                path = vim.split(package.path, ';'),
            },
            workspace = {
                library = {
                    [vim.fn.expand("$VIMRUNTIME/lua")] = true,
                    [vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
                },
            },
            diagnostics = {
                globals = { "vim" },
                disable = { "lowercase-global", "unused-function" },
            },
        },
    },
})
