M = {}

M.setup = function ()
    vim.g.neovide_cursor_vfx_mode="railgun"
    vim.g.remember_window_size = true
    vim.o.guifont = "Consolas:h11"
end

return M;
