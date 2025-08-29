# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with
code in this repository.

## Overview

This is a Neovim configuration based on kickstart.nvim - a well-documented,
modular starting point for Neovim configurations. It focuses on being readable,
educational, and easily customizable.

## Architecture

### Core Structure

- **`init.lua`**: Main configuration file containing all core settings,
  keymaps, and plugin definitions
- **`lua/kickstart/plugins/`**: Modular plugin configurations (lint.lua,
  neo-tree.lua, etc.)
- **`lua/custom/plugins/`**: Directory for user custom plugins (currently
  unused)
- **`lazy-lock.json`**: Plugin version lockfile managed by Lazy.nvim

### Plugin Management

Uses Lazy.nvim as the plugin manager. All plugins are defined in `init.lua`
with their configurations inline or in separate files under
`lua/kickstart/plugins/`.

### Key Customizations From Default Kickstart

- **Leader keys**: Primary leader is `,` (comma), local leader is `<space>`
- **Theme**: Gruvbox theme configured with light background and hard contrast
- **Statusline**: Mini.statusline with git section disabled
- **File tree**: Neo-tree accessible via `\` key
- **LSP servers**: Configured for Go (gopls), TypeScript/JavaScript (ts_ls,
  eslint), and Lua (lua_ls)
- **Formatting**: Conform.nvim with Prettier for JavaScript and Stylua for Lua

## Common Development Tasks

### Plugin Management

- **View plugins**: `:Lazy`
- **Update plugins**: `:Lazy update`
- **Plugin status**: `:Lazy status`

### LSP and Development

- **Check LSP status**: `:LspInfo`
- **Install language servers**: `:Mason` (opens Mason installer UI)
- **Format code**: `<leader>f` (comma + f)
- **Code actions**: `<leader>ca`
- **Rename symbol**: `<leader>rn`

### File Navigation

- **File finder**: `<leader>sf` (search files)
- **Live grep**: `<leader>sg` (search in files)
- **File tree**: `\` (toggle Neo-tree)
- **Buffer list**: `<leader><leader>`

### Health Checks

Run `:checkhealth` to verify all dependencies and configurations are working
properly.

## Plugin Configuration Patterns

When adding new plugins:

1. Add plugin specification to the `require('lazy').setup()` call in `init.lua`
2. For complex plugins, create separate config files in `lua/kickstart/plugins/`
3. Use appropriate lazy-loading triggers (event, cmd, keys, ft)
4. Follow the existing patterns for keymaps and configuration

## Dependencies

External tools that should be available:

- **ripgrep**: Required for Telescope live grep
- **fd**: Optional, improves file finding performance
- **make**: Required for telescope-fzf-native compilation
- **Language servers**: Installed automatically via Mason
- **Formatters**: stylua (Lua), prettier/prettierd (JavaScript/TypeScript)
- **Linters**: eslint (JavaScript/TypeScript), markdownlint (Markdown)

## File Editing Guidelines

- The configuration favors education and readability over conciseness
- Most settings include helpful comments explaining their purpose
- LSP and plugin configurations are well-documented inline
- When modifying, preserve the educational comments and structure
