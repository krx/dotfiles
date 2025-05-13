return {
  { "lambdalisue/suda.vim" },
  { "HiPhish/rainbow-delimiters.nvim" },
  {
    "echasnovski/mini.indentscope",
    opts = {
      draw = {
        animation = function(_, _)
          return 10
        end,
      },
    },
  },
  {
    "akinsho/bufferline.nvim",
    opts = {
      options = {
        style_preset = require("bufferline").style_preset.no_italic,
        separator_style = "slant",
        numbers = function(o)
          return o.raise(o.ordinal)
        end,
      },
    },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = { ensure_installed = { "kdl" } },
  },
  {
    "MeanderingProgrammer/render-markdown.nvim",
    opts = {
      completions = {
        lsp = {
          enabled = true,
        },
      },
    },
  },
  {
    "lkhphuc/jupyter-kernel.nvim",
    opts = {},
  },
  {
    "hrsh7th/nvim-cmp",
    opts = function(_, opts)
      table.insert(opts.sources, { name = "jupyter" })
    end,
  },
}
