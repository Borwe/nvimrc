require("user_globals")
local lspconfig = require('lspconfig')

-- Configure to work with Ultisnips templates
vim.g.completion_enable_snippet='UltiSnips'


-- Configure for buffers complete
vim.g.completion_chain_complete_list={
    {complete_items= {'lsp'}},
    {complete_items = {'buffers'}},
    {mode = { '<c-p>' }},
    {mode = { '<c-n>' }}
}

local map= function (type,key,value)
    vim.api.nvim_buf_set_keymap(0,type,key,value,{noremap=true, silent=true});
end

-- for restarting all lsp servers
lspes_restart_all=function ()
    vim.lsp.stop_client(vim.lsp.get_active_clients())
    vim.cmd('edit')
    vim.cmd('edit')
end
nvim_create_command('LspRestart',"lua lspes_restart_all()")

-- for checking status of lsp servers per buffer
lspes_buffer_running=function ()
    local clientMaps=vim.lsp.buf_get_clients(0);

    vim.api.nvim_command('echom "current running lsp servers on buffer:\n"')

    for k, v in pairs(clientMaps) do
        vim.api.nvim_command('echom "ID: '..k..
            ' CLIENT: '..tostring(v.name)..'"')
    end
end
nvim_create_command('LspClientBuffer',"lua lspes_buffer_running()")

-- for checking status of lsp-servers for current nvim instance
lspes_running=function ()
    local clientMaps=vim.lsp.get_active_clients();

    vim.api.nvim_command('echom "current running lsp servers:\n"')

    for k, v in pairs(clientMaps) do
        vim.api.nvim_command('echom "ID: '..k..' CLIENT: '..tostring(v.name)..'"')
    end
end
nvim_create_command('LspClientsAll',"lua lspes_running()")


-- for renaming using lsp
nvim_create_command('LspRename','lua vim.lsp.buf.rename()')



-- Handle mapping and execution once LSP is attatched
local custom_on_attach_lsp=function (client)
    print('LSP '..client.name..' started')

    -- Set key mappings
    map('n','<Space>n','<cmd>lua vim.lsp.buf.definition()<CR>')
    map('n','<Space>k','<cmd>lua <CR>')
    map('n','<Space>z','<cmd>lua vim.lsp.buf.hover()<CR>')
    map('n','<Space>a','<cmd>lua vim.lsp.buf.hover();vim.lsp.buf.hover()<CR>')
    map('n','<Space>i','<cmd>lua vim.lsp.buf.implementation()<CR>')
    map('n','<Space>s','<cmd>lua vim.lsp.buf.signature_help()<CR>')
    map('n','<Space>d','<cmd>lua vim.lsp.buf.type_definition()<CR>')
    map('n','<Space>r','<cmd>lua vim.lsp.buf.references()<CR>')
    map('n','<Space>q','<cmd>lua vim.lsp.buf.document_symbol()<CR>')
    map('n','<Space>w','<cmd>lua vim.lsp.buf.workspace_symbol()<CR>')
    map('n','<Space>m','<cmd>lua vim.lsp.buf.declaration()<CR>')
    map('n','<Space>x','<cmd>lua vim.diagnostic.open_float()<CR>')
    map('n','<Space>f','<cmd>lua vim.lsp.buf.code_action()<CR>')
end

require('mason-lspconfig').setup {
    ensure_installed = {"lua_ls"},
    handlers = {
        function (server_name)
            lspconfig[server_name].setup {
                capabilities = require('cmp_nvim_lsp')
                .default_capabilities(vim.lsp.protocol
                    .make_client_capabilities()),
                on_attach=custom_on_attach_lsp
            }
        end,
        ["lua_ls"] = function()
            lspconfig.lua_ls.setup {
                capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol
                    .make_client_capabilities()),
                on_attach=custom_on_attach_lsp,
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
                            globals = {"vim"},
                            disable = {"lowercase-global", "unused-function"},
                        },
                    },
                },
            }
        end
    }
}
