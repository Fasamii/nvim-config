vim.lsp.config.rust_analyzer = {
  settings = {
    ['rust-analyzer'] = {
      check = {
        command = "clippy",
        extraArgs = { "--all-targets", "--all-features" }
      },
      diagnostics = {
        enable = true,
        enableExperimental = true,
      },
      cargo = {
        allFeatures = true,
      },
      procMacro = {
        enable = true,
      },
    }
  },
  on_attach = function(client, bufnr)
    if client.supports_method("textDocument/inlayHint") then
      vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
    end
  end,
};
