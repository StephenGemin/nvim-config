# nvim-config

Personal Neovim configuration — self-manage

## Install

```sh
git clone https://github.com/StephenGemin/nvim-config.git ~/.config/nvim
```

## Requirements

- Neovim 0.12+
- `git`
- [Nerd Font](https://www.nerdfonts.com/) (for icons)
- LSP servers and formatters install automatically via `mason.nvim` on first launch, but the
  runtimes they're built on need to already be on `$PATH`:
  - Node.js + npm — html-lsp, css-lsp, typescript-language-server, json-lsp,
    yaml-language-server, bash-language-server, pyright, prettier
  - Go — gopls, gofumpt, goimports
  - Python 3 + pip — ruff
  - .NET SDK — csharpier, and to run omnisharp
  - `rustfmt` has no Mason package at all — install via `rustup component add rustfmt`

