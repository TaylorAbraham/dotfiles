set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" Utilities
" Plugin 'SirVer/ultisnips' " Code snippets
Plugin 'godlygeek/csapprox'
Plugin 'tpope/vim-surround' " Fix surroundings
Plugin 'jiangmiao/auto-pairs' " Autocomplete surroundings
Plugin 'easymotion/vim-easymotion'
Plugin 'haya14busa/incsearch.vim'
Plugin 'haya14busa/incsearch-fuzzy.vim'
Plugin 'roxma/vim-tmux-clipboard'
Plugin 'tmux-plugins/vim-tmux-focus-events'
Plugin 'tpope/vim-commentary' " Easy comments
" Plugin 'scrooloose/nerdtree' " Folder hierarchy tree
" Colors and themes
Plugin 'rafi/awesome-vim-colorschemes' " Collection of colorschemes
Plugin 'hdima/python-syntax' " Better Python syntax highlighting
Plugin 'vim-airline/vim-airline' " A simple airline
Plugin 'vim-airline/vim-airline-themes'
Plugin 'junegunn/rainbow_parentheses.vim'
" Autocomplete and syntax highlighting
" Plugin 'Valloric/YouCompleteMe', { 'do': './install.py'  }
Plugin 'alvan/vim-closetag' " Autoclose html tags
Plugin 'sheerun/vim-polyglot' " More syntax highlighting
Plugin 'tpope/vim-rails' " Better RoR
Plugin 'mattn/emmet-vim' " HTML snippets

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
Plugin 'tpope/vim-fugitive'
" plugin from http://vim-scripts.org/vim/scripts.html
" Plugin 'L9'
" Git plugin not hosted on GitHub
Plugin 'git://git.wincent.com/command-t.git'
" git repos on your local machine (i.e. when working on your own plugin)
Plugin 'file:///home/gmarik/path/to/plugin'
" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
" Install L9 and avoid a Naming conflict if you've already installed a
" different version somewhere else.
" Plugin 'ascenator/L9', {'name': 'newL9'}

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ


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
