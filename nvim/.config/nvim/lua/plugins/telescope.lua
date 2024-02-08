return {
	{
		"nvim-telescope/telescope.nvim",
		branch = "0.1.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			{
				"nvim-telescope/telescope-fzf-native.nvim",
				build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
				cond = vim.fn.executable("cmake") == 1,
			},
		},
		config = function()
			local actions = require("telescope.actions")

			require("telescope").setup({
				defaults = {
					mappings = {
						i = {
							["<C-k>"] = actions.move_selection_previous,
							["<C-j>"] = actions.move_selection_next,
							["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
							["<C-x>"] = actions.delete_buffer,
						},
					},
					file_ignore_patterns = {
						"node_modules",
						"yarn.lock",
						".git",
						".sl",
						"_build",
						".next",
					},
					hidden = true,
				},
			})

			-- Live grep in git root
			local function find_git_root()
				local current_file = vim.api.nvim_buf_get_name(0)
				local current_dir
				local cwd = vim.fn.getcwd()
				-- if the buffer is not associated with a file, return nil
				if current_file == "" then
					current_dir = cwd
				else
					-- extract the directory from the current file's path
					current_dir = vim.fn.fnamemodify(current_file, ":h")
				end

				-- find git root
				local git_root =
					vim.fn.systemlist("git -C " .. vim.fn.escape(current_dir, " ") .. " rev-parse --show-toplevel")[1]
				if vim.v.shell_error ~= 0 then
					print("Not a git repository. Searching on current working directory.")
					return cwd
				end
				return git_root
			end

			local function live_grep_git_root()
				local git_root = find_git_root()
				if git_root then
					require("telescope.builtin").live_grep({
						search_dirs = { git_root },
					})
				end
			end

			vim.api.nvim_create_user_command("LiveGrepGitRoot", live_grep_git_root, {})

			-- Enable telescope fzf native, if installed
			pcall(require("telescope").load_extension, "fzf")
		end,
	},
}
