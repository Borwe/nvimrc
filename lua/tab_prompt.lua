require("user_globals")
tab_select={}

function tab_select.selector()
    vim.cmd('normal :tabs')
    local tabNum=vim.fn.input("Select Tab Number: ")
    print("Moving to tab: "..tabNum)
    vim.cmd('normal :tabn '..tabNum)
end

nvim_create_command('Tab',"lua tab_select.selector()")

