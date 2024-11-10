return {
  {
    'hrsh7th/nvim-cmp',
    event = { 'BufReadPost', 'BufNewFile' },
    dependencies = {
      -- Snippet Engine & its associated nvim-cmp source
      'L3MON4D3/LuaSnip',
      'saadparwaiz1/cmp_luasnip',

      -- Adds LSP completion capabilities
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-path',

      -- Add buffer completion words to same menu
      'hrsh7th/cmp-buffer',

      -- Add Vscode like pictograms
      'onsails/lspkind.nvim',

      -- autoclose and auto rename html tags
      'windwp/nvim-ts-autotag',

      -- autopairing
      'windwp/nvim-autopairs',


      -- Adds a number of user-friendly snippets
      'rafamadriz/friendly-snippets',
    },
    config = function()
      local cmp_autopairs = require('nvim-autopairs.completion.cmp')
      local cmp = require('cmp')
      local luasnip = require('luasnip')
      local lspkind = require('lspkind')

      require('nvim-autopairs').setup()

      -- integrate nvim-autopairs with cmp
      cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())

      -- load snippets
      require('luasnip.loaders.from_vscode').lazy_load()

      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },
        mapping = cmp.mapping.preset.insert({
          ['<C-j>'] = cmp.mapping.select_next_item(), -- next item
          ['<C-k>'] = cmp.mapping.select_prev_item(), -- prev item
          ['<Tab>'] = cmp.mapping(function(fallback)  -- tab to next
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_locally_jumpable() then
              luasnip.expand_or_jump()
            else
              fallback()
            end
          end, { 'i', 's' }),
          ['<S-Tab>'] = cmp.mapping(function(fallback) -- shift-tab to prev
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.locally_jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { 'i', 's' }),
          -- scroll up and down previous
          ['<C-d>'] = cmp.mapping.scroll_docs(-4),
          ['<C-u>'] = cmp.mapping.scroll_docs(4),
          -- show completion suggestions
          ['<C-Space>'] = cmp.mapping.complete({}),
          -- close completion window
          ['<C-c>'] = cmp.mapping.abort(),
          -- select suggestion
          ['<CR>'] = cmp.mapping.confirm {
            behavior = cmp.ConfirmBehaviorReplace,
            select = true,
          },
        }),
        -- Sources for autocompletion
        sources = cmp.config.sources({
          { name = 'nvim_lsp' },                    -- LSP
          { name = 'buffer',  max_item_count = 5 }, -- text within current buffers
          { name = 'path',    max_item_count = 3 }, -- file system paths
          { name = 'luasnip', max_item_count = 3 }, -- snippets
          { name = 'coopilot' },                    -- copilot suggestions
        }),
        -- pictogram icons from onsails/lspkind
        formatting = {
          expandable_indicator = true,
          format = lspkind.cmp_format({
            modoe = 'symbol_text',
            madwidth = 50,
            ellipsis_char = '...',
            symbol_map = {
              Copilot = '',
            },
          }),
        },
        experimental = {
          ghost_text = true,
        },
      })
    end,
  },
}
