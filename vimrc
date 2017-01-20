" Lots of options; @see https://github.com/junegunn/vim-plug
call plug#begin('~/.vim/plugged')

Plug 'junegunn/vim-easy-align'
Plug 'scrooloose/nerdtree'
Plug 'scrooloose/nerdcommenter'
Plug 'jwalton512/vim-blade'
Plug 'xolox/vim-misc'    " Required for vim-session
Plug 'xolox/vim-session' " Better session handling
Plug 'mkitt/tabline.vim' " make tabs prettier
"Plug 'ctrlpvim/ctrlp.vim'

" PlugInstall [name ...] [#threads]    Install plugins
" PlugUpdate [name ...] [#threads]    Install or update plugins
" PlugClean[!]    Remove unused directories (bang version will clean without prompt)
" PlugUpgrade    Upgrade vim-plug itself
" PlugStatus    Check the status of plugins
" PlugDiff    Examine changes from the previous update and the pending changes
" PlugSnapshot[!] [output path]    Generate script for restoring the current snapshot of the plugins

call plug#end()
filetype plugin indent on

set expandtab       " convert tabs to spaces
set shiftwidth=4    " set indent to 4
set softtabstop=4   " a combination of spaces and tabs are used to simulate tab stops at
set tabstop=4
set smartindent
set nowrap
set colorcolumn=120
set ruler
set number
set laststatus=2

" ---- COLOR SCHEME ---- "
syntax enable
colorscheme monokai_cy
set t_Co=256  " vim-monokai now only support 256 colours in terminal.
hi TabLineFill  ctermfg=250  ctermbg=234  cterm=NONE
hi TabLine      ctermfg=250  ctermbg=237  cterm=NONE
hi TabLineSel   ctermfg=255  ctermbg=244  cterm=NONE
hi LineNr       ctermfg=075  ctermbg=237  cterm=NONE guifg=#90908a guibg=#3c3d37 gui=NONE
" ---- /COLOR SCHEME ---- "

" ---- KEY BINDINGS ---- "
map <C-f> :find 
map <C-p> :tabfind 
map <C-n> :tabe 
map <F2> i<CR><ESC>
"map <C-o> :NERDTreeToggle<CR>
map <C-o> :NERDTreeFind<CR>
map ff <C-w>gf
" ---- /KEY BINDINGS ---- "

let mapleader = ','

" ---- NERDCOMMENTER ---- "
let g:NERDSpaceDelims = 1
let g:NERDDefaultAlign = 'left'
let g:NERDCommentEmptyLines = 1
let g:NERDTrimTrailingWhitespace = 1
" ---- /NERDCommenter ---- "

" ---- NERDTREE ---- "
let NERDTreeShowBookmarks=1
" ---- /NERDTREE ---- "

" ---- EASYALIGN ---- "
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)
xmap gaa <Plug>(EasyAlign)=
nmap gaa <Plug>(EasyAlign)=
" ---- /EASYALIGN ---- "

" ---- CAPSLOCK ---- "
" Use CTRL-^ instead of CAPSLOCK
" Execute 'lnoremap x X' and 'lnoremap X x' for each letter a-z.
for c in range(char2nr('A'), char2nr('Z'))
  execute 'lnoremap ' . nr2char(c+32) . ' ' . nr2char(c)
  execute 'lnoremap ' . nr2char(c) . ' ' . nr2char(c+32)
endfor
" Kill the capslock when leaving insert mode.
autocmd InsertLeave * set iminsert=0
" ---- /CAPSLOCK ---- "

" ---- SESSIONS ---- "
let g:session_autoload='no'
" command to reopen last session @requires xolox/vim-session
command! Sesh call sesh:Open()
function! sesh:Open()
    if empty(glob(g:session_directory . '/lastsession.vim'))
        SaveSession lastsession
    endif
    OpenSession lastsession
    let g:session_autosave_periodic=5
    let g:session_autosave='yes'
endfunction
" ---- /SESSIONS ---- "

" ---- SHORTCUT TO OPEN VIMRC ---- "
command! Vimrc call vimrc:Open()
function! vimrc:Open()
    :tabe ~/.vim/vimrc
endfunction
" ---- /SHORTCUT TO OPEN VIMRC ---- "

" ---- ETABS ---- "
" ## open multiple files in tabs from within vim ## "
command! -complete=file -nargs=+ Etabs call s:ETW('tabnew', <f-args>)
" command! -complete=file -nargs=+ Ewindows call s:ETW('new', <f-args>)
" command! -complete=file -nargs=+ Evwindows call s:ETW('vnew', <f-args>)

function! s:ETW(what, ...)
  for f1 in a:000
    let files = glob(f1)
    if files == ''
      execute a:what . ' ' . escape(f1, '\ "')
    else
      for f2 in split(files, "\n")
        execute a:what . ' ' . escape(f2, '\ "')
      endfor
    endif
  endfor
endfunction
" ---- /ETABS ---- "

" ---- WIPE HIDDEN BUFFERS ---- "
command! Bwh call DeleteHiddenBuffers()
function DeleteHiddenBuffers()
    let tpbl=[]
    call map(range(1, tabpagenr('$')), 'extend(tpbl, tabpagebuflist(v:val))')
    for buf in filter(range(1, bufnr('$')), 'bufexists(v:val) && index(tpbl, v:val)==-1')
        silent execute 'bwipeout' buf
    endfor
endfunction
" ---- /WIPE HIDDEN BUFFERS ---- "

let $hostname = substitute(system('hostname'), '\n', '', '')
" OCP settings
if $hostname == 'dragon.ocp.org'
    " let choice = confirm('ouj or lit?', '&ouj\n&lit')
    " if choice == 1
    "     cd ~/sites/ouj.ocp.org
    " elseif choice == 2
    "     cd ~/sites/liturgy.com
    " endif
    set path=.,./app/Http/Controllers/**,./resources/**,./config/**,./public/**,./app/**,./vendor/oregoncatholicpress/**,./**,**,~,~/**
endif
