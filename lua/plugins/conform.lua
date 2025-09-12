return {
  "stevearc/conform.nvim",
  optional = true,
  opts = {
    formatters_by_ft = {
      javascript = { "prettier" },
      typescript = { "prettier" },
      javascriptreact = { "prettier" },
      typescriptreact = { "prettier" },
      vue = { "prettier" },
      json = { "prettier" },
      yaml = { "prettier" },
      markdown = { "prettier" },
      html = { "prettier" },
      css = { "prettier" },
      scss = { "prettier" },
    },
    formatters = {
      prettier = {
        command = vim.fn.stdpath("data") .. "/mason/bin/prettier",
      },
    },
    format_on_save = {
      timeout_ms = 500,
      lsp_fallback = false,
    },
  },
}
