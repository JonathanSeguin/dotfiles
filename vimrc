" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible
set mouse=a

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

set clipboard=unnamed
set nobackup
set nowritebackup
set history=50		" keep 50 lines of command line history
set ruler		    " show the cursor position all the time
set showcmd		    " display incomplete commands
set incsearch		" do incremental searching
set visualbell
set directory=~/.tmp
set nowrap

colorscheme pablo

" Don't use Ex mode, use Q for formatting
map Q gq

" This is an alternative that also works in block mode, but the deleted
" text is lost and it only works for putting the current register.
"vnoremap p "_dp

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if (&t_Co > 2 || has("gui_running")) && !exists("syntax_on")
    syntax on
    set hlsearch
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")
    call pathogen#runtime_append_all_bundles()
    " Enable file type detection.
    " Use the default filetype settings, so that mail gets 'tw' set to 72,
    " 'cindent' is on in C files, etc.
    " Also load indent files, to automatically do language-dependent indenting.
    filetype plugin indent on

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

" if has("folding")
"   set foldenable
"   set foldmethod=syntax
"   set foldlevel=1
"   set foldnestmax=2
"   set foldtext=strpart(getline(v:foldstart),0,50).'\\\\ ...\\\\ '.substitute(getline(v:foldend),'^[\\\\ #]*','','g').'\\\\ '
" endif

set tabstop=4
set ts=4
set shiftwidth=4
set expandtab

" Automagically change working directory to opened file
set autochdir

" GUI tab labels
set guitablabel=%!expand(\"\%:t\")

" Always display the status line
set laststatus=2

" \ is the leader character
"let mapleader = ","

" Leader shortcuts for Rails commands
map <Leader>m :Rmodel
map <Leader>c :Rcontroller
map <Leader>v :Rview
map <Leader>u :Runittest
map <Leader>f :Rfunctionaltest
map <Leader>tm :RTmodel
map <Leader>tc :RTcontroller
map <Leader>tv :RTview
map <Leader>tu :RTunittest
map <Leader>tf :RTfunctionaltest
map <Leader>sm :RSmodel
map <Leader>sc :RScontroller
map <Leader>sv :RSview
map <Leader>su :RSunittest
map <Leader>sf :RSfunctionaltest

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
"imap <Tab> <C-N>

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


set guifont=Menlo:h16

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

" Snippets are activated by Shift+Tab
let g:snippetsEmu_key = "<S-Tab>"

" Tab completion options
" (only complete to the longest unambiguous match, and show a menu)
set completeopt=longest,menu
set wildmode=list:longest,list:full
set complete=.,t

" case only matters with mixed case expressions
set ignorecase
set smartcase

" common typos
cabbrev q quit
cabbrev Q quit
cabbrev w write
cabbrev W write

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

inoremap jj <Esc>

" Tags
let g:Tlist_Ctags_Cmd="ctags --exclude='*.js'"
set tags=./tags;

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
                    \\\\. ";if (x<0) d=-d; x+=d; scale=" . g:MyCalcPresition . ";print x/1' | bc -l")
    else
        return system("echo 'scale=" . g:MyCalcPresition . " ; print " . a:str . "' | bc -l")
    endif
endfunction

" Control the precision with this variable
let g:MyCalcPresition = 2
" Comment this if you don't want rounding
let g:MyCalcRounding = 1
" Use \\\\C to replace the current line of math expression(s) by the value of the computation:
map <silent> <Leader>c :s/.*/\\\\=MyCalc(submatch(0))/<CR>:noh<CR>
" Same for a visual selection block
vmap <silent> <Leader>c :B s/.*/\\\\=MyCalc(submatch(0))/<CR>:noh<CR>
" With \\\\C= don't replace, but add the result at the end of the current line
map <silent> <Leader>c= :s/.*/\\\\=submatch(0) . " = " . MyCalc(submatch(0))/<CR>:noh<CR>
" Same for a visual selection block
vmap <silent> <Leader>c= :B s/.*/\\\\=submatch(0) . " = " . MyCalc(submatch(0))/<CR>:noh<CR>
" Try: :B s/.*/\\\\=MyCalc("1000 - " . submatch(0))/
" The concatenation is important, since otherwise it will try
" to evaluate things like in ":echo 1000 - ' 1748.24'"
vmap <Leader>c+ :B s/.*/\\\\=MyCalc(' +' . submatch(0))/<C-Left><C-Left><C-Left><Left>
vmap <Leader>c- :B s/.*/\\\\=MyCalc(' -' . submatch(0))/<C-Left><C-Left><C-Left><Left>
" With \\\\Cs you add a block of expressions, whose result appears in the command line
vmap <silent> <Leader>ct y:echo MyCalc(substitute(@0," *\\\\n","+","g"))<CR>:silent :noh<CR>
" Try: :MyCalc 12.7 + sqrt(98)
command! -nargs=+ MyCalc :echo MyCalc("<args>")

" down here as it didn't seem to be applied if it appeared earlier in the file
set cursorline
hi Cursorline cterm=NONE ctermbg=234 guibg=#1c1c1c

highlight clear SignColumn

" folding
set foldmethod=indent
set foldlevelstart=20

" insert mode vertical line in term
let &t_SI .= "\<Esc>[6 q"
let &t_EI .= "\<Esc>[2 q"
