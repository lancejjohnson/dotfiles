# dotfiles

## Management

### Stow

[GNU Stow](https://www.gnu.org/software/stow/)

Stow is organized by having "packages" in directories that you want to manage.
For example, if you want to manage git files Stow expects a git directory
containing files related to git that you want to manage symlinks for.

These top-level directories need to reflect their intended target directories.
For example, if you want neovim's configuration files to be in `$XDG_HOME`, your
neovim "package" directory needs to contain `neovim/.config/nvim/init.vim`, etc.
When you `stow neovim` it will symlink inside `~/.config`

Use stow to link your dotfiles

Preview any changes without making them.

    stow -n 

## Neovim

### Packer

To find the location of installed packer packages, look at
`~/.config/nvim/plugin/packer_compiled.lua`.

### Migrating to Mason

The `lsp-installer` program has been deprecated in favor of mason.nvim by the
same author.

- Remove lsp-installer from plugins.
- Install the mason plugins

Mason is an installer for various types of servers including language server
protocol (lsp) servers. mason-lspconfig provides a bridge between the installer
and the lsp configuration handled by lspconfig.

This updates follows chris@machine:

https://github.com/LunarVim/nvim-basic-ide
