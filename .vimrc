set autoindent
set t_Co=256
set mouse=a
set guifont=Monaco:h12
set bg=dark
set wildmode=longest,list  "para completação do TAB igual ao bash
set backupdir=~/.vimbackups
set directory=~/.vimbackups
set autoread
let g:ragtag_global_maps = 1 
colorscheme railscasts
syntax on

" Display line numbers and information ruler
set number
set ruler

" Navigate through buffers without vim whinings on unsaved buffers
set hidden

set hlsearch
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

" Teclas de atalho
map <C-N> :bn<CR> " Próximo buffer
map <C-W>w :w<CR> " Escreve no arquivo
map cl ddO        " Change line

map ,w :w!<cr>
map ,, :bprevious<cr>
map .. :bNext<cr>
map ,v :vsplit<cr>
map ,h :split<cr>
map ,q :q<cr>
map ,s /sad;lkfjasd;lfkjasd;lfkj<cr>
map ,k <C-W>
map ,/ <C-X><C-O>

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
  set ts=2 sts=2 sw=2 expandtab
  " Styles depending on file type
  autocmd FileType ruby setlocal ts=2 sts=2 sw=2 expandtab
  autocmd FileType python setlocal ts=4 sts=4 sw=4 expandtab

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




map ,d :call SwitchErbHighlight()<cr>
function SwitchErbHighlight ()
  if !exists('g:erbhi')
    let g:erbhi=1
 eruby   syn region erubySebas matchgroup=erubyDelimiter start="<%" end="%>" 
    hi Delimiter guifg=#3d3d3d
    hi erubySebas guifg=#3d3d3d
  else
    unlet g:erbhi
    hi Delimiter guifg=#00a0a0
    syntax off
    syntax on
  endif
endfunction

map ,f :CommandTFlush<cr>
function SwitchHtmlHighlight ()
  if !exists('g:erbhi')
    let g:erbhi=1
    syn region erubySebas start="<%" end="%>" 
    hi Delimiter guifg=#3d3d3d
    hi erubySebas guifg=#3d3d3d
  else
    unlet g:erbhi
    hi Delimiter guifg=#00a0a0
    syntax off
    syntax on
  endif
endfunction


" As seen on Vimcasts
" Use window movement with Ctrl-h instead of Ctrl-w h and so on
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

" As seen on Vimcasts, with a few changes by me

map <D-Right> gt
map <D-Left> gT
map <D-1> 1gt
map <D-2> 2gt
map <D-3> 3gt
map <D-4> 4gt
map <D-5> 5gt
map <D-6> 6gt
map <D-7> 7gt
map <D-8> 8gt
map <D-9> 9gt
map <D-0> :tablast<CR>

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
set statusline+=%#warningmsg#                 " Syntastic
set statusline+=%{SyntasticStatuslineFlag()}  "   "
set statusline+=%*                            "   "
set statusline+=%=                            " seperate between right- and left-aligned
set statusline+=%1*%y%*%*\                    " file type
set statusline+=%10((%l/%L)%)\                " line and column
set statusline+=%P                            " percentage of file
" Show it!
set laststatus=2
