
-- for creating commands! for lsp
nvim_create_command= function (command_name,command)
    vim.cmd('command! '..command_name..
        ' :'..command..'<CR>')
end
