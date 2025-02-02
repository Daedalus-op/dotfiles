" Plugins ______________________________________________________________________ 

call plug#begin()

	" Component
" Plug 'preservim/nerdtree'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'vimwiki/vimwiki'
Plug 'ptzz/lf.vim'
Plug 'voldikss/vim-floaterm'

	" Interactiions
Plug 'psliwka/vim-smoothie'
Plug 'matze/vim-move'

	" Themes
Plug 'ayu-theme/ayu-vim'
Plug 'cocopon/iceberg.vim'
Plug 'effkay/argonaut.vim'
Plug 'owickstrom/vim-colors-paramount'
Plug 'eskilop/NorthernLights.vim'

	" Local sourced

	" Extra
Plug 'mhinz/vim-startify'

call plug#end()


" Colors ______________________________________________________________________ 

set background=dark
highlight Visual ctermfg=DarkBlue
let g:smoothie_experimental_mappings = 1
let g:airline_powerline_fonts = 1

" vim settings ______________________________________________________________________ 

set guioptions-=m
set autochdir
set foldmethod=indent
set ic 
set hlsearch
set incsearch
set noshowmode
set number
set relativenumber
set laststatus=2
let &fillchars ..= ',eob: '
set nocompatible
filetype plugin on
syntax on
set tabstop=4
set shiftwidth=4

let g:NERDTreeHijackNetrw = 0 " Add this line if you use NERDTree
let g:lf_replace_netrw = 1 " Open lf when vim opens a directory

" vim-airline settings ______________________________________________________________________ 

let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline#extensions#tabline#formatter = 'jsformatter'
let g:airline_theme='iceberg'


" Keybinds ______________________________________________________________________ 

let mapleader = " "

	" Convinience
map <A-n> 0i<CR><ESC>k
map <C-n> o<ESC>
imap ;; <ESC>
map <C-a> ggVG
noremap <A-a> GVgg
map <C-s> :w<CR>
vmap cy "+y
map cp "+p
map cp "+p

	" NERDTree / Lf
" nmap <silent> <leader>e :NERDTreeToggle<CR>
" map <silent> <C-e> <ESC>:NERDTreeToggle<CR>
let g:lf_map_keys = 0
map <silent> <C-e> <ESC>:Lf<CR>
nmap <silent> <leader>e :Lf<CR>

	" Buffers
nmap <leader>l :bn<CR>
map <C-tab> :bn<CR>
nmap <leader>h :bp<CR>
map <C-S-tab> :bp<CR>
nmap <silent> <C-q> :q<CR>
nmap <leader>c :bd<CR>
map <C-c> :bd<CR>
nmap <leader>b :ls<CR>:b 
nmap <leader>v :ls<CR>:vertical sb 
nmap <leader>s :w<CR>
nmap <leader>w :w<CR>
nmap <leader>q :q<CR>
nmap <C-h> :Startify<CR>

	" FTerm
nmap <leader>fn :FloatermNew<CR>
nmap <leader>ff :FloatermToggle<CR>
nmap <leader>g :FloatermNew --wintype=float --name=lazygit --autoclose=2 --cmd="cd lazygit"<CR>
nmap <leader>fv :vert term<CR><C-w>L
tnoremap <silent> ;; <C-\><C-n>:FloatermToggle <CR>
tnoremap <silent> <ESC><ESC> <C-\><C-n>
