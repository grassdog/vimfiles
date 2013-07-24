
" Map Leaders
let mapleader = ","

" Keep reverse char search
noremap \ ,

" Use vim, no vi defaults
set nocompatible
filetype off

" Vundle setup

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Bundle 'gmarik/vundle'

" Core
Bundle 'tpope/vim-surround'
Bundle 'tpope/vim-abolish'
Bundle 'tpope/vim-repeat'
Bundle 'tpope/vim-commentary.git'
Bundle 'tpope/vim-eunuch.git'
Bundle 'tpope/vim-sleuth.git'
Bundle 'tpope/vim-fugitive'
Bundle 'tpope/vim-git'
Bundle 'tpope/vim-dispatch'
Bundle 'tpope/vim-characterize'
Bundle 'nelstrom/vim-visual-star-search'
Bundle 'godlygeek/tabular'
Bundle 'altercation/vim-colors-solarized'
Bundle 'nathanaelkane/vim-indent-guides'

" Text objects and motions
Bundle 'kana/vim-textobj-user'
Bundle 'kana/vim-textobj-entire'
Bundle 'kana/vim-textobj-indent'
Bundle 'kana/vim-textobj-syntax'
Bundle 'kana/vim-textobj-line'
Bundle 'bkad/CamelCaseMotion'
Bundle 'argtextobj.vim'
Bundle 'nelstrom/vim-textobj-rubyblock'

" Completions and Snippets
Bundle 'SirVer/ultisnips'
Bundle 'ervandew/supertab'
Bundle 'kien/ctrlp.vim'

" Tools
Bundle 'EasyGrep'
Bundle 'mileszs/ack.vim'
Bundle 'rking/ag.vim'
Bundle 'henrik/vim-open-url'

" Ruby
Bundle 'tpope/vim-rails'
Bundle 'tpope/vim-endwise'
Bundle 'tpope/vim-bundler'
Bundle 'vim-ruby/vim-ruby'

Bundle 'thoughtbot/vim-rspec'
Bundle 'tpope/vim-cucumber'
"Bundle 'rking/vim-ruby-refactoring'

" Web
Bundle 'tpope/vim-haml'
Bundle 'tpope/vim-markdown'
Bundle 'othree/html5.vim'
Bundle 'cakebaker/scss-syntax.vim'

" Javascript
Bundle 'pangloss/vim-javascript'
Bundle 'kchmck/vim-coffee-script'
Bundle 'claco/jasmine.vim'
Bundle 'JSON.vim'

" Other
Bundle 'VimClojure'
Bundle 'lukerandall/haskellmode-vim'
Bundle 'PProvost/vim-ps1'
"Bundle 'tpope/vim-fireplace'
"Bundle 'kikijump/tslime.vim'

" Fringe
Bundle 'wlangstroth/vim-racket'
Bundle 'ajf/puppet-vim'
Bundle 'nono/vim-handlebars'
Bundle 'tpope/vim-liquid'
Bundle 'groenewege/vim-less'

" Enable matchit
runtime macros/matchit.vim

" Turn on filetype plugins and indent files for per-type indenting
filetype plugin indent on

""""""""
" Base
""""""""

set number            " Show line numbers
syntax enable         " Turn on syntax highlighting allowing local overrides
set encoding=utf-8    " Set default encoding to UTF-8
set hidden            " Hide buffers, don't nag about them

" Prevent Vim from clobbering the scrollback buffer. See
" http://www.shallowsky.com/linux/noaltscreen.html
"set t_ti= t_te=

if has("statusline")
  set statusline=[%n]                                 " buffer no
  set statusline+=\ %<%.99f                           " Filename
  set statusline+=\ %h%m%r%w                          " Flags
  set statusline+=%=                                  " right align
  set statusline+=\ [%{strlen(&fenc)?&fenc:'none'}]   " Encoding
  set statusline+=\ %y                                " Filetype
  set statusline+=\ [%{&ff}]                          " Fileformat
  set statusline+=\ %-3.c\ %P\                        " Column and Percentage
endif

set foldlevelstart=99

set wrap                              " wrap lines
set tabstop=2                         " a tab is two spaces
set shiftwidth=2                      " an autoindent (with <<) is two spaces
set expandtab                         " use spaces, not tabs
set autoindent

" Display tabs and whitepace
set list
set listchars=tab:▸\ ,trail:·,extends:»,precedes:«

set backspace=indent,eol,start        " backspace through everything in insert mode
set whichwrap+=<,>,h,l,[,]            " Allow left, right, bs, del to cross lines

set nohlsearch  " Don't highlight matches
set incsearch   " incremental searching
set ignorecase  " searches are case insensitive...
set smartcase   " ... unless they contain at least one capital letter

" Toggle search highlighting
noremap <leader><space> :set hlsearch! hlsearch?<CR>

" Treat all numbers as decimal
set nrformats=

" use zsh-style tab completion when selecting files, etc
set wildmode=full

" make tab completion for files/buffers act like bash
set wildmenu

" Disable output and VCS files
set wildignore+=*.o,*.out,*.obj,.git,*.rbc,.hg,*.class,.svn,*.gem,.DS_Store

" Disable archive files
set wildignore+=*.zip,*.tar.gz,*.tar.bz2,*.rar,*.tar.xz

" Ignore bundler and sass cache
set wildignore+=**/vendor/gems/*,**/vendor/bundle/*,**/vendor/cache/*,**/.bundle/*,**/b/*,.sass-cache/*,doc/**,**/tmp/**

set undofile
set undoreload=10000
set history=1000

" Undo, swap, and backup files
set undodir=~/.vim/tmp/undo//
set backup
set backupdir=~/.vim/tmp/backups
set writebackup
set noswapfile

" Just load the changed file
set autoread

set laststatus=2  " always show the status bar
set showmode
set shortmess=atI " Shortens messages to avoid 'press a key' prompt
set showcmd

set scrolloff=3       " Always show at least three lines below cursor
set mat=3             " Blink matching brackets for 3 tenths of a second
set visualbell t_vb=  " No Noise or bell

" Color scheme
let g:solarized_menu=0
let g:solarized_contrast="high"

set background=dark
colorscheme solarized

" Indent or outdent and maintain selection in visual mode
vnoremap >> >gv
vnoremap << <gv

" Yank to the end of the line
noremap Y y$

" Fold html tags
nnoremap <leader>zfh Vatzf

" Switch to last buffer
nnoremap <leader><leader> <c-^>

" Easier current directory in command mode
cnoremap <expr> %%  getcmdtype() == ':' ? fnameescape(expand('%:h')).'/' : '%%'

" Setup my language
set spelllang=en_au

"""""""""""
" Movement
"""""""""""

" Move across display lines, not physical lines
noremap j gj
noremap gj j
noremap k gk
noremap gk k
noremap <down> gj
noremap <up> gk

" Quicker escape
inoremap jj <ESC>

" Hard mode
"nnoremap <Left> <Nop>
"nnoremap <Right> <Nop>
"nnoremap <Up> <Nop>
"nnoremap <Down> <Nop>

"inoremap <Up> <nop>
"inoremap <Down> <nop>
"inoremap <Left> <nop>
"inoremap <Right> <nop>

" Move around splits with <c-hjkl>
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l

nnoremap <s-down> <c-w>j
nnoremap <s-up> <c-w>k
nnoremap <s-left> <c-w>h
nnoremap <s-right> <c-w>l

" Stop page movement on shift arrow
vnoremap <S-Down> <Down>
vnoremap <S-Up> <Up>


"""""""""""""
" File Hooks
"""""""""""""

" Some file types should wrap their text
" This currently hard wraps at 85 columns because I can't work out a way to
" soft wrap to a column width that is smaller than the window
function! s:setupWrapping()
  setlocal textwidth=80
  setlocal linebreak
  setlocal nolist
endfunction

" A standalone function to set the working directory to the project’s root, or
" to the parent directory of the current file if a root can’t be found:
function! s:setcwd()
  let cph = expand('%:p:h', 1)
  if match(cph, '\v^<.+>://') >= 0 | retu | en
  for mkr in ['.git/', '.hg/', '.svn/', '.bzr/', '_darcs/', '.vimprojects']
    let wd = call('find'.(mkr =~ '/$' ? 'dir' : 'file'), [mkr, cph.';'])
    if wd != '' | let &acd = 0 | brea | en
  endfo
  exe 'lc!' fnameescape(wd == '' ? cph : substitute(wd, mkr.'$', '.', ''))
endfunction

" Auto align when inserting `|`
function! s:align()
  let p = '^\s*|\s.*\s|\s*$'
  if exists(':Tabularize') && getline('.') =~# '^\s*|' && (getline(line('.')-1) =~# p || getline(line('.')+1) =~# p)
    let column = strlen(substitute(getline('.')[0:col('.')],'[^|]','','g'))
    let position = strlen(matchstr(getline('.')[0:col('.')],'.*|\s*\zs.*'))
    Tabularize/|/l1
    normal! 0
    call search(repeat('[^|]*|',column).'\s\{-\}'.repeat('.',position),'ce',line('.'))
  endif
endfunction

inoremap <silent> <Bar>   <Bar><Esc>:call <SID>align()<CR>a

augroup grass_filehooks
  autocmd!

  " match (:),[:],{:} in html
  au FileType html,eruby let b:match_words = '(:),[:],{:},' . b:match_words

  " In Makefiles, use real tabs, not tabs expanded to spaces
  autocmd FileType make set noexpandtab

  " Setup JSON files
  autocmd BufNewFile,BufRead *.json set ft=json

  " make Python follow PEP8 ( http://www.python.org/dev/peps/pep-0008/ )
  autocmd FileType python setlocal softtabstop=4 tabstop=4 shiftwidth=4 textwidth=79

  " Markdown and txt files should wrap
  autocmd BufRead,BufNewFile *.{md,markdown,mdown,mkd,mkdn,txt} call s:setupWrapping()

  " Change tab width for markdown
  autocmd FileType markdown setlocal softtabstop=4 tabstop=4 shiftwidth=4

  " Less
  autocmd BufNewFile,BufRead *.less set filetype=less

  " Add indent stuff for scheme files
  autocmd filetype lisp,scheme,art setlocal equalprg=~/.vim/tools/scheme-indent/scmindent.scm
augroup END

" Highlight VCS conflict markers
match ErrorMsg '^\(<\|=\|>\)\{7\}\([^=].\+\)\?$'

" Find merge conflict markers
nnoremap <silent> <leader>mm <ESC>/\v^[<=>]{7}( .*\|$)<CR>

" Bubble lines up and down
" http://vim.wikia.com/wiki/Moving_lines_up_or_down
nnoremap <silent> <C-S-Up> :m .-2<CR>==
nnoremap <silent> <C-S-Down> :m .+1<CR>==

inoremap <silent> <C-S-Up> <Esc>:m .-2<CR>==gi
inoremap <silent> <C-S-Down> <Esc>:m .+1<CR>==gi

vnoremap <silent> <C-S-Up> :m '<-2<CR>gv=gv
vnoremap <silent> <C-S-Down> :m '>+1<CR>gv=gv

""""""""""""""
" Formatting
""""""""""""""

command! InsertTime :normal a<c-r>=strftime('%F %H:%M:%S.0 %z')<cr>
command! InsertDate :normal a<c-r>=strftime('%F')<cr>

" Remove trailing white space and retab file
command! KillWhitespace :normal :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar>:nohl<Bar>:retab<CR>

" Re-wrap the entire file
nnoremap <leader>rwf ggVGgq

" Format the entire file
nnoremap <leader>rff ggVG=

" Reformat XML files
noremap <leader>rfx <Esc>:% !xmllint --format -<CR>

" Reformat HTML files
noremap <leader>rfh <Esc>:% !tidy -quiet  -indent --indent-spaces 2 --wrap 90<CR>

" Reformat JSON
noremap <leader>rfj <Esc>:% !js-beautify -i -s 2 --brace-style=expand<CR>

""""""""""""""""
" Abbreviations
""""""""""""""""

iabbrev teh the

"""""""""
" Ctags
"""""""""

command! TagFiles :call EchoTags()
function! EchoTags()
  echo join(split(&tags, ","), "\n")
endfunction

" Regenerate the tag lib
" command! GenRubyTags :normal :!ctags-ruby -f .tags *<cr><cr>
" command! GenBundleTags :normal :!ctags-bundle<cr><cr>

""""""""""
" Plugins
""""""""""

" Toggle indent guides
noremap <leader>vi :IndentGuideToggle<cr>

" Preview markdown files in Marked.app
nnoremap <leader>mp :silent !open -a Marked.app '%:p'<cr>

" Highlight fenced code
let g:markdown_fenced_languages = ['ruby', 'javascript']

" No Netrw menu
let g:netrw_menu=0

" Remove netrw history files
let g:netrw_dirhistmax = 0

" Disable useless HTML5 stuff
let g:event_handler_attributes_complete = 0
let g:rdfa_attributes_complete = 0
let g:microdata_attributes_complete = 0
let g:atia_attributes_complete = 0

" Search for current word in Ack
nnoremap <leader>aa :Ack! '\b<c-r><c-w>\b'<cr>

" Ctrlp
let g:ctrlp_jump_to_buffer = 1
let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_mruf_last_entered = 1
let g:ctrlp_match_window_reversed = 0
let g:ctrlp_split_window = 0
let g:ctrlp_max_height = 20
let g:ctrlp_use_caching = 0

nnoremap <leader>d :CtrlPCurFile<cr>
nnoremap <leader>o :CtrlPBuffer<cr>

" UltiSnips
let g:UltiSnipsSnippetDirectories    = ["UltiSnips", "mysnippets"]
" Overcome Vundle runtime path so snippet overrides work
let g:UltiSnipsDontReverseSearchPath = "1"

augroup grass_allfiles
  autocmd!

  " Set my current working directory based upon project
  autocmd BufEnter * call s:setcwd()

  " Remember last location in file, but not for commit messages.
  " see :help last-position-jump
  autocmd BufReadPost * if &filetype !~ '^git\c' && line("'\"") > 0 && line("'\"") <= line("$")
    \| exe "normal! g`\"" | endif

  " Write all buffers once I lose focus
  autocmd FocusLost * :silent! wall
augroup END

" Specs
map <Leader>t :call RunCurrentSpecFile()<CR>
map <Leader>s :call RunNearestSpec()<CR>
map <Leader>l :call RunLastSpec()<CR>

" Tabularise shortcuts
nmap <Leader>a= :Tabularize /=<CR>
vmap <Leader>a= :Tabularize /=<CR>
nmap <Leader>a: :Tabularize /:\zs<CR>
vmap <Leader>a: :Tabularize /:\zs<CR>

" Clojure

let g:vimclojure#ParenRainbow = 1
let g:vimclojure#HighlightBuiltins = 1

" Add these for Nailgun (clunky as it is)
"let vimclojure#WantNailgun = 1
"let vimclojure#NailgunClient = "$HOME/.bin/ng"

" Configure browser for haskell_doc.vim
let g:haddock_browser = "open"
let g:haddock_browser_callformat = "%s %s"

" Show cheats
command! Cheats :normal :silent! tabnew ~/Dropbox/Notes/Vim.md<cr>

" Edit hot files
command! Myrc :normal :edit $MYVIMRC<cr>
command! WorkLog :normal :silent! edit ~/Dropbox/Notes/Work\ Log.md<cr>
command! Scratch :normal :silent! edit ~/Dropbox/Notes/Scratch.md<cr>

""""""
" GUI
""""""

if has("gui_running")
  " Show my current line
  set cursorline

  " No left scrollbar
  set guioptions-=l
  set guioptions-=L

  " No toolbar
  set guioptions-=T

  " Hide mouse after chars typed
  set mousehide
endif

if has("gui_macvim")
  set guifont=Menlo:h12

  " Automatically resize splits when resizing MacVim window
  augroup grass_gui
    autocmd!
    autocmd VimResized * wincmd =
  augroup END

  " Command-Return for fullscreen
  macmenu Window.Toggle\ Full\ Screen\ Mode key=<D-CR>

  " Fullscreen takes up entire screen
  set fuoptions=maxhorz,maxvert

  " Hide some menus
  silent! aunmenu T&hemes
  silent! aunmenu Plugin
endif

