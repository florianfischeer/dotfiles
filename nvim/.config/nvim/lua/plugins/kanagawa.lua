return {
  "rebelot/kanagawa.nvim",
  priority = 800, -- damit es früh geladen wird
  lazy = false,    -- direkt beim Start laden
  config = function()
    require('kanagawa').setup({
      compile = false,
      undercurl = true,
      commentStyle = { italic = true },
      functionStyle = {},
      keywordStyle = { italic = true },
      statementStyle = { bold = true },
      typeStyle = {},
      transparent = false,
      dimInactive = false,
      terminalColors = true,
      colors = {
        palette = {},
        theme = { wave = {}, lotus = {}, dragon = {}, all = {} },
      },
      overrides = function(colors)
        return {}
      end,
      theme = "wave",
      background = {
        dark = "wave",
        light = "lotus"
      },
    })

    -- Farbschema setzen
    vim.cmd("colorscheme kanagawa-dragon")
  end,
}

