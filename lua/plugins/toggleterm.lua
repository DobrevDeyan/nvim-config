return {
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    config = function()
      require("toggleterm").setup({
        size = function(term)
          if term.direction == "horizontal" then
            return 15
          elseif term.direction == "vertical" then
            return vim.o.columns * 0.4
          end
        end,
        open_mapping = [[<C-\>]],
        direction = "float",
        float_opts = {
          border = "rounded",
        },
        shade_terminals = false,
      })

      -- Claude Code terminal
      local Terminal = require("toggleterm.terminal").Terminal
      local claude = Terminal:new({
        cmd = "claude",
        direction = "float",
        float_opts = { border = "rounded" },
        hidden = true,
      })

      vim.keymap.set("n", "<leader>tc", function() claude:toggle() end, { desc = "Toggle Claude Code" })
      vim.keymap.set("n", "<leader>tf", "<cmd>ToggleTerm direction=float<cr>",      { desc = "Float terminal" })
      vim.keymap.set("n", "<leader>th", "<cmd>ToggleTerm direction=horizontal<cr>", { desc = "Horizontal terminal" })
      vim.keymap.set("n", "<leader>tv", "<cmd>ToggleTerm direction=vertical<cr>",   { desc = "Vertical terminal" })

      -- Exit terminal mode easily
      vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })
    end,
  },
}
