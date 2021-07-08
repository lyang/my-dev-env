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
set hidden
set hlsearch
set ignorecase
set incsearch
set infercase
set linespace=0
set list
set listchars=tab:◆◆,
set nobackup
set nowrap
set nowritebackup
set shiftwidth=2
set shortmess+=c
set smartcase
set softtabstop=2
set undodir=~/.vim/undo
set undofile
set undolevels=1000
set undoreload=10000
set updatetime=200
" }}}

" Plugin Config {{{
let g:airline#extensions#ale#enabled = 1
let g:airline_powerline_fonts = 1
let g:airline_theme = 'powerlineish'
let g:ale_disable_lsp = 1
let g:ale_list_window_size = 5
let g:ale_open_list = 1
let g:ale_sign_column_always = 1
let g:coc_global_extensions = ['coc-git', 'coc-highlight', 'coc-json', 'coc-solargraph']
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
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'ntpeters/vim-better-whitespace'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'preservim/nerdtree'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
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
Plug 'xuyuanp/nerdtree-git-plugin'

Plug 'ryanoasis/vim-devicons'
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
  autocmd BufWritePost init.vim source %
  autocmd CursorHold * silent call CocActionAsync('highlight')
  autocmd FocusGained,BufEnter,CursorHold,CursorHoldI * if mode() !~ '\v(c|r.?|!|t)' && getcmdwintype() == '' | checktime | endif
  autocmd InsertEnter * if &filetype != 'help' | match ExtraWhitespace /\t\+\|\s\+\%#\@<!$/ | endif
  autocmd InsertLeave * if &filetype != 'help' | match ExtraWhitespace /\t\+\|\s\+$/ | endif
  autocmd QuickFixCmdPost    l* nested lwindow
  autocmd QuickFixCmdPost [^l]* nested cwindow
augroup END
" }}}

" Mappings {{{
inoremap <silent><expr> <S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
inoremap <silent><expr> <TAB> pumvisible() ? "\<C-n>" : <SID>check_back_space() ? "\<TAB>" : coc#refresh()
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nmap <silent> gy <Plug>(coc-type-definition)
nnoremap <leader>fa <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope git_files<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>
nnoremap <leader>ft <cmd>Telescope tags<cr>
nnoremap <silent> <LocalLeader>gw :Ggrep! <cword><CR><CR>
nnoremap <silent> <LocalLeader>nf :NERDTreeFind<CR>
nnoremap <silent> <LocalLeader>nr :NERDTree<CR>
nnoremap <silent> <LocalLeader>nt :NERDTreeToggle<CR>
nnoremap <silent> <LocalLeader>rn <Plug>(coc-rename)
nnoremap <silent> K :call<SID>show_documentation()<CR>
" }}}

" Functions {{{
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction
" }}}

" UI {{{
set background=dark
colorschem solarized
set completeopt=menuone,preview
set laststatus=2
set number
set numberwidth=4
set ruler
set scrolloff=10
set showcmd
set showmatch
" }}}

" nvim-treesitter Config {{{
lua <<EOF
require'nvim-treesitter.configs'.setup {
  ensure_installed = "maintained",
  highlight = {
    enable = true
  },
  indent = {
    true
  },
}
EOF
set foldexpr=nvim_treesitter#foldexpr()
set foldmethod=expr
" }}}
