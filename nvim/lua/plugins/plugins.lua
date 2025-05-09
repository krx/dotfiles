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
    "nvim-lspconfig",
    opts = {
      servers = {
        pyright = {
          capabilities = (function()
            local capabilities = vim.lsp.protocol.make_client_capabilities()
            capabilities.textDocument.publishDiagnostics.tagSupport.valueSet = { 2 }
            return capabilities
          end)(),
          settings = {
            python = {
              analysis = {
                useLibraryCodeForTypes = true,
                diagnosticSeverityOverrides = {
                  reportUnusedVariable = "warning", -- or anything
                },
                typeCheckingMode = "off",
              },
            },
          },
        },
        -- ruff_lsp = {
        --   on_attach = function(client, _)
        --     client.server_capabilities.hoverProvider = false
        --   end,
        -- },
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
  -- {
  --   "saghen/blink.compat",
  --   -- use the latest release, via version = '*', if you also use the latest release for blink.cmp
  --   version = "*",
  --   -- lazy.nvim will automatically load the plugin when it's required by blink.cmp
  --   lazy = true,
  --   -- make sure to set opts so that lazy.nvim calls blink.compat's setup
  --   opts = {
  --     impersonate_nvim_cmp = true,
  --   },
  -- },
  -- {
  --   "saghen/blink.cmp",
  --   version = "0.*",
  --   enabled = true,
  --   sources = {
  --     compat = { "jupyter" },
  --   },
  -- },
  -- {
  --   "lkhphuc/jupyter-kernel.nvim",
  --   opts = {},
  -- },
}
