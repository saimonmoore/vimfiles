" Don't beep
set visualbell

" Default gui color scheme
" color solarized

set t_Co=256
set vb t_vb=

set guifont=Bitstream\ Vera\ Sans\ Mono\ for\ Powerline:h14
let g:Powerline_symbols = 'fancy'

if has("gui_macvim")
" In MacVim, you can have multiple tabs open. This mapping makes Ctrl-Tab
" switch between them, like browser tabs. Ctrl-Shift-Tab goes the other way.
noremap <D-S-Right> :tabnext<CR>
noremap <D-S-Left> :tabprev<CR>

" Switch to specific tab numbers with Command-number
noremap <D-1> :tabn 1<CR>
noremap <D-2> :tabn 2<CR>
noremap <D-3> :tabn 3<CR>
noremap <D-4> :tabn 4<CR>
noremap <D-5> :tabn 5<CR>
noremap <D-6> :tabn 6<CR>
noremap <D-7> :tabn 7<CR>
noremap <D-8> :tabn 8<CR>
noremap <D-9> :tabn 9<CR>
" Command-0 goes to the last tab
noremap <D-0> :tablast<CR>
endif

