local M = {};


M.setup = function ()
    -- Set ctrl-f for popping up searching on telescope
    vim.api.nvim_set_keymap('n','<C-f>','<cmd>Telescope find_files<CR>',
        {noremap=true})
    -- Set ctrl-b for showing buffers on telescope
    vim.api.nvim_set_keymap('n','<C-b>','<cmd>Telescope buffers<CR>',
        {noremap=true})
end

return M;
