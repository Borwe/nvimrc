local M = {}

function M.setup()
    local isWin32 = vim.fn.has('win32') == 1 and true or false
    local opts = { noremap = true }
    local _, _, code = os.execute("zellij --version")
    if (code == 0) then
        local term = os.getenv("SHELL") or "bash"
        vim.api.nvim_set_keymap('n', 'sterm',
            '', {
                noremap = true,
                callback = function()
                    vim.fn.jobstart({ "zellij", "run", "-d", "down", "--", term })
                end
            })
        vim.api.nvim_set_keymap('n', 'term', '', {
            noremap = true,
            callback = function()
                vim.fn.jobstart({ "zellij", "run", "-f", "--", term })
            end
        })
        vim.api.nvim_set_keymap('n', 'vterm', '', {
            noremap = true,
            callback = function()
                vim.fn.jobstart({ "zellij", "run", "-d", "right", "--", term })
            end
        })
    else
        cmdLaunchFuncGenerator = function (pos, vert)
            cmd = {"bash"}
            vert = vert or false
            if isWin32 then
                cmd = {"powershell"}
            end
            return function ()
                buf = vim.api.nvim_create_buf(true, true)
                vim.api.nvim_set_current_buf(buf)
                if vert == true or pos ~= nil then
                    win = vim.api.nvim_open_win(buf, true, {
                        split = pos,
                        vertical = vert
                    })
                    vim.api.nvim_set_current_win(win)
                end
                vim.fn.termopen(cmd)
            end
        end
        vim.keymap.set('n', 'sterm', cmdLaunchFuncGenerator("below"), opts)
        vim.keymap.set('n', 'term', cmdLaunchFuncGenerator(), opts)
        vim.keymap.set('n', 'vterm', cmdLaunchFuncGenerator(nil, true), opts)
        vim.keymap.set('t', '<C-e>',
            '<C-\\><C-N>', opts)
    end
end

return M
