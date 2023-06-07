buf_sel={}

function buf_sel.buffer_select()
    vim.cmd("ls")
    bufNum=vim.fn.input("Select buffer number: ")
    print("")
    vim.cmd("buffer "..bufNum)
end

vim.api.nvim_create_user_command('Buff',
    buf_sel.buffer_select, {['bang']=true})
