""" PLUGINS (Using Vim-plug)
call plug#begin('~/.vim/plugged')

" Utilities
Plug 'SirVer/ultisnips' " Code snippets
Plug 'godlygeek/csapprox'
Plug 'tpope/vim-surround' " Fix surroundings
Plug 'jiangmiao/auto-pairs' " Autocomplete surroundings
Plug 'easymotion/vim-easymotion'
Plug 'haya14busa/incsearch.vim'
Plug 'haya14busa/incsearch-fuzzy.vim'
Plug 'roxma/vim-tmux-clipboard'
Plug 'tmux-plugins/vim-tmux-focus-events'
Plug 'tpope/vim-commentary' " Easy comments
Plug 'scrooloose/nerdtree' " Folder hierarchy tree
" Colors and themes
Plug 'rafi/awesome-vim-colorschemes' " Collection of colorschemes
Plug 'hdima/python-syntax' " Better Python syntax highlighting
Plug 'vim-airline/vim-airline' " A simple airline
Plug 'vim-airline/vim-airline-themes'
Plug 'junegunn/rainbow_parentheses.vim'
" Autocomplete and syntax highlighting
Plug 'Valloric/YouCompleteMe', { 'do': './install.py'  }
Plug 'alvan/vim-closetag' " Autoclose html tags
Plug 'sheerun/vim-polyglot' " More syntax highlighting
Plug 'tpope/vim-rails' " Better RoR
Plug 'mattn/emmet-vim' " HTML snippets

call plug#end()


""" KEY BINDINGS
" Make B beginning of line and E end of line
noremap ^ <nop>
noremap $ <nop>
noremap B ^
noremap E $

" Map <Space> to / (search) and Ctrl-<Space> to ? (backwards search)
map <space> /
map <c-space> ?

" Map // to search for visual selection
vnoremap // y/<C-R>"<CR>"

" Map fuzzy search
map z/ <Plug>(incsearch-fuzzy-/)
map z? <Plug>(incsearch-fuzzy-?)
map zg/ <Plug>(incsearch-fuzzy-stay)

" Buffers
" Move to the previous buffer with 'gp'
nnoremap gp :bp<CR>
" Move to the next buffer with 'gn'
nnoremap gn :bn<CR>
" Delete buffer with 'gd'
nnoremap gd :bd<CR>
" List all possible buffers with 'gl'
nnoremap gl :ls<CR>
" List all possible buffers with 'gb' and accept a new buffer argument [1]
nnoremap gb :ls<CR>:b
set hidden " Enable hidden buffers, so you can switch buffers without saving


""" SETTINGS

" Open splits at bottom/right instead of top/left
set splitbelow
set splitright

set showcmd " Show incomplete commands at bottom-right

set autoread " Auto update file when externally changed

set clipboard^=unnamed " Use standard clipboard

" Tabs and spacing
set tabstop=2
set shiftwidth=2
set softtabstop=2
set autoindent
set expandtab " Automatically convert tabs to spaces

autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o " No autocomments

set ttimeoutlen=10 " Faster to exit insert mode

" NERDTree
" Toggle NERDTree with CTRL+N
map <C-n> :NERDTreeToggle<CR>
" Open NERDTree when opening folder
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif
" Open NERDTree when opening empty file
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

""" THEME AND VISUALS
set background=dark
let g:gruvbox_italic=0
let g:gruvbox_contrast_dark='hard'
colorscheme gruvbox
let g:airline_theme='jellybeans' " Airline theme
let g:airline_powerline_fonts = 1 " Adds arrow character for airline to display properly
let g:airline#extensions#tabline#enabled = 1

let g:airline_section_z = airline#section#create(['windowswap', '%3p%% ', 'linenr', ':%3v'])

let python_highlight_all = 1

au VimEnter * RainbowParentheses " Enable rainbow parentheses on startup

" Line numbering
set rnu	" Relative numbering
set nu	" Current line number

" Highlight active line
set cursorline
" For a transparent terminal
hi CursorLine term=bold cterm=bold guibg=NONE ctermbg=NONE
hi Normal guibg=NONE ctermbg=NONE
" Cursorline for opaque terminal
"hi CursorLine term=bold cterm=bold guibg=Grey40

""" YCM
" Start autocompletion after 4 chars
"let g:ycm_min_num_of_chars_for_completion = 4
"let g:ycm_min_num_identifier_candidate_chars = 4
let g:ycm_enable_diagnostic_highlighting = 0
" Don't show YCM's preview window [ I find it really annoying ]
set completeopt-=preview
let g:ycm_add_preview_to_completeopt = 0

