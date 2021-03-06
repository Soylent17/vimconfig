" Lots of options; @see https://github.com/junegunn/vim-plug
let $VIMPATH=expand('<sfile>:p:h')
let $HOMEPATH=expand('~/')

if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin($VIMPATH.'/plugged')

Plug 'junegunn/vim-easy-align'
Plug 'scrooloose/nerdtree'
Plug 'scrooloose/nerdcommenter'
Plug 'jwalton512/vim-blade'
Plug 'xolox/vim-misc'    " Required for vim-session
Plug 'xolox/vim-session' " Better session handling
Plug 'mkitt/tabline.vim' " make tabs prettier
Plug 'sirver/ultisnips'  " code snippets
Plug 'honza/vim-snippets' " Snippets are separated from the engine. Add this if you want them
Plug 'kshenoy/vim-signature' " Marks highlighting

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
set confirm         " confirm close when unsaved changes (instead of error)

" ---- ULTISNIPS ---- "
" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"
" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"
let g:UltiSnipsSnippetDirectories=[$HOME.'/.vim/UltiSnips']
" ---- /ULTISNIPS ---- "

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
map <F3> o<ESC>
map <S-CR> A<br /><CR><ESC>
map  A<br /><CR><ESC>
"map <C-o> :NERDTreeToggle<CR>
map <C-o> :NERDTreeFind<CR>
map ff :call CursorFile()<CR>
map fff <C-w>gF
vnoremap // y/<C-R>"<CR>
map <C-h> :ls<CR>:e #
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
command! -nargs=* Sesh call SeshOpen(<f-args>)
function! SeshOpen(...)
    let l:which = 'lastsession'.((a:0 > 0) ? a:1 : '1')
    if empty(glob(g:session_directory . '/'.l:which.'.vim'))
        execute 'SaveSession ' . l:which
    endif
    execute 'OpenSession ' . l:which
    let g:session_autosave_periodic=5
    let g:session_autosave='yes'
endfunction
" ---- /SESSIONS ---- "

" ---- SHORTCUT TO OPEN VIMRC ---- "
command! Vimrc call VimrcOpen()
function! VimrcOpen()
    :tabe $VIMPATH/vimrc
endfunction
" ---- /SHORTCUT TO OPEN VIMRC ---- "

" ---- SHORTCUT TO OPEN BASHRC---- "
command! Bashrc call BashrcOpen()
function! BashrcOpen()
    :tabe $HOMEPATH/.bashrc
endfunction
" ---- /SHORTCUT TO OPEN VIMRC ---- "

" ---- SHORTCUTS TO GREP/OPEN GREP RESULTS ---- "
command! -nargs=+ Grepl call GrepresultGrep(<f-args>)
function! GrepresultGrep(...)
    silent execute '!~/s/grep_laravel.sh -s ' . join(a:000, ' ') . ' ' . expand('%:p')
    call GrepresultOpen()
endfunction

command! Grepo call GrepresultOpen()
function! GrepresultOpen()
    :tabe $HOMEPATH/grep
endfunction
" ---- /SHORTCUT TO OPEN GREP RESULTS ---- "

" ---- SHORTCUT TO PSYSH FOR LARAVEL ---- "
command! Tinker call TinkerOpen()
function! TinkerOpen()
    :!php artisan tinker
endfunction
" ---- /SHORTCUT TO OPEN GREP RESULTS ---- "

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
command! BDAH call DeleteHiddenBuffers()
command! BDA :bufdo! bd
command! BWD :w|:bd
function! DeleteHiddenBuffers()
    let tpbl=[]
    call map(range(1, tabpagenr('$')), 'extend(tpbl, tabpagebuflist(v:val))')
    for buf in filter(range(1, bufnr('$')), 'bufexists(v:val) && index(tpbl, v:val)==-1')
        silent execute 'bd' buf
    endfor
endfunction
" ---- /WIPE HIDDEN BUFFERS ---- "

" ---- SET PASTE ---- "
command! SPP :set paste
command! SPN :set nopaste
command! SNM :set number
command! SNN :set nonumber
" command! NEWPHP :tabnew|:set syntax=php|i <?php
" ---- /SET PASTE ---- "

" ---- FIND OPEN TAB  ---- "
function! CursorFile()
    let tab = WhichTab(expand("<cfile>"))
    if tab > 0
        echo "yep"
        execute 'normal ' . tab . 'gt'
    else
        echo "nope"
        normal fff
    endif
endfunction
function! WhichTab(filename)
    " Try to determine whether file is open in any tab.  
    " Return number of tab it's open in
    let buffername = bufname(a:filename)
    if buffername == ""
        return 0
    endif
    let buffernumber = bufnr(buffername)

    " tabdo will loop through pages and leave you on the last one;
    " this is to make sure we don't leave the current page
    let currenttab = tabpagenr()
    let tab_arr = []
    tabdo let tab_arr += tabpagebuflist()

    " return to current page
    exec "tabnext ".currenttab

    " Start checking tab numbers for matches
    let i = 0
    for tnum in tab_arr
        let i += 1
        " echo "tnum: ".tnum." buff: ".buffernumber." i: ".i
        if tnum == buffernumber
            return i
        endif
    endfor
endfunction
" ---- FIND OPEN TAB  ---- "

let $hostname = substitute(system('hostname'), '\n', '', '')
" OCP settings
if $hostname == 'dragon.ocp.org'
    command! OUJ :cd $HOMEPATH/sites/ouj.ocp.org
    command! LIT :cd $HOMEPATH/sites/liturgy.com
    command! CYM :cd $HOMEPATH/sites/isidore.ocp.org
    command! AOC :cd $HOMEPATH/sites/isidore.ocp.org/public/aoc/2017
    command! AOC6 :cd $HOMEPATH/sites/isidore.ocp.org/public/aoc/2016
    command! OCP :cd vendor/oregoncatholicpress
    command! CMS :cd vendor/oregoncatholicpress/cms
    command! IZR :cd vendor/oregoncatholicpress/izzyresource
    command! REP :cd vendor/oregoncatholicpress/reports
    command! SCR :cd $HOMEPATH/sites/scripts
    " let choice = confirm('ouj or lit?', '&ouj\n&lit')
    " if choice == 1
    "     cd $HOMEPATH/sites/ouj.ocp.org
    " elseif choice == 2
    "     cd $HOMEPATH/sites/liturgy.com
    " endif
    set path=.,./app/Http/Controllers/**,./resources/**,./config/**,./public/**,./app/**,./vendor/oregoncatholicpress/**,./**,**,~,~/**
endif
