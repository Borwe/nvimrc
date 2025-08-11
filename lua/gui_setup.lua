M = {}

M.setup = function ()
    vim.g.neovide_cursor_vfx_mode="railgun"
    vim.g.remember_window_size = true
    --vim.g.neovide_fullscreen = true
    vim.g.neovide_cursor_animation_length = 0.05
    --vim.o.guifont = "Intel One Mono:h12"
end

return M;
