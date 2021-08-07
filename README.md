## My dotfiles

This repository is to track my dotfiles.

# General Instructions

Link what you want. Everything is off by default. Some examples are below.

- `ln -s /path/to/repo/.bash_profile ~/.bash_profile`

- `ln -s /path/to/repo/.zprofile ~/.zprofile`

- `ln -s /path/to/repo/.tmux.conf ~/.tmux.conf`

- `ln -s /path/to/repo/.config ~/.config/`

- Or individually to an existing dir: `ln -s /path/to/repo/.config/nvim ~/.config/nvim`

See below for individual packages' instructions.

# Vim

These dotfiles leave Vim and Vi unmolested so that they can be used for quick test editing.

# Neovim

Neovim is turned into an IDE with this setup.

The Neovim setup here has no natural dependencies, it's all Vimscript. However, support for completion
and linting can be added by installing the relevant system packages, as descripted below. Steps for installing
the configuration:

- This repository requires a fairly new version of Vim or Neovim. Package managers tend to have a
  version that is too old. These days I install Homebrew on Linux to get around this. Then you can
  install neovim with simply `brew install neovim`.

- Install vim-plug according to https://github.com/junegunn/vim-plug.

- Launch Vim or Neovim. run `:PlugInstall`.

# Using & Keybindings

Since Neovim is meant to be used as an IDE, it has a certain IDE-like feature: format on save for some languages.
This can be annoying when editing a third-party project. `:CocConfig` will expose this list for you to quickly disable
this functionality.

If a language server is acting up, you can restart it using `:e` (reloading the current buffer). This is
useful for circumstances when build files and `compile_cmmands.json` change.

A summary of things you might want to do while editing:

| Action     | Result                                             |
|------------|----------------------------------------------------|
| :e         | Reload buffer (restart language server)            |
| :CocConfig | Configure CoC plugins (such as autoformat on save) |
| [g, ]g     | Navigate diagnostics                               |
| \gd        | Go to definition                                   |
| \gy        | Go to type definition                              |
| \gi        | Go to implementation                               |
| \gr        | Go to references                                   |
| K          | Show documentation                                 |
| \rn        | Rename                                             |
| \f         | Format                                             |
| \ac        | Code action                                        |
| \qf        | Quick fix                                          |
| \if \af    | Introduce function                                 |
| \ic \ac    | Introduce class                                    |
| space a    | Show all diagnostics                               |
| space e    | Manage extensions                                  |
| space c    | Show commands                                      |
| space o    | Find symbol of current document                    |
| space s    | Search workspace symbols                           |
| space jk   | Default action next, previous                      |
| space p    | Resume latest list                                 |

# CoC

One of the better development of the past 10 years is the langauge server protocol. Language developers come
up with a server that editors can talk to for getting completions, compiler errors, and so on.

CoC (https://github.com/neoclide/coc.nvim) is a very comprehensive language server plugin used in this
config. It basically turns your neovim into VSCode. Generally, you'll just need to install nodejs.
You might have your own preferred way of doing this, or you may use this method:

```
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.36.0/install.sh | bash
source ~/.bashrc
nvim install 12.19
```

Following this, you should install some plugins for the language servers you use. Here are the ones
I use.

```
:CocInstall coc-tsserver coc-python coc-clangd coc-json coc-sourcekit coc-rls coc-prettier coc-go
:CocCommand clangd.install
```

See the CoC documentation for keybindings.

CoC has the capacity to install a lot of language servers. On some platforms, it can't, or you might want
to install them yourself. If you do, it can generally find them on the path.

# LSP Tips

Learning to feed and water your language server can take a little bit of ramping up. They often require that
certain project files be in certain places. It's usually worth it in the end.

* `clangd`, the language server for c++, will look at `compile_commands.json` in the directories and parent
  directories of a file. This file contains what it needs to provide completions. Build systems (such as
  CMake and Bazel) typically provide some means of producing these files.

* Other languages' servers often look for files as well. A typical place they look for it is at the place
  you open the editor, or the head of your git repository.
