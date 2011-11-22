set autoindent
set t_Co=256
set mouse=a
set guifont="Monaco:h13"
set linespace=2 
set wildmode=longest,list  "para completação do TAB igual ao bash
set backupdir=~/.vimbackups
set directory=~/.vimbackups
set autoread
let g:ragtag_global_maps = 1 
set background=dark
colorscheme solarized
syntax on

" Display line numbers and information ruler
set number
set ruler

" OMG This is cool
set wildchar=<Tab> wildmenu wildmode=full

set cursorline

" Navigate through buffers without vim whinings on unsaved buffers
set hidden

set hlsearch
set incsearch
set smarttab

" Stop annoying bells
set vb

" No folding! I hate folding!
set nofoldenable

" Load pathogen
call pathogen#runtime_append_all_bundles()

" As seen on Vimcasts, expand path for the current file
let mapleader=','
map <leader>ew :e <C-R>=expand("%:p:h") . "/" <CR>
map <leader>es :sp <C-R>=expand("%:p:h") . "/" <CR>
map <leader>ev :vsp <C-R>=expand("%:p:h") . "/" <CR>
map <leader>et :tabe <C-R>=expand("%:p:h") . "/" <CR>

nmap <leader>C :set cursorcolumn!<CR>

nmap <leader>a= <ESC>:Tabularize /=\zs<CR>
vmap <leader>a= <ESC>:Tabularize /=<CR>
nmap <leader>a: <ESC>:Tabularize /:\zs<CR>
vmap <leader>a: <ESC>:Tabularize /:\zs<CR>

" Teclas de atalho
map <C-N> :bn<CR> " Próximo buffer
map <C-W>w :w<CR> " Escreve no arquivo

map ,w :w!<cr>
map ,q :q<cr>
map ,s /sad;lkfjasd;lfkjasd;lfkj<cr>
map ,/ <C-X><C-O>

map <C-Down> <ESC>:Bclose<cr>

map ,n :NERDTreeToggle<cr>

map ,c :Bclose<cr>

setlocal modifiable

" Expand Rails-specific commands
" map <leader>is :RSintegrationtest 
" map <leader>c :Rcontroller

" As seen on Vimcasts
if has("autocmd")
  " File type detection
  filetype on
  filetype plugin indent on

  " Default settings
  " Styles depending on file type
  autocmd FileType ruby setlocal ts=2 sts=2 sw=2 expandtab
  autocmd FileType python setlocal ts=4 sts=4 sw=4 expandtab
  autocmd FileType vim setlocal ts=2 sts=2 sw=2 expandtab
  autocmd FileType java setlocal ts=4 sw=4
  autocmd FileType javacc setlocal ts=4 sw=4
  " Treat different file types as one we know. Example:
  " autocmd BufNewFile,BufRead *.rss,*.atom setfiletype xml
  
  " Automatically remove whitespaces while saving files
  autocmd BufWritePre *.snippet,*.yml,*.rb,*.html,*.css,*.erb,*.haml :call <SID>StripTrailingWhitespaces()
endif


" As seen on Vimcasts
nnoremap <silent> <F5> :call <SID>StripTrailingWhitespaces()<CR>
function! <SID>StripTrailingWhitespaces()
  " Preparation: save last search and cursor position.
  let _s=@/
  let l = line(".")
  let c = col(".")
  " Do the business
  %s/\s\+$//e
  " Clean up: restore previous search history and cursor position
  let @/=_s
  call cursor(l,c)
endfunction

" As seen on Vimcasts
" Use window movement with Ctrl-h instead of Ctrl-w h and so on
" map <C-h> <C-w>h
" map <C-j> <C-w>j
" map <C-k> <C-w>k
" map <C-l> <C-w>l

" As seen on Vimcasts, with a few changes by me

map GT gT
map <leader>1 1gt
map <leader>2 2gt
map <leader>3 3gt
map <leader>4 4gt
map <leader>5 5gt
map <leader>6 6gt
map <leader>7 7gt
map <leader>8 8gt
map <leader>9 9gt
map <leader>0 :tablast<CR>

" I always type W instead of w
cab W w
cab Q q
" Map Shift-Tab to autocomplete
" imap <S-Tab> <C-n>

" Map hashrocket as Textmate
imap <C-L> <Space>=><Space>

" I hate Y behavior, isn't natural for me
" so Y now copies until the end of the line
nnoremap Y y$

" I don't want the original snippmate snippets
let g:snippets_dir='~/.vim/snippets'
source ~/.vim/snippets/support_functions.vim
" autocmd vimenter * call s:SetupSnippets()
" function! s:SetupSnippets()
"    "if we're in a rails env then read in the rails snippets
"    if filereadable("./config/environment.rb")
"        call ExtractSnips("~/.vim/snippets/ruby-rails", "ruby")
"        call ExtractSnips("~/.vim/snippets/eruby-rails", "eruby")
"    endif
"
"    call ExtractSnips("~/.vim/snippets/html", "eruby")
"    call ExtractSnips("~/.vim/snippets/html", "xhtml")
"    call ExtractSnips("~/.vim/snippets/html", "php")
" endfunction

"Adding a statusline 
set statusline=
set statusline+=%<\                           " cut at start
set statusline+=%2*[%n%H%M%R%W]%*\            " buffer number, and flags
set statusline+=%-40f\                        " relative path
set statusline+=%*                            "   "
set statusline+=%=                            " seperate between right- and left-aligned
set statusline+=%1*%y%*%*\                    " file type
set statusline+=%10((%l/%L/%c)%)\                " line and column
set statusline+=%P                            " percentage of file
" Show it!
set laststatus=2


inoremap <silent> <Bar>   <Bar><Esc>:call <SID>align()<CR>a
 
function! s:align()
  let p = '^\s*|\s.*\s|\s*$'
  if exists(':Tabularize') && getline('.') =~# '^\s*|' && (getline(line('.')-1) =~# p || getline(line('.')+1) =~# p)
    let column = strlen(substitute(getline('.')[0:col('.')],'[^|]','','g'))
    let position = strlen(matchstr(getline('.')[0:col('.')],'.*|\s*\zs.*'))
    Tabularize/|/l1
    normal! 0
    call search(repeat('[^|]*|',column).'\s\{-\}'.repeat('.',position),'ce',line('.'))
  endif
endfunction

