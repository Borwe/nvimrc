-- Configuration
local M = {}
M.setup = function ()
  require('code_runner').setup ({
    term = {
      position = "belowright",
      size = 20
    },
    filetype_path = vim.fn.stdpath("config"):gsub("\\","/").."/codder.json",
  })
end

return M
