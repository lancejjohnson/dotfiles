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

#### Use stow to link your dotfiles

Clone dotfiles into `~/.dotfiles`.

Change into the `~/.dofiles` directory. This is the directory stow assumes contains the files you are wanting to symlink.

    cd ~/.dotfiles

Run the stow command to link

    stow neovim

Preview any changes without making them.

    stow -nv

Specifiying directories

-d the directory to find the files you are symlinking

-t the directory into which the symlinks should go

Stow assumes the "stow" directory (i.e. the directory containing the software images you are wanting to link) to be the current directory. It assumes the "target" directory to the parent directory of the "stow" directory.

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
