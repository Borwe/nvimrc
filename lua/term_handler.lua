local M = {}



M.setup = function()
    local isWin32=vim.fn.has('win32')==1 and true or false
    local opts = {noremap = true}
    local zellijExist = os.execute("zellij --version") or false
    if(zellijExist) then
          local term = os.getenv("SHELL") or "bash"
          vim.api.nvim_set_keymap('n','sterm',
              '',{
                  noremap = true,
                  callback = function ()
                      vim.fn.jobstart({"zellij","run", "-d", "down","--", term})
                  end
          })
          vim.api.nvim_set_keymap('n','term','',{
              noremap = true,
              callback = function ()
                  vim.fn.jobstart({"zellij","run","-f","--", term})
              end
          })
          vim.api.nvim_set_keymap('n','vterm', '',{
                  noremap = true,
                  callback = function ()
                      vim.fn.jobstart({"zellij","run", "-d", "right","--", term})
                  end
          })
    else
        if isWin32 then
          vim.api.nvim_set_keymap('n','sterm',
              ':belowright split term://powershell<CR>',opts)
          vim.api.nvim_set_keymap('n','term',
              ':edit term://powershell<CR>',opts)
          vim.api.nvim_set_keymap('n','vterm',
              ':vsplit term://powershell<CR>',opts)
        else
          vim.api.nvim_set_keymap('n','term',
              ':edit term://bash<CR>',opts)
          vim.api.nvim_set_keymap('n','sterm',
              ':belowright split term://bash<CR>',opts)
          vim.api.nvim_set_keymap('n','vterm',
              ':vsplit term://bash<CR>',opts)
          --for exiting insert mode in terminal
          vim.api.nvim_set_keymap('t','<C-e>',
              '<C-\\><C-N>',opts)
        end
    end
end

return M
