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
" }}}

" Vim-Plug {{{
call plug#begin('~/.vim/plugged')
Plug 'airblade/vim-gitgutter'
Plug 'altercation/vim-colors-solarized'
Plug 'dense-analysis/ale'
Plug 'neovim/nvim-lspconfig'
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
  autocmd FocusGained,BufEnter,CursorHold,CursorHoldI * if mode() !~ '\v(c|r.?|!|t)' && getcmdwintype() == '' | checktime | endif
  autocmd InsertEnter * if &filetype != 'help' | match ExtraWhitespace /\t\+\|\s\+\%#\@<!$/ | endif
  autocmd InsertLeave * if &filetype != 'help' | match ExtraWhitespace /\t\+\|\s\+$/ | endif
  autocmd QuickFixCmdPost    l* nested lwindow
  autocmd QuickFixCmdPost [^l]* nested cwindow
augroup END
" }}}

" Mappings {{{
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
" }}}

" nvim-lspconfig Config {{{
lua <<EOF
local nvim_lsp = require('lspconfig')
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')
  local opts = { noremap=true, silent=true }
  buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
  buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
end

nvim_lsp.bashls.setup {
  on_attach = on_attach,
}

nvim_lsp.solargraph.setup {
  on_attach = on_attach,
  settings = {
    solargraph = {
      autoformat = true,
      diagnostics = true,
      formatting = true,
      useBundler = true,
    }
  },
}
EOF
" }}}
