return {
  {
    'williamboman/mason.nvim',
    dependencies = {
      'williamboman/mason-lspconfig.nvim',
      'neovim/nvim-lspconfig',
    },
    config = function()
      require('mason').setup({
        install_root_dir = vim.fn.has('win32') == 1 and 'C:/m' or nil,
      })
      require('mason-lspconfig').setup({
        ensure_installed = {
          "lua_ls",
          "intelephense",
          "ts_ls",
          "eslint",
          "pyright",
        },
        handlers = {
          -- this first function is the "default handler"
          -- it applies to every language server without a custom handler
          function(server_name)
            require('lspconfig')[server_name].setup({})
          end,
        },
      })
    end,
  },
}
