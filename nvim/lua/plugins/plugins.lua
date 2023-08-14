return {
  { "lambdalisue/suda.vim" },
  { "HiPhish/rainbow-delimiters.nvim" },
  {
    "echasnovski/mini.indentscope",
    opts = {
      draw = {
        animation = function(s, n)
          return 10
        end,
      },
    },
  },
  {
    "akinsho/bufferline.nvim",
    opts = {
      options = {
        numbers = function(o)
          return o.raise(o.ordinal)
        end,
      },
    },
  },
}
