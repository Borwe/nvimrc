require("user_globals")
buf_sel={}

function buf_sel.buffer_select()
    vim.cmd("ls")
    bufNum=vim.fn.input("Select buffer number: ")
    print("")
    vim.cmd("buffer "..bufNum)
end

nvim_create_command('Buff',"lua buf_sel.buffer_select()")
