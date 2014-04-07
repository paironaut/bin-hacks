#!/bin/sh
# from Armando Fox
# https://github.com/saasbook/courseware/blob/master/vm-setup/configure-image-0.10.3.sh

sudo-pw apt-get install -y vim
set +v
echo "filetype on  \" Automatically detect file types." >> .vimrc
echo "set nocompatible  \" no vi compatibility." >> .vimrc
echo "" >> .vimrc
echo "\" Add recently accessed projects menu (project plugin)" >> .vimrc
echo "set viminfo^=\!" >> .vimrc
echo "" >> .vimrc
echo "\" Minibuffer Explorer Settings" >> .vimrc
echo "let g:miniBufExplMapWindowNavVim = 1" >> .vimrc
echo "let g:miniBufExplMapWindowNavArrows = 1" >> .vimrc
echo "let g:miniBufExplMapCTabSwitchBufs = 1" >> .vimrc
echo "let g:miniBufExplModSelTarget = 1" >> .vimrc
echo "" >> .vimrc
echo "\" alt+n or alt+p to navigate between entries in QuickFix" >> .vimrc
echo "map <silent> <m-p> :cp <cr>" >> .vimrc
echo "map <silent> <m-n> :cn <cr>" >> .vimrc
echo "" >> .vimrc
echo "\" Change which file opens after executing :Rails command" >> .vimrc
echo "let g:rails_default_file='config/database.yml'" >> .vimrc
echo "" >> .vimrc
echo "syntax enable" >> .vimrc
echo "" >> .vimrc
echo "set cf  \" Enable error files & error jumping." >> .vimrc
echo "set clipboard+=unnamed  \" Yanks go on clipboard instead." >> .vimrc
echo "set history=256  \" Number of things to remember in history." >> .vimrc
echo "set autowrite  \" Writes on make/shell commands" >> .vimrc
echo "set ruler  \" Ruler on" >> .vimrc
echo "set nu  \" Line numbers on" >> .vimrc
echo "set nowrap  \" Line wrapping off" >> .vimrc
echo "set timeoutlen=250  \" Time to wait after ESC (default causes an annoying delay)" >> .vimrc
echo "\" colorscheme vividchalk  \" Uncomment this to set a default theme" >> .vimrc
echo "" >> .vimrc
echo "\" Formatting" >> .vimrc
echo "set ts=2  \" Tabs are 2 spaces" >> .vimrc
echo "set bs=2  \" Backspace over everything in insert mode" >> .vimrc
echo "set shiftwidth=2  \" Tabs under smart indent" >> .vimrc
echo "set nocp incsearch" >> .vimrc
echo "set cinoptions=:0,p0,t0" >> .vimrc
echo "set cinwords=if,else,while,do,for,switch,case" >> .vimrc
echo "set formatoptions=tcqr" >> .vimrc
echo "set cindent" >> .vimrc
echo "set autoindent" >> .vimrc
echo "set smarttab" >> .vimrc
echo "set expandtab" >> .vimrc
echo "" >> .vimrc
echo "\" Visual" >> .vimrc
echo "set showmatch  \" Show matching brackets." >> .vimrc
echo "set mat=5  \" Bracket blinking." >> .vimrc
echo "set list" >> .vimrc
echo "\" Show $ at end of line and trailing space as ~" >> .vimrc
echo "set lcs=tab:\ \ ,eol:$,trail:~,extends:>,precedes:<" >> .vimrc
echo "set novisualbell  \" No blinking ." >> .vimrc
echo "set noerrorbells  \" No noise." >> .vimrc
echo "set laststatus=2  \" Always show status line." >> .vimrc
echo "" >> .vimrc
echo "\" gvim specific" >> .vimrc
echo "set mousehide  \" Hide mouse after chars typed" >> .vimrc
echo "set mouse=a  \" Mouse in all modesc" >> .vimrc
mkdir .vim
cd .vim
wget http://www.vim.org/scripts/download_script.php?src_id=16429
mv d* rails.zip
unzip rails.zip
rm -rf rails.zip
set -v
