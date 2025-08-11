local cmp = require('cmp')
--require('codeium').setup({})

M.setup = function()
    cmp.setup({
        snippet = {
            expand = function(args)
                vim.fn["UltiSnips#Anon"](args.body)
            end
        },
        mapping = cmp.mapping.preset.insert({
            ['<C-b>'] = cmp.mapping.scroll_docs(-4),
            ['<C-f>'] = cmp.mapping.scroll_docs(4),
            ['<C-Space>'] = cmp.mapping.complete(),
            ['<C-x><C-o>'] = cmp.mapping.complete(),
            ['<C-e>'] = cmp.mapping.close(),
            ['<CR>'] = cmp.mapping.confirm({ select = true }),
            ['<Tab>'] = cmp.mapping(cmp.mapping.select_next_item(), { 'i', 's' }),
            ['<S-Tab>'] = cmp.mapping(cmp.mapping.select_prev_item(), { 'i', 's' }),
            ['<C-n>'] = cmp.mapping(cmp.mapping.select_next_item(), { 'i', 's' }),
            ['<C-p>'] = cmp.mapping(cmp.mapping.select_prev_item(), { 'i', 's' })
        }),
        window = {
            completion = cmp.config.window.bordered(),
            documentation = cmp.config.window.bordered()
        },
        sources = {
            { name = 'nvim_lsp' },

            -- For ultisnips user.
            { name = 'ultisnips' },

            { name = 'buffer' },

            -- For codeium
            --{ name = 'codeium' },
        }
    })
    -- add for lsp support
    require('lsp_pers_config')
end

-- function that prints hello world

return M
