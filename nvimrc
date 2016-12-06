syntax on
" DEIN
if &compatible
  set nocompatible               " Be iMproved
endif

" Required:
set runtimepath^=/u/seguinj/.config/nvim//repos/github.com/Shougo/dein.vim

" Required:
call dein#begin(expand('/u/seguinj/.config/nvim/'))

" Let dein manage dein
" Required:
call dein#add('Shougo/dein.vim')

" Add or remove your plugins here:
call dein#add('Shougo/neosnippet.vim')
call dein#add('Shougo/neosnippet-snippets')
call dein#add('Shougo/deoplete.nvim')

" You can specify revision/branch/tag.
call dein#add('Shougo/vimshell', { 'rev': '3787e5' })

" Required:
call dein#end()


" Required:
filetype plugin indent on

" If you want to install not installed plugins on startup.
if dein#check_install()
  call dein#install()
endif

"End dein Scripts-------------------------

set title

" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible
set mouse=a
set ttyfast

" TEMP FIX
" let g:jedi#show_call_signatures = "0"
" let g:jedelection.#popup_on_dot = 0

" Shorten messages and don't show intro
set shortmess=atI

set scrolloff=1

" Allow backspacing over everything in insert mode
set backspace=indent,eol,start

xnoremap p "_dP

set runtimepath=~/.dotfiles/nvim/,/etc/vim,/usr/share/vim/vimfiles,/usr/share/vim/addons,/usr/share/vim/vim72,/usr/share/vim/vimfiles,/usr/share/vim/addons/after,~/.vim/after*/
"set runtimepath=~/.vim/,/etc/vim

" set guifont=Droid_Sans_Mono_for_Powerline_12

" (linux) remember buffer in X clipboard on exit
autocmd VimLeave * call system("echo -n $'" . escape(getreg(), "'") . "' | xsel -ib")
vmap <C-c> y: call system("xclip -i -selection clipboard", getreg("\""))<CR>
vmap <C-c> yy: call system("xclip -i -selection clipboard", getreg("\""))<CR>

function! ClipboardYank()
  call system('xclip -i -selection clipboard', @@)
endfunction
function! ClipboardPaste()
  let @@ = system('xclip -o -selection clipboard')
endfunction

vnoremap <silent> y y:call ClipboardYank()<cr>
vnoremap <silent> d d:call ClipboardYank()<cr>
nnoremap <silent> p :call ClipboardPaste()<cr>p
onoremap <silent> y y:call ClipboardYank()<cr>
onoremap <silent> d d:call ClipboardYank()<cr>

nnoremap <C-w>t :tabnew<CR>

if $COLORTERM == 'gnome-terminal'
  set t_Co=256
endif

" let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1
" set clipboard+=unnamedplus
" set clipboard=autoselect
set nobackup
set nowritebackup
set history=100		" keep 50 lines of command line history
set ruler		    " show the cursor position all the time
set showcmd		    " display incomplete commands
set incsearch		" do incremental searching
set visualbell
set directory=~/.tmp
set nowrap
"set omnifunc=syntaxcomplete#Complete


colorscheme pablo

" Don't use Ex mode, use Q for formatting
map Q gq

" This is an alternative that also works in block mode, but the deleted
" text is lost and it only works for putting the current register.
"vnoremap p "_dp

au BufRead,BufNewFile *.makojs setfiletype javascript

" Only do this part when compiled with support for autocommands.
if has("autocmd")
"    call pathogen#runtime_append_all_bundles()
    " Enable file type detection.
    " Use the default filetype settings, so that mail gets 'tw' set to 72,
    " 'cindent' is on in C files, etc.
    " Also load indent files, to automatically do language-dependent indenting.


    " Horizontal rule toggle on mode switch (needs compatible vte)
    autocmd InsertEnter,InsertLeave * set cul!

    autocmd QuickFixCmdPost *grep* cwindow

    execute pathogen#infect()

    " Set File type to 'text' for files ending in .txt
    autocmd BufNewFile,BufRead *.txt setfiletype text

    " Enable soft-wrapping for text files
    autocmd FileType text,markdown,html,xhtml,eruby setlocal wrap linebreak nolist

    autocmd FileType html,xml,xsl,php,jsp,eruby let b:closetag_html_style=1
    autocmd FileType html,xml,xsl,php,jsp,eruby source ~/.vim/scripts/closetag.vim

    " Put these in an autocmd group, so that we can delete them easily.
    augroup vimrcEx
        au!

        " For all text files set 'textwidth' to 78 characters.
        " autocmd FileType text setlocal textwidth=78

        " When editing a file, always jump to the last known cursor position.
        " Don't do it when the position is invalid or when inside an event handler
        " (happens when dropping a file on gvim).
        autocmd BufReadPost *
                    \ if line("'\"") > 0 && line("'\"") <= line("$") |
                    \   exe "normal g`\"" |
                    \ endif

        " Automatically load .vimrc source when saved
        autocmd BufWritePost .vimrc source $MYVIMRC

    augroup END

else

    set autoindent		" always set autoindenting on

endif " has("autocmd")


" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
"if (&t_Co > 2 || has("gui_running")) && !exists("syntax_on")
"    syntax on
"    set hlsearch
"endif

set hlsearch

" if has("folding")
"   set foldenable
"   set foldmethod=syntax
"   set foldlevel=1
"   set foldnestmax=2
"   set foldtext=strpart(getline(v:foldstart),0,50).'\ ...\ '.substitute(getline(v:foldend),'^[\ #]*','','g').'\ '
" endif

" folding
"set foldmethod=indent
"set foldlevelstart=20

" encoding settings {{{
if has("multi_byte")
  if &termencoding == ""
    let &termencoding = &encoding
  endif
  set encoding=utf-8
  setglobal fileencoding=utf-8
  "setglobal bomb
  set fileencodings=ucs-bom,utf-8,latin1
endif
" }}}

set tabstop=4
set ts=4
set shiftwidth=4
set expandtab

" Automagically change working directory to opened file
set autochdir

" GUI tab labels
set guitablabel=%!expand(\"\%:t\")

" GUI scrollbar
set guioptions-=r
set guioptions-=L

" clipboard
set guioptions+=a

" Always display the status line
set laststatus=2


" new leader character
"let mapleader = ","

" that shift key already gets too much attention
nore ; :
"nore , ;

" resize current buffer window by +/- 5
" nnoremap <silent> <Leader>+ :resize +5<CR>
" nnoremap <silent> <Leader>_ :resize -5<CR>
" nnoremap <silent> <Leader>- :vertical resize +5<CR>
" nnoremap <silent> <Leader>= :vertical resize -5<CR>

"imap <A-left> <C-O>b
"imap <A-right> <C-O>e

map <F6> :NERDTreeToggle<cr>
map ` :NERDTreeToggle<cr>

" https://wincent.com/blog/2-hours-with-vim
function! AckGrep(command)
    cexpr system("ack " . a:command)
    cw " show quickfix window already
endfunction

command! -nargs=+ -complete=file Ack call AckGrep(<q-args>)
map <leader>f :Ack<space>
" previous ack result
map <leader>[ :cp<CR>
" next ack result
map <leader>] :cn<CR>

map <leader>c "+y
map <leader>v "+p
map <leader>u :u<CR>

" Hide search highlighting
map <Leader>h :set invhls <CR>

" Opens an edit command with the path of the currently edited file filled in
" Normal mode: <Leader>e
map <Leader>e :e <C-R>=expand("%:p:h") . "/" <CR>

" Opens a tab edit command with the path of the currently edited file filled in
" Normal mode: <Leader>t
map <Leader>te :tabe <C-R>=expand("%:p:h") . "/" <CR>

" Inserts the path of the currently edited file into a command
" Command mode: Ctrl+P
cmap <C-P> <C-R>=expand("%:p:h") . "/" <CR>

" Duplicate a selection
" Visual mode: D
vmap D y'>p

" Press Shift+P while in visual mode to replace the selection without
" overwriting the default register
vmap P p :call setreg('"', getreg('0')) <CR>

" No Help, please (fat finger fix)
" nmap <F1> <Esc>

" Press ^F from insert mode to insert the current file name
imap <C-F> <C-R>=expand("%")<CR>

" Maps autocomplete to tab
" imap <Tab> <C-N>

imap <D-Right> $

imap <M-Left> escape-[1;5D
imap <M-Right> escape-[1;5C

" arrow
imap <C-L> <Space>=><Space>

" Display extra whitespace
" set list listchars=tab:»·,trail:

" Edit routes
command! Rroutes :e config/routes.rb
command! Rschema :e db/schema.rb

" Local config
if filereadable(".vimrc.local")
    source .vimrc.local
endif

" Use Ack instead of Grep when available
if executable("ack")
    set grepprg=ack\ -H\ --nogroup\ --nocolor\ --ignore-dir=tmp\ --ignore-dir=coverage
endif

" Color scheme
" set t_Co=256 " Lets you use 256 colors
" let g:solarized_termcolors=16
" if has('gui_running')
"   let g:solarized_style="light"
"   set background=light
" else
"   let g:solarized_style="dark"
"   set background=dark
" end

" set guifont=Menlo:h16

" function! ToggleBackground()
"   if (g:solarized_style=="dark")
"     let g:solarized_style="light"
"     colorscheme solarized
"   else
"     let g:solarized_style="dark"
"     colorscheme solarized
"   endif
" endfunction
" command! Togbg call ToggleBackground()
" nnoremap <F5> :call ToggleBackground()<CR>
" inoremap <F5> <ESC>:call ToggleBackground()<CR>a
" vnoremap <F5> <ESC>:call ToggleBackground()<CR>

" function! ToggleContrast()
"   if (g:solarized_contrast=="normal")
"     let g:solarized_contrast="high"
"     colorscheme solarized
"   else
"     let g:solarized_contrast="normal"
"     colorscheme solarized
"   endif
" endfunction
" command! Togctrst call ToggleContrast()
" nnoremap <F4> :call ToggleContrast()<CR>
" inoremap <F4> <ESC>:call ToggleContrast()<CR>a
" vnoremap <F4> <ESC>:call ToggleContrast()<CR>

" colorscheme railscasts
" colorscheme vividchalk
" highlight NonText guibg=#060606
" highlight Folded  guibg=#0A0A0A guifg=#9090D0

" Numbers
set number
" set numberwidth=5

" Airline patched fonts
let g:airline_powerline_fonts = 1
" Airline tabs
let g:airline#extensions#tabline#enabled = 1
" Airline Theme
let g:airline_theme='serene'

" note : Snippets are activated by Shift+Tab

" Tab completion options
" (only complete to the longest unambiguous match, and show a menu)
set completeopt=longest,menu
set wildmode=list:longest,list:full
set complete=.,t

set showmatch


" case only matters with mixed case expressions
set ignorecase
set smartcase

" common typos
cabbrev q quit
cabbrev Q quit
cabbrev w write
cabbrev W write
cabbrev wQ wq
cabbrev Wq wq

" window
nmap <leader>sw<left>  :topleft  vnew<CR>
nmap <leader>sw<right> :botright vnew<CR>
nmap <leader>sw<up>    :topleft  new<CR>
nmap <leader>sw<down>  :botright new<CR>

" buffer
nmap <leader>s<left>   :leftabove  vnew<CR>
nmap <leader>s<right>  :rightbelow vnew<CR>
nmap <leader>s<up>     :leftabove  new<CR>
nmap <leader>s<down>   :rightbelow new<CR>

"Undo levels (why not)
set undolevels=20000

set undofile
set undodir=~/.tmp

"Undo highlight after search
nnoremap <CR> :noh<CR><CR>

"inoremap jj <Esc>

" Tagbar
nmap <F8> :TagbarToggle<CR>

" Flake8
let g:flake8_max_line_length=100

" Syntastic
" On by default, turn it off for html
let g:syntastic_mode_map = { 'mode': 'active',
    \ 'active_filetypes': [],
    \ 'passive_filetypes': ['html'] }

let g:syntastic_python_checkers = ['flake8']
let g:syntastic_python_flake8_args = '--ignore="E501,E302,E261,E701,E241,E126,E127,E128,W801"'
let g:syntastic_javascript_checkers = ['jshint']
" Better :sign interface symbols
let g:syntastic_error_symbol = '✗'
let g:syntastic_warning_symbol = '!'

let g:neocomplete#enable_at_startup = 1

" Vundle
" set rtp+=~/.vim/bundle/vundle/
" call vundle#rc()

" let Vundle manage Vundle
" required!
"Bundle 'gmarik/vundle'
" My bundles here:
" Bundle 'Valloric/YouCompleteMe'

" YouCompleteMe
" let g:ycm_path_to_python_interpreter = '/usr/local/bin/python'
" let g:EclimCompletionMethod = 'omnifunc'

" Tags
let g:Tlist_Ctags_Cmd="ctags --exclude='*.js'"
set tags=./tags;

" Home goes to first nonblank
noremap <expr> <silent> <Home> col('.') == match(getline('.'),'\S')+1 ? '0' : '^'
imap <silent> <Home> <C-O><Home>

" Latex-Box (OSX)
let g:LatexBox_viewer = "open"
let g:LatexBox_latexmk_async=1

" Strip Trailing Whitespaces
function! StripTrailingWhitespaces()
    let _s=@/
    let l = line(".")
    let c = col(".")
    %s/\s$//e
    let @/=_s
    call cursor(l, c)
endfunction
autocmd BufWritePre * :call StripTrailingWhitespaces()

" visual block calculator
function! MyCalc(str)
    if exists("g:MyCalcRounding")
        return system("echo 'x=" . a:str . ";d=.5/10^" . g:MyCalcPresition
                    \. ";if (x<0) d=-d; x+=d; scale=" . g:MyCalcPresition . ";print x/1' | bc -l")
    else
        return system("echo 'scale=" . g:MyCalcPresition . " ; print " . a:str . "' | bc -l")
    endif
endfunction

" Control the precision with this variable
let g:MyCalcPresition = 2
" Comment this if you don't want rounding
let g:MyCalcRounding = 1
" Use \C to replace the current line of math expression(s) by the value of the computation:
map <silent> <Leader>c :s/.*/\=MyCalc(submatch(0))/<CR>:noh<CR>
" Same for a visual selection block
vmap <silent> <Leader>c :B s/.*/\=MyCalc(submatch(0))/<CR>:noh<CR>
" With \C= don't replace, but add the result at the end of the current line
map <silent> <Leader>c= :s/.*/\=submatch(0) . " = " . MyCalc(submatch(0))/<CR>:noh<CR>
" Same for a visual selection block
vmap <silent> <Leader>c= :B s/.*/\=submatch(0) . " = " . MyCalc(submatch(0))/<CR>:noh<CR>
" Try: :B s/.*/\=MyCalc("1000 - " . submatch(0))/
" The concatenation is important, since otherwise it will try
" to evaluate things like in ":echo 1000 - ' 1748.24'"
vmap <Leader>c+ :B s/.*/\=MyCalc(' +' . submatch(0))/<C-Left><C-Left><C-Left><Left>
vmap <Leader>c- :B s/.*/\=MyCalc(' -' . submatch(0))/<C-Left><C-Left><C-Left><Left>
" With \Cs you add a block of expressions, whose result appears in the command line
vmap <silent> <Leader>ct y:echo MyCalc(substitute(@0," *\n","+","g"))<CR>:silent :noh<CR>
" Try: :MyCalc 12.7 + sqrt(98)
command! -nargs=+ MyCalc :echo MyCalc("<args>")

" down here as it didn't seem to be applied if it appeared earlier in the file
set cursorline
hi Cursorline cterm=NONE ctermbg=234 guibg=#1c1c1c

highlight clear SignColumn


" insert mode vertical line in term
" let &t_SI .= \"<Esc>[6 q"
" let &t_EI .= "\<Esc>[2 q"


set fillchars+=vert:│
hi VertSplit cterm=NONE guibg=NONE



let g:PythonPathLoaded=1

function! LoadPythonPath()
py <<EOF
    # load PYTHONPATH into vim, this lets you hover over a module name
    # and type 'gf' (for goto file) and open that file in vim. Useful
    # and easier than rope for simple tasks
    import os.path
    import sys
    import vim
    for p in sys.path:
        if os.path.isdir(p):
            vim.command(r"set path+=%s" % (p.replace(" ", r"\ ")))
EOF
endfunction

function! GetPythonPath()
    if !exists("g:PythonPathLoaded")
        call LoadPythonPath()
        return
    elseif g:PythonPathLoaded
        return
    else
        call LoadPythonPath()
    endif
endfunction

function! UnloadPythonPath()

py <<EOF
    # load PYTHONPATH into vim, this lets you hover over a module name
    # and type 'gf' (for goto file) and open that file in vim. Useful
    # and easier than rope for simple tasks
for p in sys.path:
    if os.path.isdir(p):
        vim.command(r"set path-=%s" % (p.replace(" ", r"\ ")))
EOF

    let g:PythonPathLoaded = 0
endfunction
