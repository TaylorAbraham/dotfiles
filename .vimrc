""" PLUGINS (Using Vim-plug)
call plug#begin('~/.local/share/nvim/plugged')

Plug 'vim-airline/vim-airline' " A simple airline
Plug 'vim-airline/vim-airline-themes'
Plug 'chriskempson/base16-vim' " Colorscheme
Plug 'godlygeek/csapprox'
Plug 'sheerun/vim-polyglot' " More syntax highlighting
Plug 'junegunn/rainbow_parentheses.vim'
Plug 'tpope/vim-surround' " Autocomplete brackets
Plug 'easymotion/vim-easymotion'
Plug 'haya14busa/incsearch.vim'
Plug 'haya14busa/incsearch-fuzzy.vim'
Plug 'roxma/vim-tmux-clipboard'
Plug 'tmux-plugins/vim-tmux-focus-events'

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

set showcmd " Show incomplete commands at bottom-right

set autoread " Auto update file when externally changed

set clipboard^=unnamed " Use standard clipboard

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
colorscheme base16-hopscotch " Color scheme
let g:airline_theme='gruvbox' " Airline theme
let g:airline_powerline_fonts = 1 " Adds arrow character for airline to display properly
hi Normal ctermbg=none " Stops color scheme from overriding transparent backgrounds
hi NonText ctermbg=none

au VimEnter * RainbowParentheses " Enable rainbow parentheses on startup

let g:CSApprox_hook_post = [
            \ 'highlight Normal            ctermbg=NONE',
            \ 'highlight LineNr            ctermbg=NONE',
            \ 'highlight SignifyLineAdd    cterm=bold ctermbg=NONE ctermfg=green',
            \ 'highlight SignifyLineDelete cterm=bold ctermbg=NONE ctermfg=red',
            \ 'highlight SignifyLineChange cterm=bold ctermbg=NONE ctermfg=yellow',
            \ 'highlight SignifySignAdd    cterm=bold ctermbg=NONE ctermfg=green',
            \ 'highlight SignifySignDelete cterm=bold ctermbg=NONE ctermfg=red',
            \ 'highlight SignifySignChange cterm=bold ctermbg=NONE ctermfg=yellow',
            \ 'highlight SignColumn        ctermbg=NONE',
            \ 'highlight CursorLine        ctermbg=NONE cterm=underline',
            \ 'highlight Folded            ctermbg=NONE cterm=bold',
            \ 'highlight FoldColumn        ctermbg=NONE cterm=bold',
            \ 'highlight NonText           ctermbg=NONE',
            \ 'highlight clear LineNr'
            \]
