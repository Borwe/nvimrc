M  = {}

function M.setup()
	local install_path = vim.fn.stdpath('data') .. '/site/pack/paqs/start/paq-nvim'

	if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
		vim.fn.system({'git', 'clone', 'https://github.com/borwe/paq-nvim.git', install_path})
		vim.fn.system('cd '..install_path..' && git checkout depth-feature')
	end
end

return M
