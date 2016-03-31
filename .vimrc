" #################################################################j############
" # GENERAL SETTINGS                                                           #
" ##############################################################################

" Use the Pathogen plugin to install plugins and
" runtime files in their own private directories
runtime plugins/pathogen/autoload/pathogen.vim

call pathogen#infect("plugins")
call pathogen#infect()
call pathogen#helptags()

syntax on                         " Enable syntax highlighting

if has("autocmd")
    filetype plugin indent on
    "           │     │    └─────── Enable file type detection
    "           │     └──────────── Enable loading of indent file
    "           └────────────────── Enable loading of plugin files
endif

set ttymouse=xterm2
set lazyredraw
set ttyscroll=3

set t_Co=256                      " Enable full-color support
set autoindent                    " Copy indent to the new line
set background=dark               " Use colors that look good on a dark bg
colorscheme iceberg

set backspace=indent              " ┐ set backspace+=eol                " │ Allow `backspace` in insert mode
set backspace+=start              " ┘

set backupdir=~/.vim/backups      " Set directory for backup files

" set clipboard=unnamed             " ┐
"                                   " │ Use the system clipboard
" if has("unnamedplus")             " │ as the default register
"     set clipboard+=unnamedplus    " │
" endif                             " ┘

set cpoptions+=$                  " When making a change, don't redisplay the
                                  " line, and instead, put a `$` sign at the
                                  " end of the changed text

set colorcolumn=81                " Highlight certain columns

set directory=~/.vim/swaps        " Set directory for swap files
set encoding=utf-8 nobomb         " Use UTF-8 without BOM
set history=5000                  " Increase command line history
set hlsearch                      " Enable search highlighting
set ignorecase                    " Ignore case in search patterns
set incsearch                     " Highlight search pattern as it's being typed
set laststatus=2                  " Always show the status line

set listchars=tab:▸\              " ┐
set listchars+=trail:·            " │ Use custom symbols to
set listchars+=eol:↴              " │ represent invisible characters
set listchars+=nbsp:_             " ┘

set magic                         " Enable extended regexp
set mousehide                     " Hide mouse pointer while typing
set nocompatible                  " Don't make vim, vi-compatibile
set noerrorbells                  " Disable error bells

set nojoinspaces                  " When using the join command, only insert a
                                  " single space after a `.`, `?` or `!`

set nostartofline                 " Kept the cursor on the same column
set number                        " Show line number

set numberwidth=4                 " Increase the minimal number of columns used
                                  " for the `line number`

set report=0                      " Report the number of lines changed
set ruler                         " Show cursor position

set scrolloff=5                   " When scrolling, keep the cursor 5 lines
                                  " below the top and 5 lines above the bottom
                                  " of the screen

set shortmess=aAItW               " Avoid all the hit-enter prompts
set showcmd                       " Show the (partial) command being typed
set noshowmode                      " Show current mode
set spelllang=en_us               " Use `en_us` as the spellchecking language

set smartcase                     " Override `ignorecase` option if the search
                                  " pattern contains uppercase characters

set synmaxcol=2500                " Limit syntax highlighting (this avoids the
                                  " very slow redrawing when files contain long
                                  " lines)

set tabstop=4                     " ┐
set softtabstop=4                 " │ Set global <TAB> settings
set shiftwidth=4                  " │ http://vimcasts.org/e/2
set expandtab                     " ┘

set ttyfast                       " Enable fast terminal connection
set undodir=~/.vim/undos          " Set directory for undo files
set undofile                      " Automatically save undo history
set virtualedit=all               " Allow cursor to be positioned anywhere

set visualbell                    " ┐
set noerrorbells                  " │ Disable beeping and window flashing
set t_vb=                         " ┘ http://vim.wikia.com/wiki/Disable_beeping

set wildmenu                      " Enable enhanced command-line completion (by
                                  " hitting <TAB> in command mode, vim will show
                                  " the possible matches just above the command
                                  " line with the first match highlighted)

set winminheight=0                " Allow windows to be squashed to 0 lines

" set guifont=Droid\ Sans\ Mono\ for\ Powerline:h16 "set font
if has("gui_running")
  if has("gui_gtk2")
    set guifont=Monospace\ 11
  elseif has("gui_macvim")
    set guifont=Menlo\ Regular:h14
  elseif has("gui_win32")
    set guifont=Consolas:h11:cANSI
  endif
endif


" ------------------------------------------------------------------------------
" | Automatic Commands                                                         |
" ------------------------------------------------------------------------------

if has("autocmd")

    " Automatically switch to absolute line numbers when vim loses focus
    autocmd FocusLost * :set number
    " Automatically switch to relative line numbers when vim gains focus
    autocmd FocusGained * :set relativenumber
    " Automatically switch to absolute line numbers when vim is in insert mode
    autocmd InsertEnter * :set number
    " Automatically switch to relative line numbers when vim is in normal mode
    autocmd InsertLeave * :set relativenumber

    " Custom syntax for different languages
    autocmd FileType javascript setlocal ts=2 sts=2 sw=2 expandtab
    autocmd FileType json setlocal ts=2 sts=2 sw=2 expandtab
    autocmd BufNewFile,BufReadPost *.coffee setl shiftwidth=2 ts=2 sts=2 sw=2 expandtab
    autocmd FileType jade setlocal ts=2 sts=2 sw=2 expandtab
    autocmd FileType html setlocal ts=2 sts=2 sw=2 expandtab
    autocmd FileType less setlocal ts=2 sts=2 sw=2 expandtab

    " Treat `.json` files as JavaScript
    " autocmd BufNewFile, BufRead *.json setfiletype json syntax=javascript

    " Strip trailing whitespace automatically when the file is saved
    autocmd BufWritePre * :call StripWhitespaces()

endif

" ------------------------------------------------------------------------------
" | Highlighting                                                               |
" ------------------------------------------------------------------------------

" Terminal types:
"
"   1) term  (normal terminals, e.g.: vt100, xterm)
"   2) cterm (color terminals, e.g.: MS-DOS console, color-xterm)
"   3) gui   (GUIs)

" highlight ColorColumn                              ctermbg=Cyan

set statusline=%1*\ [%n]\ [%f]%m%r%h%w%y[%{&ff}:%{strlen(&fenc)?&fenc:'none'}]%=%(\ %c,%l/%L\ %)%P
"               │     │     │  │ │ │ │ │    │                │                 │     │ │   │    └─ percent through file
"               │     │     │  │ │ │ │ │    │                │                 │     │ │   └─ total number of lines
"               │     │     │  │ │ │ │ │    │                │                 │     │ └─ current line number
"               │     │     │  │ │ │ │ │    │                │                 │     └─ current column number
"               │     │     │  │ │ │ │ │    │                │                 └─ left/right separator
"               │     │     │  │ │ │ │ │    │                └─ file encoding
"               │     │     │  │ │ │ │ │    └─ file format
"               │     │     │  │ │ │ │ └─ file type
"               │     │     │  │ │ │ └─ preview window flag
"               │     │     │  │ │ └─ help file flag
"               │     │     │  │ └─ readonly flag
"               │     │     │  └─ modified flag
"               │     │     └─ path to the file
"               │     └─ buffer number
"               └─ User1 highlight

" ------------------------------------------------------------------------------
" | Key Mappings                                                               |
" ------------------------------------------------------------------------------

" Use a different mapleader (default is "\")
let mapleader = ","

" Redefine trigger key for Emmet
" http://docs.emmet.io/cheat-sheet/
let g:user_emmet_leader_key='<C-E>'

" [,* ] Search and replace the word under the cursor
nnoremap <leader>* :%s/\<<C-r><C-w>\>//<Left>

" [,cc] Toggle code comments
" https://github.com/tomtom/tcomment_vim
noremap <leader>cc :TComment<CR>

" [,cr] Calculate result
" http://vimcasts.org/e/56
nnoremap <leader>cr 0yt=A<C-r>=<C-r>"<CR><Esc>

" [,cs] Clear search
map <leader>cs <Esc>:noh<CR>

" [,h ] JSHint the code
" https://github.com/Shutnik/jshint2.vim
nnoremap <leader>h :JSHint<CR>

" [,l ] Toggle `set list`
nmap <leader>l :set list!<CR>

" [,n ] Toggle `set relativenumber`
" http://jeffkreeftmeijer.com/2012/relative-line-numbers-in-vim-for-super-fast-movement/
function! ToggleRelativeLineNumbers()

    if ( &relativenumber == 1 )
        set number
    else
        set relativenumber
    endif

endfunction

nnoremap <leader>n :call ToggleRelativeLineNumbers()<CR>

" [,sl] Toggle show limits
function! ToggleLimits()

    " [51,73]
    "   - git commit message
    "     http://tbaggery.com/2008/04/19/a-note-about-git-commit-messages.html
    " [81]
    "   - general use

    if ( &colorcolumn == "81" )
        set colorcolumn+=51,73
    else
        set colorcolumn-=51,73
    endif

endfunction

nnoremap <leader>sl :call ToggleLimits()<CR>

" [,ss] Strip whitespace
function! StripWhitespaces()

    " save last search and cursor position
    let searchHistory = @/
    let cursorLine = line(".")
    let cursorColumn = col(".")

    " strip trailing whitespaces
    %s/\s\+$//e

    " merge consecutive empty lines
    "g/^\s*$/,/\S/-j

    " restore previous search history and cursor position
    let @/ = searchHistory
    call cursor(cursorLine, cursorColumn)

endfunction

nnoremap <leader>ss :call StripWhitespaces()<CR>

" [,v ] Make the opening of the `.vimrc` file easier
nmap <leader>v :vsp $MYVIMRC<CR>

" [,W ] Sudo write
noremap <leader>W :w !sudo tee %<CR>


" ##############################################################################
" # PLUGIN RELATED SETTINGS                                                    #
" ##############################################################################

" ------------------------------------------------------------------------------
" | Emmet                                                                      |
" ------------------------------------------------------------------------------

" Custom Emmet snippets
" http://docs.emmet.io/customization/snippets/
let NERDTreeShowHidden=1
map <silent><C-n> :NERDTreeToggle<ENTER>

" markdown
let g:vim_markdown_folding_disabled = 1
let g:vim_markdown_no_default_key_mappings = 1

" buffer
map <F2> :MBEbn<cr>
map <F3> :MBEbp<cr>

" session
let g:startify_session_persistence = 1
let g:startify_session_delete_buffers = 1
let g:startify_restore_positioon = 1
let g:startify_custom_header = [
                \ '   __      ___            ______ ____   ',
                \ '   \ \    / (_)           |____  |___ \ ',
                \ '    \ \  / / _ _ __ ___       / /  __) |',
                \ '     \ \/ / | | ''_ ` _ \     / /  |__ <',
                \ '      \  /  | | | | | | |   / /   ___) |',
                \ '       \/   |_|_| |_| |_|  /_(_) |____/ ',
                \ '',
                \ '',
                \ ]
hi StartifyBracket ctermfg=240 guifg=#A36FC5
hi StartifyNumber  ctermfg=215 guifg=#E8D069
hi StartifyPath    ctermfg=245 guifg=#4CB5DC
hi StartifySlash   ctermfg=240 guifg=#CD3F45
hi StartifySpecial ctermfg=240 guifg=#CD3F45
hi StartifyHeader  ctermfg=114 guifg=#4CB5DC
hi StartifyFooter  ctermfg=240 guifg=#A36FC5

"airline
let g:airline_powerline_fonts = 1
let g:airline_theme = 'molokai'

"tmux
if exists('$TMUX')
  function! TmuxOrSplitSwitch(wincmd, tmuxdir)
    let previous_winnr = winnr()
    silent! execute "wincmd " . a:wincmd
    if previous_winnr == winnr()
      call system("tmux select-pane -" . a:tmuxdir)
      redraw!
    endif
  endfunction

  let previous_title = substitute(system("tmux display-message -p '#{pane_title}'"), '\n', '', '')
  let &t_ti = "\<Esc>]2;vim\<Esc>\\" . &t_ti
  let &t_te = "\<Esc>]2;". previous_title . "\<Esc>\\" . &t_te

  nnoremap <silent> <C-h> :call TmuxOrSplitSwitch('h', 'L')<cr>
  nnoremap <silent> <C-j> :call TmuxOrSplitSwitch('j', 'D')<cr>
  nnoremap <silent> <C-k> :call TmuxOrSplitSwitch('k', 'U')<cr>
  nnoremap <silent> <C-l> :call TmuxOrSplitSwitch('l', 'R')<cr>
else
  map <C-h> <C-w>h
  map <C-j> <C-w>j
  map <C-k> <C-w>k
  map <C-l> <C-w>l
endif

"indent lines
let g:indentLine_noConcealCursor=1

" neocomplete
" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
" Use neocomplete.
let g:neocomplete#enable_at_startup = 1
" Use smartcase.
let g:neocomplete#enable_smart_case = 1
" Set minimum syntax keyword length.
let g:neocomplete#sources#syntax#min_keyword_length = 2
let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'
set completeopt-=preview

" Define dictionary.
let g:neocomplete#sources#dictionary#dictionaries = {
    \ 'default' : '',
    \ 'vimshell' : $HOME.'/.vimshell_hist',
    \ 'scheme' : $HOME.'/.gosh_completions'
        \ }

" Define keyword.
if !exists('g:neocomplete#keyword_patterns')
    let g:neocomplete#keyword_patterns = {}
endif
let g:neocomplete#keyword_patterns['default'] = '\h\w*'

" Plugin key-mappings.
inoremap <expr><C-g>     neocomplete#undo_completion()
inoremap <expr><C-l>     neocomplete#complete_common_string()

" Recommended key-mappings.
" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  return neocomplete#close_popup() . "\<CR>"
  " For no inserting <CR> key.
  "return pumvisible() ? neocomplete#close_popup() : "\<CR>"
endfunction
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><C-y>  neocomplete#close_popup()
inoremap <expr><C-e>  neocomplete#cancel_popup()
" Close popup by <Space>.
"inoremap <expr><Space> pumvisible() ? neocomplete#close_popup() : "\<Space>"

" For cursor moving in insert mode(Not recommended)
"inoremap <expr><Left>  neocomplete#close_popup() . "\<Left>"
"inoremap <expr><Right> neocomplete#close_popup() . "\<Right>"
"inoremap <expr><Up>    neocomplete#close_popup() . "\<Up>"
"inoremap <expr><Down>  neocomplete#close_popup() . "\<Down>"
" Or set this.
"let g:neocomplete#enable_cursor_hold_i = 1
" Or set this.
"let g:neocomplete#enable_insert_char_pre = 1

" AutoComplPop like behavior.
"let g:neocomplete#enable_auto_select = 1

" Shell like behavior(not recommended).
"set completeopt+=longest
"let g:neocomplete#enable_auto_select = 1
"let g:neocomplete#disable_auto_complete = 1
"inoremap <expr><TAB>  pumvisible() ? "\<Down>" : "\<C-x>\<C-u>"

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=python3complete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" Enable heavy omni completion.
if !exists('g:neocomplete#sources#omni#input_patterns')
  let g:neocomplete#sources#omni#input_patterns = {}
endif
"let g:neocomplete#sources#omni#input_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
"let g:neocomplete#sources#omni#input_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
"let g:neocomplete#sources#omni#input_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'

" For perlomni.vim setting.
" https://github.com/c9s/perlomni.vim
let g:neocomplete#sources#omni#input_patterns.perl = '\h\w*->\h\w*\|\h\w*::'

" Vim-Go
au FileType go nmap <Leader>r <Plug>(go-run)
au FileType go nmap <leader>i <Plug>(go-info)
let g:go_highlight_operators = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1

" VimShell
nnoremap ,s :VimShellTab -create<Enter>
let g:vimshell_prompt = '$'
let g:vimshell_prompt_expr =
            \ 'escape(fnamemodify(getcwd(), ":~").">", "\\[]()?! ")." "'
let g:vimshell_prompt_pattern = '^\%(\f\|\\.\)\+> '


" pymode
let g:pymode_lint_cwindow = 0
let g:pymode_rope = 0

" ##############################################################################
" # LOCAL SETTINGS                                                             #
" ##############################################################################

" Load local settings if they exist
if filereadable(glob("~/.vimrc.local"))
    source ~/.vimrc.local
endif

nnoremap <up> <nop>
nnoremap <down> <nop>
nnoremap <left> <nop>
nnoremap <right> <nop>
inoremap <esc> <nop>

nnoremap j gj
nnoremap k gk
nnoremap <C-j> <C-W>j
nnoremap <C-k> <C-W>k
nnoremap <C-h> <C-W>h
nnoremap <C-l> <C-W>l
inoremap jk <esc>
inoremap [3~ <Del>

" tab switch
nmap <D-1> <C-PageUp>
nmap <D-2> <C-PageDown>
imap <D-1> <C-PageUp>
imap <D-2> <C-PageDown>

" hl cursorline
set cursorline

set relativenumber
" hange cursor shape between insert and normal mode in iTerm2.app
if $TERM_PROGRAM =~ "iTerm"
        let &t_SI = "\<Esc>]50;CursorShape=1\x7" " Vertical bar in insert mode
            let &t_EI = "\<Esc>]50;CursorShape=0\x7" " Block in normal mode
        endif"
" Show syntax highlighting groups for word under cursor
nmap <C-S-P> :call <SID>SynStack()<CR>
function! <SID>SynStack()
  if !exists("*synstack")
    return
  endif
  echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc

" hl cursor
highlight Cursor guibg=#F200FF
highlight iCursor guibg=#00ff00
set guicursor=n-v-c:block-Cursor-blinkwait300-blinkon400-blinkoff400
set guicursor=i-ci:hor20-iCursor-blinkwait300-blinkon200-blinkoff200
set guioptions-=r  "remove right-hand scroll bar
set guioptions-=L  "remove left-hand scroll bar

" change bg and comment color
hi Comment         ctermfg=244    guifg=#41535B
hi CursorLine      ctermbg=237    cterm=none    guibg=#151718    gui=none

" hi Visual  guibg=#1981CB guifg=#DBD938 gui=none
" remove tool bars
:set guioptions-=m  "remove menu bar
:set guioptions-=T  "remove toolbar

