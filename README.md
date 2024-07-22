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

For use with the Unity framework dont forget to set up an external editor to create the csproj and snl files like VSCode or Visual Studio. 

Dont forget to check for missing dependencies with :checkhealth

For LaTeX integration get zathura to view the files and follow the vimtex instructions and the LSP/treesitter stuff
