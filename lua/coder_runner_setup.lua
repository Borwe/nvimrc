-- Configuration
local M = {}
M.setup = function ()
  require('code_runner').setup ({
    term = {
      position = "belowright",
      size = 10
    },
    filetype = {
      map = "<Space>b",
      json_path =  vim.fn.stdpath("config"):gsub("\\","/").."/codder.json",
    },
    project_context = {
      map = "<Space>b",
      json_path = vim.fn.stdpath("config"):gsub("\\","/").."/codder.json",
    },
  })
end

return M
