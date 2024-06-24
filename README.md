This config is heavily based in the kickstart project. This config is a personalised version of the kickstart project

To install it just paste the following into the command line
```
rm -rf .config/nvim; git clone https://github.com/Poylol1/kickstart.nvim.git "${XDG_CONFIG_HOME:-$HOME/.config}"/nvim; nvim
```
For a total erase of the config paste 
```
rm -rf .config/nvim; rm -rf .local/share/nvim;
```
To install it from scratch paste
```
 git clone https://github.com/Poylol1/kickstart.nvim.git "${XDG_CONFIG_HOME:-$HOME/.config}"/nvim; nvim
```
Finally to totally reinstall paste
```
rm -rf .config/nvim; rm -rf .local/share/nvim; git clone https://github.com/Poylol1/kickstart.nvim.git "${XDG_CONFIG_HOME:-$HOME/.config}"/nvim; nvim
```
