return {
  -- LSP keymaps
  {
    "neovim/nvim-lspconfig",
    opts = function()
      local keys = require("lazyvim.plugins.lsp.keymaps").get()
      keys[#keys + 1] = { "<leader>d", "<cmd>lua vim.diagnostic.open_float()<CR>", desc = "Open Diagnostic Float" }
    end,
  },
}
