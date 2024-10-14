" Plugins ______________________________________________________________________ 

call plug#begin()

	" Component
Plug 'preservim/nerdtree'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'voldikss/vim-floaterm'
Plug 'vimwiki/vimwiki'

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

call plug#end()


" Colors ______________________________________________________________________ 

set background=dark
"set termguicolors
"colorscheme ayu
highlight Visual ctermfg=DarkBlue
let g:smoothie_experimental_mappings = 1
let g:airline_powerline_fonts = 1


" vim settings ______________________________________________________________________ 

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


" vim-airline settings ______________________________________________________________________ 

let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline#extensions#tabline#formatter = 'jsformatter'
let g:airline_theme='iceberg'


" Float Term ______________________________________________________________________ 



" Keybinds ______________________________________________________________________ 

let mapleader = " "

	" Convinience
nmap <A-n> 0i<CR><ESC>k
nmap <C-n> A<CR><ESC>
imap ;; <ESC>
nmap <C-a> ggVG
nmap <A-a> GVgg
vmap cy "+y
vmap cp "+p
nmap cp "+p

	" NERDTree
nmap <C-e> :NERDTreeToggle<CR>
nmap <leader>e :NERDTreeToggle<CR>
imap <C-e> <ESC>:NERDTreeToggle<CR>

	" Buffers
nmap <leader>l :bn<CR>
nmap <leader>h :bp<CR>
nmap <C-q> :q<CR>
nmap <leader>c :bd<CR>
nmap <leader>b :ls<CR>:b 
nmap <leader>v :ls<CR>:vertical sb 
nmap <leader>s :w<CR>
nmap <leader>w :w<CR>
nmap <leader>q :q<CR>

	" FTerm
nmap <leader>ft :FloatermNew<CR>
nmap <leader>ff :FloatermToggle<CR>
nmap <leader>g :FloatermNew --wintype=float --name=lazygit --autoclose=2 --cmd="cd lazygit"<CR>
nmap <leader>fv :vert term<CR><C-w>L
tnoremap <silent> ;; <C-\><C-n>:FloatermToggle <CR>
