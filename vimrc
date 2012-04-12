set nocompatible
filetype off


if !executable('git')
  echo "[Vim]: Git is not installed and is required."
  exit
endif

if !isdirectory(expand('~/.vim/bundle/vundle'))
  silent !git clone git://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
  let s:bootstrap=1
endif

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle
" required! 
Bundle 'gmarik/vundle'

" My Bundles here:

" original repos on github
" Bundle 'mrtazz/molokai.vim'
Bundle 'altercation/vim-colors-solarized'
Bundle 'tpope/vim-fugitive'
Bundle 'tpope/vim-rails.git'
Bundle 'tpope/vim-endwise'
Bundle 'tpope/vim-commentary'
Bundle 'mileszs/ack.vim'
Bundle 'tpope/vim-surround'
Bundle 'msanders/snipmate.vim'
Bundle 'tsaleh/vim-align'
Bundle 'tpope/vim-unimpaired'
Bundle 'scrooloose/syntastic'
Bundle 'tpope/vim-fugitive'
Bundle 'tpope/vim-rails.git'
Bundle 'Townk/vim-autoclose.git'
Bundle 'duff/vim-scratch.git'
Bundle 'michaeljsmith/vim-indent-object'
Bundle 'pangloss/vim-javascript'
Bundle 'manalang/jshint.vim.git'
Bundle 'taq/vim-rspec'
Bundle 'digitaltoad/vim-jade.git'
Bundle 'tpope/vim-haml'
Bundle 'kana/vim-textobj-user.git'
Bundle 'nelstrom/vim-textobj-rubyblock.git'
Bundle 'tsaleh/vim-matchit'
Bundle 'Lokaltog/vim-powerline'
" Bundle 'ervandew/supertab'
Bundle 'tpope/vim-repeat'
Bundle 'wincent/Command-T'
Bundle 'tpope/vim-markdown'
Bundle 'fesplugas/vim-session'
Bundle 'fesplugas/vim-rename'

" vim-scripts repos
Bundle 'nginx.vim'

" non github repos
" Bundle 'git://git.wincent.com/command-t.git'

if exists('$TMUX')
  Bundle 'jgdavey/tslime.vim'
  " Bundle 'jgdavey/vim-turbux'
endif


if exists("s:bootstrap") && s:bootstrap
  unlet s:bootstrap
  BundleInstall
endif

set number
set ruler
syntax on

set exrc      " enable per-directory .vimrc files
set secure    " disable unsafe commands in local .vimrc files

" Set encoding
set encoding=utf-8

" Whitespace stuff
set nowrap
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab
set list listchars=tab:\ \ ,trail:·

" Searching
set hlsearch
set incsearch
set ignorecase
set smartcase

" Tab completion
set wildmode=list:longest,list:full
set wildignore+=*.o,*.obj,.git,*.rbc,*.class,.svn,vendor/gems/*

" Status bar
set laststatus=2

let mapleader = ","

" mappings

" Switch between the last two files
nnoremap <leader><leader> <c-^>

" Edit or view files in same directory as current file
cnoremap %% <C-R>=expand('%:h').'/'<cr>
map <leader>e :edit %%
map <leader>v :view %%

" Quick file finder. Search file with `:find <file>`.
set path=$PWD/**

" =============== Syntastic  ==============================
" Enable syntastic syntax checking
let g:syntastic_enable_signs=1
let g:syntastic_quiet_warnings=1

" =============== Ruby & Rails  ==============================
" Rails routes and Gemfile
imap <leader>gr :topleft :split config/routes.rb<cr>
map <leader>gg :topleft 100 :split Gemfile<cr>

map <leader>rs :%s/:\(\w\+\)/'\1'/gec<cr>

function! ShowRoutes()
  " Requires 'scratch' plugin
  :topleft 100 :split __Routes__
  " Make sure Vim doesn't write __Routes__ as a file
  :set buftype=nofile
  " Delete everything
  :normal 1GdG
  " Put routes output in buffer
  :0r! rake -s routes
  " Size window to number of lines (1 plus rake output length)
  :exec ":normal " . line("$") . "_ "
  " Move cursor to bottom
  :normal 1GG
  " Delete empty trailing line
  :normal dd
endfunction
map <leader>gR :call ShowRoutes()<cr>


" ============== Command-T ==================================
let g:CommandTMaxHeight=20

" set term=screen-256color
" set guifont=Bitstream\ Vera\ Sans\ Mono\ for\ Powerline:h14
" let g:Powerline_symbols = 'fancy'


" Command-T tweaks for terminal vim
set ttimeoutlen=50

" if &term =~ "screen-256color"
"   let g:CommandTCancelMap     = ['<ESC>', '<C-c>']
"   let g:CommandTSelectNextMap = ['<C-n>', '<C-j>', '<ESC>OB']
"   let g:CommandTSelectPrevMap = ['<C-p>', '<C-k>', '<ESC>OA']
" endif

" Custom CommandT mappings
map <leader>f :CommandTFlush<cr>\|:CommandT<cr>
map <leader>gf :CommandTFlush<cr>\|:CommandT %%<cr>
map <leader>ga :CommandTFlush<cr>\|:CommandT app<cr>
map <leader>gj :CommandTFlush<cr>\|:CommandT app/assets/javascripts<cr>
map <leader>gs :CommandTFlush<cr>\|:CommandT spec<cr>
map <leader>gv :CommandTFlush<cr>\|:CommandT vendor<cr>
map <leader>gc :CommandTFlush<cr>\|:CommandT app/controllers<cr>
map <leader>gm :CommandTFlush<cr>\|:CommandT app/models<cr>
map <leader>gh :CommandTFlush<cr>\|:CommandT app/helpers<cr>
map <leader>gl :CommandTFlush<cr>\|:CommandT lib<cr>
map <leader>go :CommandTFlush<cr>\|:CommandT config<cr>

" CommandTBuffer mapping
nmap <Leader>. :CommandTFlush<cr>\|:CommandTBuffer<CR>

" =============== CTAGS =====================================
" CTags
map <Leader>rt :!ctags --extra=+f -R --exclude=.git --exclude=log * ~/.rvm/gems/ruby-head/*<CR><CR>

" =============== File Types ================================
" Thorfile, Rakefile, Vagrantfile and Gemfile are Ruby
au BufRead,BufNewFile {Gemfile,Rakefile,Vagrantfile,Thorfile,config.ru}    set ft=ruby

" add json syntax highlighting
au BufNewFile,BufRead *.json set ft=javascript

"adding mapping for rabl files
au BufRead,BufNewFile *.rabl setf ruby

"adding mapping for markdown files
au BufRead,BufNewFile *.md set ft=markdown

"adding mapping for jade.erb files
autocmd BufNewFile,BufReadPost *.jade.erb set filetype=jade

au BufRead,BufNewFile /usr/local/etc/nginx/sites-available/* set ft=nginx

" load the plugin and indent settings for the detected filetype
filetype plugin indent on

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

" Directories for swp files
set backupdir=~/.backup
set directory=~/.backup

" % to bounce from do to end etc.
runtime! macros/matchit.vim

" clipboard osx support for terminal mode vim
set clipboard=unnamed

" Make tab completion for files/buffers act like bash
set wildmenu

" Keep more context when scrolling off the end of a buffer
set scrolloff=3

" Make the current window big, but leave others context
set winwidth=84
" We have to have a winheight bigger than we want to set winminheight. But if
" we set winheight to be huge before winminheight, the winminheight set will
" fail.
set winheight=5
set winminheight=5
set winheight=999

nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l

" Custom functions

" Running tests from Gary Bernhardt & Francesc Esplugas & Jordi Romero


function! s:send_test(executable)
  let s:executable = a:executable
  if s:executable == ''
    if exists("g:tmux_last_command") && g:tmux_last_command != ''
      let s:executable = g:tmux_last_command
    else
      let s:executable = 'echo "Warning: No command has been run yet"'
    endif
  endif
  call Send_to_Tmux("".s:executable."\n")
  :redraw!
endfunction

function! RunTests(args)
  :write
  :silent !echo;echo;echo;echo;echo
  if filereadable('script/test')
    let spec =  'script/test '
  elseif filereadable('Gemfile')
    let spec = 'bundle exec rspec '
  else
    let spec = 'rspec '
  end
  " Without Send_to_Tmux
  " let cmd = ':! time ' . spec . a:args
  " execute cmd

  " With Send_to_Tmux
  let cmd = 'time ' . spec . a:args
  return s:send_test(cmd)
endfunction

" function! RunTests(filename)
"     " Write the file and run tests for the given filename
"     :w
"     :silent !echo;echo;echo;echo;echo
"     exec ":!bundle exec rspec " . a:filename
" endfunction

function! SetTestFile()
    " Set the spec file that tests will be run for.
    let t:grb_test_file=@%
endfunction

function! RunTestFile(...)
    if a:0
        let command_suffix = a:1
    else
        let command_suffix = ""
    endif

    " Run the tests for the previously-marked file.
    let in_spec_file = match(expand("%"), '_spec.rb$') != -1
    if in_spec_file
        call SetTestFile()
    elseif !exists("t:grb_test_file")
        return
    end
    call RunTests(t:grb_test_file . command_suffix)
endfunction

function! RunNearestTest()
    let spec_line_number = line('.')
    call RunTestFile(":" . spec_line_number)
endfunction

" Run this file
map <leader>T :call RunTestFile()<cr>
" Run only the example under the cursor
map <leader>t :call RunNearestTest()<cr>
" Run all test files
map <leader>a :call RunTests('spec')<cr>

" Toggle Scratch pad
function! ToggleScratch()
  if expand('%') == g:ScratchBufferName
      quit
  else
      Sscratch
  endif
endfunction

map <leader>s :call ToggleScratch()<CR>
map <leader>jt <Esc>:%!python -m json.tool<CR>

" sum column of numbers in yanked register, save
" result to " register
function! Sum()
python << EOF
import vim

# find total from input
items = vim.eval("@0").split("\n")
floatsList = map(float, filter(lambda n: n != '', items))
total = sum(floatsList)

# set register and echo result
vim.command("call setreg('\"', '%s\n')" % total)
vim.command("echo '%s saved to clipboard'" % total)
EOF
endfunction

function! ExtractVariable()
    let name = input("Variable name: ")
    if name == ''
        return
    endif
    " Enter visual mode (not sure why this is needed since we're already in
    " visual mode anyway)
    normal! gv

    " Replace selected text with the variable name
    exec "normal c" . name
    " Define the variable on the line above
    exec "normal! O" . name . " = "
    " Paste the original selected text to be the variable value
    normal! $p
endfunction

function! InlineVariable()
    " Copy the variable under the cursor into the 'a' register
    :let l:tmp_a = @a
    :normal "ayiw
    " Delete variable and equals sign
    :normal 2daW
    " Delete the expression into the 'b' register
    :let l:tmp_b = @b
    :normal "bd$
    " Delete the remnants of the line
    :normal dd
    " Go to the end of the previous line so we can start our search for the
    " usage of the variable to replace. Doing '0' instead of 'k$' doesn't
    " work; I'm not sure why.
    normal k$
    " Find the next occurence of the variable
    exec '/\<' . @a . '\>'
    " Replace that occurence with the text we yanked
    exec ':.s/\<' . @a . '\>/' . @b
    :let @a = l:tmp_a
    :let @b = l:tmp_b
endfunction

vnoremap <leader>rv :call ExtractVariable()<cr>
nnoremap <leader>ri :call InlineVariable()<cr>

" word swapping functions
"
" To use gw to swap the current word with the next, without changing cursor position: (See note.)
:nnoremap <silent> gw "_yiw:s/\(\%#\w\+\)\(\_W\+\)\(\w\+\)/\3\2\1/<CR><c-o><c-l>
" To use gl to swap the current word with the previous, keeping cursor on
" current word: (This feels like "pushing" the word to the left.)
:nnoremap <silent> gl "_yiw?\w\+\_W\+\%#<CR>:s/\(\%#\w\+\)\(\_W\+\)\(\w\+\)/\3\2\1/<CR><c-o><c-l>

" To use gr to swap the current word with the next, keeping cursor on current word: (This feels like "pushing" the word to the right.)
:nnoremap <silent> gr "_yiw:s/\(\%#\w\+\)\(\_W\+\)\(\w\+\)/\3\2\1/<CR><c-o>/\w\+\_W\+<CR><c-l>

" To use g{ to swap the current paragraph with the next:
:nnoremap g{ {dap}p{

" To use gc to swap the current character with the next, without changing the cursor position:
:nnoremap <silent> gc xph

set shell=/bin/bash

" abbreviations
abbr W w
abbr Wq wq

"persitant undo
set undodir=~/.vim/undodir
set undofile
set undolevels=1000 "maximum number of changes that can be undone
set undoreload=10000 "maximum number lines to save for undo on a buffer reload
