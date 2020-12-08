local api=vim.api

ultiSnips={} -- For holding ultisnips functions

local dictSize=function (dict)
    local count=0
    for _ in pairs(dict) do count = count +1 end

    return count
end

function ultiSnips.showUltiSnipsFunction(findstart,base)
    vim.cmd('echomasdsadasdadasd "FUCCCCCCKKKKKKKKKKKKKKKK"')
    --  Check if UltiSnips has CurrentScope
    if dictSize(api.
        nvim_exec('UltiSnips#SnippetsInCurrentScope(1)',
        true))<0 then
        return ''
    end

    if findstart==1 then
        local start=api.nvim_exec('col(\'.\')')
        return start
    else
        local return_values={}
        local ulti_dict_info=
            api.nvim_get_var('current_ulti_dict_info')

        vim.cmd('echom "VALUE: '..ulti_dict_info'"')

        return return_values
    end
end

function ultiSnips.afterCompletion()
    vim.cmd('augroup UltiPredictAdd')
    vim.cmd('autocmd!')
    vim.cmd('autocmd CompleteDonePre <buffer> '..
        ':call UltiSnips#ExpandSnippet() | '..
        'autocmd! UltiPredictAdd')
    vim.cmd('augroup END')
end

showUltiSnips=function ()
    api.nvim_buf_set_option(0,'omnifunc',
        'v:lua.ultiSnips.showUltiSnipsFunction()')

    vim.cmd('call feedkeys("<C-x><C-o>")')

    ultiSnips.afterCompletion()
end
