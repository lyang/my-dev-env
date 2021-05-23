" vim: set foldmethod=marker foldlevel=0 nomodeline:
" Basics {{{
set encoding=utf-8
set fileformats=unix,mac,dos
set nocompatible
" }}}

" Advanced {{{
highlight ExtraWhitespace ctermbg=darkred ctermfg=white guibg=darkred guifg=white
set autoread
set directory=~/.vim/tmp
set expandtab
set hlsearch
set ignorecase
set incsearch
set infercase
set linespace=0
set list
set listchars=tab:◆◆,
set nowrap
set shiftwidth=2
set smartcase
set softtabstop=2
set undodir=~/.vim/undo
set undofile
set undolevels=1000
set undoreload=10000
set updatetime=200
" }}}

" UI {{{
set background=dark
colorschem solarized
set laststatus=2
set number
set numberwidth=4
set ruler
set scrolloff=10
set showcmd
set showmatch
set completeopt=menuone,preview
" }}}

" Plugin Config {{{
let g:airline_powerline_fonts = 1
let g:airline_theme = 'powerlineish'
let g:ale_disable_lsp = 1
let g:ale_sign_column_always = 1
" }}}

" Vim-Plug {{{
call plug#begin('~/.vim/plugged')
Plug 'airblade/vim-gitgutter'
Plug 'altercation/vim-colors-solarized'
Plug 'chr4/nginx.vim', { 'for': 'nginx' }
Plug 'dense-analysis/ale'
Plug 'elixir-lang/vim-elixir', { 'for': 'elixir' }
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'ntpeters/vim-better-whitespace'
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'tmux-plugins/vim-tmux'
Plug 'tmux-plugins/vim-tmux-focus-events'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-projectionist'
Plug 'tpope/vim-rails'
Plug 'tpope/vim-rake'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'vim-ruby/vim-ruby'
Plug 'vim-test/vim-test'
call plug#end()
" }}}

" Auto Command {{{
augroup MyAutoCmd
  autocmd!
  autocmd BufRead,BufNewFile *bundler/config set filetype=yaml
  autocmd BufRead,BufNewFile cookiecutterrc set filetype=yaml
  autocmd BufRead,BufNewFile gitconfig set filetype=gitconfig
  autocmd BufWinEnter * if &filetype != 'help' | match ExtraWhitespace /\t\+\|\s\+$/ | endif
  autocmd BufWinLeave * call clearmatches()
  autocmd BufWritePost vimrc source %
  autocmd FocusGained,BufEnter,CursorHold,CursorHoldI * if mode() !~ '\v(c|r.?|!|t)' && getcmdwintype() == '' | checktime | endif
  autocmd InsertEnter * if &filetype != 'help' | match ExtraWhitespace /\t\+\|\s\+\%#\@<!$/ | endif
  autocmd InsertLeave * if &filetype != 'help' | match ExtraWhitespace /\t\+\|\s\+$/ | endif
  autocmd QuickFixCmdPost    l* nested lwindow
  autocmd QuickFixCmdPost [^l]* nested cwindow
augroup END
" }}}

" Mappings {{{
nnoremap <silent> <LocalLeader>fb :Buffers<CR>
nnoremap <silent> <LocalLeader>ff :Files<CR>
nnoremap <silent> <LocalLeader>fg :GFiles<CR>
nnoremap <silent> <LocalLeader>ft :Tags<CR>
nnoremap <silent> <LocalLeader>gw :Ggrep! <cword><CR><CR>
nnoremap <silent> <LocalLeader>nf :NERDTreeFind<CR>
nnoremap <silent> <LocalLeader>nr :NERDTree<CR>
nnoremap <silent> <LocalLeader>nt :NERDTreeToggle<CR>
" }}}
