require("user.options")
require("user.lazy")
require("user.keymaps")
require("user.highlight_yank")
require("user.format_on_save")
require("user.toggle_eslint")
require("user.edit_text")

-- set this env variable to use a specifc python interpreter before starting nvim
if vim.fn.getenv("NVIM_PYTHON") ~= vim.NIL then
	vim.g.python3_host_prog = vim.fn.getenv("NVIM_PYTHON")
end
