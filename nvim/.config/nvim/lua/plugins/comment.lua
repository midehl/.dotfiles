return {
  {
    'numToStr/Comment.nvim',
    event = { 'BufEnter' },
    dependencies = {
      -- Context aware Comments for multi-language files
      'JoosepAlviste/nvim-ts-context-commentstring',
      config = function()
        --@diagnostic disable-next-line: missing-fields
        require('ts_context_commentstring').setup({
          enable_autocmd = false,
        })
      end,
    },
    config = function()
      -- Comment configuration object _can_ take a partial and is merged in
      ---@diagnostic disable-next-line: missing-fields
      require('Comment').setup({
        pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook(),
      })

      -- For adding unsupported filetypes + languuages, see
      -- https://github.com/numToStr/Comment.nvim?tab=readme-ov-file#%EF%B8%8F-filetypes--languages
    end,
  },
}
