" Basics {
    set nocompatible   " explicitly get out of vi-compatible mode
    syntax on          " syntax highlighting on
    set updatetime=200 " faster refresh time
" }

" Install vim-plug if not found
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif

" Run PlugInstall if there are missing plugins
autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \| PlugInstall --sync | source $MYVIMRC
\| endif

" vim-plug {
    call plug#begin('~/.vim/plugged')
    Plug 'airblade/vim-gitgutter'
    Plug 'chr4/nginx.vim'
    Plug 'dense-analysis/ale'
    Plug 'elixir-lang/vim-elixir'
    Plug 'scrooloose/nerdtree'
    Plug 'tmux-plugins/vim-tmux'
    Plug 'tmux-plugins/vim-tmux-focus-events'
    Plug 'tpope/vim-commentary'
    Plug 'tpope/vim-endwise'
    Plug 'tpope/vim-fugitive'
    Plug 'tpope/vim-projectionist'
    Plug 'tpope/vim-rails'
    Plug 'tpope/vim-rake'
    Plug 'tpope/vim-surround'
    Plug 'vim-airline/vim-airline'
    Plug 'vim-ruby/vim-ruby'
    Plug 'vim-test/vim-test'
    Plug 'wincent/command-t', { 'dir': '~/.vim/plugged/command-t', 'do': 'rake make' }
    call plug#end()         " required
" }

" General {
    filetype plugin indent on " load filetype plugins/indent settings
    set autochdir " always switch to the current file directory
    set directory=~/.vim/tmp " directory to place swap files in
    set fileformats=unix,mac,dos " support all three, in this order
    set undodir=~/.vim/undo
"}

" Vim UI {
    set background=dark
    highlight ExtraWhitespace ctermbg=darkred ctermfg=white guibg=darkred guifg=white
    highlight LineNr ctermbg=darkgray
    autocmd BufWinEnter * if &filetype != 'help' | match ExtraWhitespace /\t\+\|\s\+$/ | endif
    autocmd InsertEnter * if &filetype != 'help' | match ExtraWhitespace /\t\+\|\s\+\%#\@<!$/ | endif
    autocmd InsertLeave * if &filetype != 'help' | match ExtraWhitespace /\t\+\|\s\+$/ | endif
    autocmd BufWinLeave * call clearmatches()
    set incsearch "highlight the search phrase as you type
    set nohlsearch "highlight all matches
    set linespace=0 " don't insert any extra pixel lines betweens rows
    set list " we do what to show tabs, to ensure we get them out of my files
    set listchars=tab:◆◆, "show tabs '		' and trailing spaces  
    set laststatus=2 " always show the status line
    set number " turn on line numbers
    set numberwidth=4 " We are good up to 99999 lines
    set ruler " Always show current positions along the bottom
    set scrolloff=10 " Keep 10 lines (top/bottom) for scope
    set showcmd " show the command being typed
    set showmatch " show matching brackets
"}

" Text Formatting/Layout {
    set completeopt= " don't use a pop up menu for completions
    set ignorecase " case insensitive by default
    set infercase " case inferred by default
    set nowrap " do not wrap line
    set smartcase " if there are caps, go case-sensitive
    set expandtab " no real tabs please!
    set shiftwidth=2 " auto-indent amount when using cindent, >>, << and stuff like that
    set softtabstop=2 " when hitting tab or backspace, how many spaces should a tab be (see expandtab)
" }

" autoread {
    set autoread
    autocmd FocusGained,BufEnter,CursorHold,CursorHoldI * if mode() !~ '\v(c|r.?|!|t)' && getcmdwintype() == '' | checktime | endif
" }

" Vimrc {
    autocmd BufWritePost vimrc source %
" }

" NERDTree {
    map <silent> <LocalLeader>nf :NERDTreeFind<CR>
    map <silent> <LocalLeader>nr :NERDTree<CR>
    map <silent> <LocalLeader>nt :NERDTreeToggle<CR>
" }

" vim-airline {
    let g:airline_powerline_fonts = 1
" }
