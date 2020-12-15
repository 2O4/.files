# 2O4's dotfiles

Warning: If you want to give these dotfiles a try, you should first fork this repository, review the code, and remove things you don’t want or need. Don’t blindly use my settings unless you know what that entails. Use at your own risk!

| Software             | used                                                                                         |
| -------------------- | -------------------------------------------------------------------------------------------- |
| Shell                | [zsh](https://www.zsh.org/)                                                                  |
| Terminal             | [Alacritty](https://github.com/alacritty/alacritty)                                          |
| Terminal Multiplexer | [tmux](https://github.com/tmux/tmux)                                                         |
| Editor               | [Vim/NeoVim](https://github.com/neovim/neovim), [VSCode](https://code.visualstudio.com/)     |
| Font                 | [DroidSansMono Nerd Font Mono Book](https://github.com/ryanoasis/powerline-extra-symbols) 11 |
| GTK Theme            | [Matcha-dark-azul](https://github.com/vinceliuice/Matcha-gtk-theme)                          |
| Icons                | [Papirus-Dark](https://github.com/PapirusDevelopmentTeam/papirus-icon-theme) \[GTK2/3\]      |
| Cursor               | Xcursor-breeze-snow                                                                          |

## Installation

Requirements:

* You need a [Nerd Font](https://github.com/ryanoasis/nerd-fonts) patched font with the [powerline extra symbols](https://github.com/ryanoasis/powerline-extra-symbols), I recommand [Droid Sans Mono](https://github.com/ryanoasis/powerline-extra-symbols/blob/master/patched-fonts/DroidSansMonoForPowerlinePlusNerdFileTypesMono.otf)

Configure the git bare repo and pull.
```
cd
git clone https://github.com/2O4/.files.git
cd .files
```

Install zsh plugins
```
git submodule update --init --recursive
```

### Installation of a specific config

Source .zshrc so that you can have local zsh configs
```
echo "source ~/.files/zshrc" >> ~/.zshrc
```

or via symlink:
```
# To use the zsh config
ln -s ~/.files/zshrc ~/.zshrc
```

And for the rest:
```
# To use the nvim config
mkdir ~/.config/nvim/
ln -s ~/.files/init.vim ~/.config/nvim/init.vim

# To use the vim config
ln -s ~/.files/init.vim ~/.vimrc

# To use the tmux config
ln -s ~/.files/tmux.conf ~/.tmux.conf

# To use the alacritty config
mkdir ~/.config/alacritty/
ln -s ~/.files/alacritty.yml ~/.config/alacritty/alacritty.yml

# For the custom scripts
mkdir ~/.local/bin/
ln -s ~/.files/bin/* ~/.local/bin/
```

For the custom nvim/vim files:
```
# For the custom airline theme (to match the tmux theme)
mkdir ~/.config/nvim/autoload/airline/themes/
ln -s ~/.files/nvim/autoload/airline/themes/custom.vim ~/.config/nvim/autoload/airline/themes/custom.vim

# For the custom theme
mkdir ~/.config/nvim/colors/
ln -s ~/.files/nvim/colors/base16-tomorrow-night-custom.vim ~/.config/nvim/colors/base16-tomorrow-night-custom.vim

# For the custom python syntax
mkdir ~/.config/nvim/syntax/
ln -s ~/.files/nvim/syntax/python.vim ~/.config/nvim/syntax/python.vim
```

## Features

* Modern and minimalist style
* NerdTree for vim with extension for [Git](https://github.com/Xuyuanp/nerdtree-git-plugin) and [icons](https://github.com/ryanoasis/vim-devicons) and other custom scripts
* Tmux's terminal background color changes automaticly based on active SSH conenction
* 'Zen mode' for tmux (like in VSCode) only keep the code and center it with empty pane on the side
* NeoVim config shared with Vim
* Custom Python syntax highlight file

## Shortcuts

### Terminal shortcuts

| Program         | Action                    | Shortcut               |
| --------------- | ------------------------- | ---------------------- |
| vim             | \<vim-leader\>            | \<space\>              |
| tmux            | \<tmux-prefix\>           | Ctrl+a                 |
| tmux            | Navigate pane             | Ctrl+[hjkl]            |
| tmux            | New horizontal split pane | \<tmux-prefix\> s      |
| tmux            | New vertical split pane   | \<tmux-prefix\> v      |
| tmux            | Toggle mouse              | \<tmux-prefix\> m      |
| tmux            | Edit config and reload    | \<tmux-prefix\> Ctrl+e |
| vim             | Move to next tab          | Alt+l                  |
| vim             | Move to previous tab      | Alt+h                  |
| vim             | Exit insert               | jj                     |
|                 | **Vim plugins**           |                        |
| vim NERDTree    | Toggle                    | \<vim-leader\>+n       |
| vim NERDTree    | Open                      | l                      |
| vim NERDTree    | Split                     | s                      |
| vim NERDTree    | Vsplit                    | v                      |
| vim NERDTree    | Jump next sibling         | \<vim-leader\>+j       |
| vim NERDTree    | Jump previous sibling     | \<vim-leader\>+k       |
| vim Undotree    | Toggle                    | \<vim-leader\>+u       |
| vim Ultisnips   | Expand                    | Ctrl+Space s           |
| vim Ultisnips   | Forward                   | Ctrl+Space s           |
| vim Ultisnips   | backward                  | Ctrl+Space p           |
| vim Ultisnips   | List snipets              | Ctrl+Space k           |
| vim easy-align  | Align prefix              | ga                     |
| vim git-gutter  | Jump next hunk            | ]c                     |
| vim git-gutter  | Jump previous hunk        | [c                     |
| vim git-gutter  | Preview current hunk      | \<vim-leader\> hp      |
| vim git-gutter  | Stage the hunk            | \<vim-leader\> hs      |
| vim git-gutter  | Undo the hunk             | \<vim-leader\> hu      |
| vim fzf         | Open fzf                  | \<vim-leader\> f       |
|                 | **Custom**                |                        |
| tmux            | Open zen mode             | \<tmux-prefix\> z      |
| tmux            | Close zen mode            | \<tmux-prefix\> Ctrl+z |
| tmux            | Open 25% vertical pane    | \<tmux-prefix\> Ctrl+v |
| tmux            | Open 20% horizontal pane  | \<tmux-prefix\> Ctrl+s |
| vim             | toggle vert cursorline    | \<vim-leader\>+c       |
|                 | **Unchanged**             |                        |
| vim             | Close preview window      | Ctrl+w z               |

### WM shortcuts

| System                                    | Shortcut             |
| ----------------------------------------- | -------------------- |
| **Navigation**                            |                      |
| Hide all normal windows                   | Super+Shift+J        |
| Move to workspace above                   | Super+P              |
| Move to workspace below                   | Super+;              |
| Move window one monitor down              | Super+Alt+J          |
| Move window one monitor to the left       | Super+Alt+H          |
| Move window one monitor to the right      | Super+Alt+L          |
| Move window one monitor up                | Super+Alt+k          |
| Move window one workspace down            | Super+Alt+;          |
| Move window one workspace up              | Super+Alt+P          |
| Switch applications                       | Super+Tab            |
| Switch to workspace 1                     | Super+[              |
| Switch to workspace 2                     | Super+]              |
| **Windows**                               |                      |
| Close window                              | Super+W              |
| Hide window                               | Super+J              |
| Toggle fulscreen mode                     | Super+K              |
| Toggle maximization state                 | Super+Ctrl+K         |
| View split on left                        | Super+H              |
| View split on right                       | Super+L              |
| **Launchers**                             |                      |
| Launch terminal                           | Super+Return Super+1 |
| launch editor                             | Super+2              |
| Launch web browser                        | Super+3              |
| Launch social app                         | Super+4              |
| Launch file explorer                      | Super+5              |
| **Screenshots**                           |                      |
| Copy a screenshot of an area to clipboard | Print                |
| **Sound and Media**                       |                      |
| Microphone mute/unmute                    | Super+M              |
| Next track                                | Super+N              |
| Play (or play/pause)                      | Pause                |
| Previous track                            | Super+B              |
| **System**                                |                      |
| Lock screen                               | Super+Backspace      |
| Shutdown now                              | Super+Alt+Backspace  |
| Show all applications                     | Super+D              |

## Wallpapers

I do not own the right to the wallpapers images.

### Web browser customisation

* [Chrome style - Stylus](https://chrome.google.com/webstore/detail/stylus/clngdbkpkpeebahjckkjfobafhncgmne)
* [Firefox style - Stylus](https://addons.mozilla.org/en-US/firefox/addon/styl-us/)

#### Custom CSS

* [GitHub style - GitHub-Dark](https://github.com/StylishThemes/GitHub-Dark)
* [GitLab style - dark-gitlab](https://gitlab.com/Avinash-Bhat/dark-gitlab)
* [Wikipedia theme - Wikipedia-Dark](https://github.com/StylishThemes/Wikipedia-Dark)
* [Stack Overflow theme - StackOverflow-Dark](https://github.com/StylishThemes/StackOverflow-Dark)
* [Protonmail theme](https://github.com/amdelamar/pm-theme)
