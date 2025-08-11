M  = {}

function M.bootstrap(packages)
	local install_path = vim.fn.stdpath('data') .. '/site/pack/paqs/start/paq-nvim'

	if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
		vim.fn.system({'git', 'clone', '--depth=1', 'https://github.com/savq/paq-nvim.git', install_path})
	end
	vim.cmd.packadd("paq-nvim")


	local paq = require('paq')
	paq(packages)
	vim.cmd.PaqInstall()
end

return M
