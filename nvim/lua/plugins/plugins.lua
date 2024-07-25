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
}
