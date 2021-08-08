
-- for creating commands! for lsp
nvim_create_command= function (command_name,command)
    vim.cmd('command! '..command_name..
        ' :'..command..'<CR>')
end

--- Get the directory where neovim was git-pasted
function neovim_git_location()
    if vim.fn.has("win32") == 1 then
        return "D:/Brian/Git-Repos/neovim/"
    else
        -- TODO not implemented yet
    end
end
