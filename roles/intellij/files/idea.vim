" vim: set foldmethod=marker foldlevel=0 nomodeline:

" IDEA Specific Settings {{{
set ideajoin
set ideamarks
set ideastatusicon=enabled
set idearefactormode=keep
set ideawrite=all
" }}}

" Vim Settings {{{
set hlsearch
set ignorecase
set incsearch
set number
set scrolloff=5
set showmode
set showcmd
set smartcase
set softtabstop=2
set undolevels=1000
set visualbell
set wrapscan
" }}}

" Plugin Config {{{
let g:argtextobj_pairs="[:],(:),<:>"
" }}}

" Plugins {{{
set NERDTree
set argtextobj
set commentary
set easymotion
set highlightedyank
set surround
" }}}

" Mappings {{{
map K <Action>(QuickJavaDoc)
map gd <Action>(GotoDeclaration)
map gi <Action>(GotoImplementation)
map gr <Action>(ShowUsages)
map gt <Action>(GotoTypeDeclaration)
map <leader>rn <Action>(RenameElement)
map <leader>ff <Action>(GotoFile)
map <leader>fb <Action>(RecentFiles)
map <leader>ft <Action>(GotoSymbol)
map <leader>nf :NERDTreeFind<CR>
map <leader>nr :NERDTree<CR>
map <leader>nt :NERDTreeToggle<CR>
" }}}
