require("user_globals")
local api=vim.api

ultiSnips={} -- For holding ultisnips functions


nvim_create_command('UltiSnipsPopUp',"lua ultiSnips.showUltiSnips()")

local dictSize=function (dict)
    local count=0
    for _ in pairs(dict) do count = count +1 end

    return count
end

function ultiSnips.showUltiSnipsFunction(findstart,base)
    --  Check if UltiSnips has CurrentScope
    if dictSize(
        api.
        nvim_eval('UltiSnips#SnippetsInCurrentScope(1)'))<0
        then
        return ''
    end

    if findstart==1 then
        local line=vim.fn.getline('.')
        local start=vim.fn.col('.')-1
        while (start > 0  and
          string.match(string.sub(line,start-2,start-1),"[a-zA-Z]"))
        do
            start=start-1
        end
        return start-1
    else
        local return_values={}
        local ulti_dict_info=
            api.nvim_eval('g:current_ulti_dict_info')

        for key, value in pairs(ulti_dict_info) do
            local n={abbr=key,word=key,
                menu='[snip]'..value["description"]
            }
            table.insert(return_values,n)
        end

        print(vim.inspect(return_values))
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


function ultiSnips.showUltiSnips()
    api.nvim_buf_set_option(0,'omnifunc',
         'v:lua.ultiSnips.showUltiSnipsFunction')

    api.nvim_feedkeys(api.
        nvim_replace_termcodes("<C-x><C-o>",true,false,true)
        ,'i',true)

    ultiSnips.afterCompletion()
end
