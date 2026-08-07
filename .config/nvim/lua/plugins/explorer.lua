return {
  -- show hidden/dotfiles by default in the file explorer
  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = {
      filesystem = {
        filtered_items = {
          visible = true,
          hide_dotfiles = false,
          hide_gitignored = false,
        },
      },
    },
  },
  {
    "folke/snacks.nvim",
    opts = {
      picker = {
        sources = {
          explorer = { hidden = true, ignored = true },
        },
        win = {
          -- KDE grabs plain Alt+H (desktop left) and Alt+M (maximize window),
          -- so the snacks defaults <a-h>/<a-m> never reach nvim
          input = {
            keys = {
              ["<a-.>"] = { "toggle_hidden", mode = { "i", "n" } },
              ["<a-z>"] = { "toggle_maximize", mode = { "i", "n" } },
            },
          },
          list = {
            keys = {
              ["<a-.>"] = "toggle_hidden",
              ["<a-z>"] = "toggle_maximize",
            },
          },
        },
      },
    },
  },
}
