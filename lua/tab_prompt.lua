tab_select={}

function tab_select.selector()
    vim.cmd('normal :tabs')
    local tabNum=vim.fn.input("Select Tab Number: ")
    print("Moving to tab: "..tabNum)
    vim.cmd('normal :tabn '..tabNum)
end

vim.api.nvim_create_user_command('Tab',
    tab_select.selector, {['bang']=true})

