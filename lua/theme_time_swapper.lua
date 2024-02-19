local M = {}

M.setup = function (darktheme, lightTheme)
    vim.api.nvim_set_var("dusk_til_dawn_dark_theme", darktheme)
    vim.api.nvim_set_var("dusk_til_dawn_light_theme", lightTheme)
    require('Dusk-til-Dawn').timeMan()()
end

return M
