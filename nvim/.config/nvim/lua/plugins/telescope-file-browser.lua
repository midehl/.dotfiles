return {
  "nvim-telescope/telescope-file-browser.nvim",
  dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
  keys = {
    {
      "<leader>sB",
      ":Telescope file_browser path=%:p:h=%:p:<cr>",
      desc = "Browse Files with Telescope",
    },
  },
  config = function()
    require("telescope").load_extension("file_browser")
  end,
}
