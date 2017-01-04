" Lots of options; @see https://github.com/junegunn/vim-plug
call plug#begin('~/.vim/plugged')

Plug 'junegunn/vim-easy-align'
Plug 'scrooloose/nerdtree'
Plug 'scrooloose/nerdcommenter'

" PlugInstall [name ...] [#threads]    Install plugins
" PlugUpdate [name ...] [#threads]    Install or update plugins
" PlugClean[!]    Remove unused directories (bang version will clean without prompt)
" PlugUpgrade    Upgrade vim-plug itself
" PlugStatus    Check the status of plugins
" PlugDiff    Examine changes from the previous update and the pending changes
" PlugSnapshot[!] [output path]    Generate script for restoring the current snapshot of the plugins

call plug#end()
filetype plugin indent on

set tabstop=4
set shiftwidth=4
set expandtab
set number
syntax on
colorscheme monokai_cy
set t_Co=256  " vim-monokai now only support 256 colours in terminal.
let mapleader = ','
map <C-n> :NERDTreeToggle<CR>
map <C-p> :tabfind 
map <C-o> :tabe

let g:NERDSpaceDelims = 1
let g:NERDDefaultAlign = 'left'
let g:NERDCommentEmptyLines = 1
let g:NERDTrimTrailingWhitespace = 1
