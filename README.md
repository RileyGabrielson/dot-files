# dot-files
an increasingly more complex dev configuration

## Implementation Notes
- Using GNU Stow to add references to these dotfiles in system directories.

## Dependencies
- Nvim Packer
  - git clone --depth 1 https://github.com/wbthomason/packer.nvim\ ~/.local/share/nvim/site/pack/packer/start/packer.nvim
- VSCode Smart Language Servers
  - npm i -g vscode-langservers-extracted
- Some sort of C Compiler
  - cc, gcc, something
- Rust Language Server
  - https://rust-analyzer.github.io/manual.html#installation
- Lua Language Server
  - https://github.com/sumneko/lua-language-server/wiki/Getting-Started#command-line
