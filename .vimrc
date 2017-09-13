""" PLUGINS (Using Vim-plug)
call plug#begin('~/.local/share/nvim/plugged')

Plug 'vim-airline/vim-airline' " A simple airline
"Plug 'vim-airline/vim-airline-themes'
Plug 'sheerun/vim-polyglot' " More syntax highlighting
Plug 'junegunn/rainbow_parentheses.vim'
Plug 'tpope/vim-surround' " Autocomplete brackets
Plug 'easymotion/vim-easymotion'
Plug 'haya14busa/incsearch.vim'
Plug 'haya14busa/incsearch-fuzzy.vim'
Plug 'roxma/vim-tmux-clipboard'
Plug 'tmux-plugins/vim-tmux-focus-events'

" Initialize plugin system
call plug#end()


""" KEY BINDINGS
" Make B beginning of line and E end of line
noremap ^ <nop>
noremap $ <nop>
noremap B ^
noremap E $

" Visual mode * or # searches for the highlighted word
vnoremap <silent> * :<C-u>call VisualSelection('', '')<CR>/<C-R>=@/<CR><CR>
vnoremap <silent> # :<C-u>call VisualSelection('', '')<CR>?<C-R>=@/<CR><CR>

" Map <Space> to / (search) and Ctrl-<Space> to ? (backwards search)
map <space> /
map <c-space> ?

" Map fuzzy search
map z/ <Plug>(incsearch-fuzzy-/)
map z? <Plug>(incsearch-fuzzy-?)
map zg/ <Plug>(incsearch-fuzzy-stay)


""" SETTINGS
" Line numbering
set rnu	" Relative numbering
set nu	" Current line number

" Current line highlighting
set cursorline
hi CursorLine term=bold cterm=bold guibg=Grey40

set showcmd " Show incomplete commands at bottom-right

set autoread " Auto update file when externally changed

" Disable backups and swap files
set nobackup
set nowb
set noswapfile

" Tabs and spacing
set tabstop=2
set shiftwidth=2
set softtabstop=2
set autoindent
set expandtab " Automatically convert tabs to spaces
set smartindent

set ttimeoutlen=10 " Faster to exit insert mode

""" THEME
let g:airline_powerline_fonts = 1 " Adds arrow character for airline to display properly

"colorscheme molokai " Color scheme
"let g:airline_theme='molokai' " Airline theme

au VimEnter * RainbowParentheses " Enable rainbow parentheses on startup

set clipboard^=unnamed
