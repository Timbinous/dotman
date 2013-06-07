call pathogen#infect()
"colorscheme grb2
syntax on
filetype plugin indent on
set tabstop=2 softtabstop=2 shiftwidth=2 expandtab
autocmd FileType ruby compiler ruby
no ,w <C-w><C-w>
map ,s <C-w><C-v><C-w><C-w>
map ,t :w\|:!rspec %<cr>
map ,r :w\|:!RAILS_ENV=qa rspec %<cr>

imap <Nul> <ESC>
imap jk <ESC>
imap kj <ESC>
imap <C-h> <C-W>
map <C-n> :tabn<cr>
map <C-p> :tabp<cr>
map <C-b> :tabnew<cr>
"nmap n nzz
"nmap N Nzz
no J 8j
no K 8k
" set winwidth=104
set winheight=5
set winminheight=5
set winheight=999
set wildmode=longest,list
set wildmenu
set nu
set viminfo='100,<50,s10,h,:100
set modeline
set ls=2
set switchbuf=usetab
let g:EclimJavascriptValidate = 0

""""""""""""""""""""""""""""""
" => Visual mode related
""""""""""""""""""""""""""""""
" Really useful!
"  In visual mode when you press * or # to search for the current selection
vnoremap <silent> * :call VisualSearch('f')<CR>
vnoremap <silent> # :call VisualSearch('b')<CR>

" When you press gv you vimgrep after the selected text
vmap <silent>gg :call VisualSearch('gv')<CR>
vmap <silent>gd :call VisualSearch('gd')<CR>
map ,g :Ack 
map cc <C-_><C-_>

" From an idea by Michael Naumann
function! VisualSearch(direction) range
    let l:saved_reg = @"
    execute "normal! vgvy"

    let l:pattern = escape(@", '\\/.*$^~[]')
    let l:pattern = substitute(l:pattern, "\n$", "", "")

    if a:direction == 'b'
        execute "normal ?" . l:pattern . "^M"
    elseif a:direction == 'gv'
        execute "Ack " . l:pattern
    elseif a:direction == 'gd'
        execute "Ack \"(def|function|class) " . l:pattern . "\""
    elseif a:direction == 'f'
        execute "normal /" . l:pattern . "^M"
    endif

    let @/ = l:pattern
    let @" = l:saved_reg
endfunction
