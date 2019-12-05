#!/bin/zsh

# See https://github.com/prabirshrestha/vim-lsp/wiki/Servers

# C/C++
if [ "$(uname)" '==' 'Darwin' ]; then
  brew install llvm
elif [[ `uname -r` =~ ARCH$ ]]; then
  sudo pacman -S clang-tools-extra
fi

curl -fsSL https://releases.llvm.org/5.0.0/llvm-5.0.0.src.tar.xz | tar -Jxvf -
mv llvm-5.0.0.src llvm
cd llvm/tools
curl -fsSL https://releases.llvm.org/5.0.0/cfe-5.0.0.src.tar.xz | tar -Jxvf -
mv cfe-5.0.0.src clang
cd clang/tools
curl -fsSL https://releases.llvm.org/5.0.0/clang-tools-extra-5.0.0.src.tar.xz | tar -Jxvf -
mv clang-tools-extra-5.0.0.src extra

cd ../../../..
mkdir llvm-build
cd llvm-build

cmake -G 'Unix Makefiles' -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=/usr/local ../llvm
make
sudo make install

cd ..
rm -r llvm llvm-build


# Ruby
gem install solargraph

# Python
pip install python-language-server
pip3 install python-language-server

# TypeScript
npm install -g typescript typescript-language-server

# Go
go get -u golang.org/x/tools/cmd/gopls

# Css/Less/Sass
npm install -g vscode-css-languageserver-bin
