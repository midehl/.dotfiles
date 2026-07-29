return {
  {
    "tpope/vim-fugitive",
  },
  {
    "folke/snacks.nvim",
    opts = {
      -- full-screen lazygit (<leader>gg), matching herdr/tmux behavior
      lazygit = {
        win = { width = 0, height = 0 },
      },
    },
  },
}
