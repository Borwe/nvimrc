
M = {}
--- @param opt? string
M.setup = function (opt)
    if opt then
        require("dotenv").setup({
          file_name =  opt
        })
    end
    require('avante').setup({
        provider = "gemini",
        providers = {
            gemini = {
                model = "gemini-2.0-flash"
            }
        }
    })
end

return M
