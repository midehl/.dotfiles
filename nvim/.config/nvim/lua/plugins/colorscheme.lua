return {
  {
    "catppuccin/nvim",
    config = function()
      require("catppuccin").setup({
        integrations = {
          mini = true,
          cmp = true,
          gitsigns = true,
          harpoon = true,
          illuminate = true,
          indent_blankline = { enabled = true },
          --[[ indent_blankline = {
	           enabled = false,
	           scope_color = "sapphire",
	           colored_indent_levels = false,
	         }, ]]
          mason = true,
          native_lsp = {
            enabled = true,
            underlines = {
              errors = { "undercurl" },
              hints = { "undercurl" },
              warnings = { "undercurl" },
              information = { "undercurl" },
            },
          },
          notify = true,
          nvimtree = true,
          neotree = true,
          symbols_outline = true,
          telescope = true,
          treesitter = true,
          treesitter_context = true,
          which_key = true,
        },
      })

      vim.cmd.colorscheme("catppuccin-mocha")

      -- set scope animation to use catppuccin-mocha colors
      vim.api.nvim_set_hl(0, "MiniIndentscopeSymbol", { fg = "#f5c2e7", bg = "NONE", italic = true })

      -- Hide all semantic highlights until upstream issues are resolved (https://github.com/catppuccin/nvim/issues/480)
      for _, group in ipairs(vim.fn.getcompletion("@lsp", "highlight")) do
        vim.api.nvim_set_hl(0, group, {})
      end
    end,
  },
}
