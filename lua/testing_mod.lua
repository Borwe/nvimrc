local M = {}

function M.test_current_file()
    -- Get current file with linux type directory structure
    vim.cmd('let g:test_mod_current_file=expand("%:p")')
    local file = vim.g.test_mod_current_file
    local file_to_use = ""
    for c in string.gmatch(file,".") do
        if c == '\\' then
            c = "/"
        end
        file_to_use = file_to_use .. c
    end
    vim.cmd("unlet g:test_mod_current_file")
    -- Create a new buffer
    vim.cmd("new")
    -- Call the testing command on that file using plenary.test_harness
    vim.fn.termopen('nvim --headless -c "PlenaryBustedFile '.. file_to_use ..'"')
end

return M
