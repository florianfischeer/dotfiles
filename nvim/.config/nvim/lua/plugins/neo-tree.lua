return {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    },
    lazy = false, -- neo-tree will lazily load itself
    ---@module "neo-tree"
    ---@type neotree.Config?
    opts = {
      -- fill any relevant options here
    },
  config = function()
    vim.keymap.set('n', '<C-p>', ":Neotree filesystem reveal left<CR>", { desc = 'Shows the file tree on the left of the screen' })
    vim.keymap.set('n', '<C-t>', ":Neotree toggle<CR>", { desc = 'Toggels the filesystem on the left of the screen' })
  end
}
