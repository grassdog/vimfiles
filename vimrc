""""""""""""""""""""""" }}}
" Preamble              {{{
"""""""""""""""""""""""

" Map Leaders
let mapleader = ","

" Keep reverse char search
noremap \ ,

" Use vim, no vi defaults
set nocompatible
filetype off


""""""""""""""""""""""" }}}
" Vundle setup          {{{
"""""""""""""""""""""""

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Bundle 'gmarik/vundle'

" Core
Bundle 'tpope/vim-surround'
Bundle 'tpope/vim-abolish'
Bundle 'tpope/vim-repeat'
Bundle 'tpope/vim-commentary.git'
Bundle 'tpope/vim-fugitive'
Bundle 'tpope/vim-git'
Bundle 'tpope/vim-dispatch'
Bundle 'tpope/vim-characterize'
Bundle 'tpope/vim-eunuch'
Bundle 'nelstrom/vim-visual-star-search'
Bundle 'godlygeek/tabular'
Bundle 'altercation/vim-colors-solarized'
Bundle 'nathanaelkane/vim-indent-guides'
Bundle 'scrooloose/nerdtree'
Bundle 'grassdog/RemoveFile.vim'
Bundle 'mbbill/undotree'

" Text objects and motions
Bundle 'kana/vim-textobj-user'
Bundle 'kana/vim-textobj-entire'
Bundle 'kana/vim-textobj-syntax'
Bundle 'kana/vim-textobj-line'
Bundle 'michaeljsmith/vim-indent-object'
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

" Web
Bundle 'tpope/vim-haml'
Bundle 'tpope/vim-markdown'
Bundle 'nelstrom/vim-markdown-folding'
Bundle 'othree/html5.vim'
Bundle 'cakebaker/scss-syntax.vim'
Bundle 'pangloss/vim-javascript'
Bundle 'kchmck/vim-coffee-script'
Bundle 'claco/jasmine.vim'
Bundle 'JSON.vim'

" Clojure
Bundle 'guns/vim-clojure-static'
Bundle 'kien/rainbow_parentheses.vim'
Bundle 'tpope/vim-fireplace'
Bundle 'tpope/vim-leiningen'
Bundle 'guns/vim-sexp'
Bundle 'tpope/vim-sexp-mappings-for-regular-people'

" Other
Bundle 'lukerandall/haskellmode-vim'
Bundle 'PProvost/vim-ps1'
Bundle 'wlangstroth/vim-racket'
Bundle 'ajf/puppet-vim'
Bundle 'mustache/vim-mustache-handlebars'
Bundle 'tpope/vim-liquid'
Bundle 'groenewege/vim-less'
Bundle 'b4winckler/vim-objc'
Bundle 'kovisoft/slimv'

" Enable matchit
runtime macros/matchit.vim

" Turn on filetype plugins and indent files for per-type indenting
filetype plugin indent on


""""""""""""""""""""""" }}}
" Base setup            {{{
"""""""""""""""""""""""

set number            " Show line numbers
syntax enable         " Turn on syntax highlighting allowing local overrides
set encoding=utf-8    " Set default encoding to UTF-8
set hidden            " Hide buffers, don't nag about them

" Don't try to highlight lines longer than 800 characters.
set synmaxcol=300

" Time out on key codes but not mappings.
" Basically this makes terminal Vim work sanely.
set notimeout
set ttimeout
set ttimeoutlen=10

set nopaste

" Normally, Vim messes with iskeyword when you open a shell file. This can
" leak out, polluting other file types even after a 'set ft=' change. This
" variable prevents the iskeyword change so it can't hurt anyone.
let g:sh_noisk=1

" Prevent Vim from clobbering the scrollback buffer. See
" http://www.shallowsky.com/linux/noaltscreen.html
"set t_ti= t_te=

set nowrap                            " don't wrap lines
set tabstop=2                         " a tab is two spaces
set shiftwidth=2                      " an autoindent (with <<) is two spaces
set expandtab                         " use spaces, not tabs
set autoindent

set textwidth=80
set formatoptions=crql1j

" Fast terminal please
set ttyfast

" Display tabs and whitepace
set list
set listchars=tab:▸\ ,trail:·,extends:»,precedes:«

set backspace=indent,eol,start        " backspace through everything in insert mode
set whichwrap+=<,>,h,l,[,]            " Allow left, right, bs, del to cross lines

" Treat all numbers as decimal
set nrformats=

set scrolloff=3       " Always show at least three lines below cursor
set mat=3             " Blink matching brackets for 3 tenths of a second
set visualbell t_vb=  " No Noise or bell


""""""""""""""""""""""" }}}
" Statusline            {{{
"""""""""""""""""""""""

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

set laststatus=2  " always show the status bar
set showmode
set shortmess=atIOT   " Abbrev. of messages (avoids 'hit enter')
set showcmd


""""""""""""""""""""""" }}}
" Spelling              {{{
"""""""""""""""""""""""

" Setup my language
set spelllang=en_au

"   /usr/share/dict/words
"
"   ~/.vim/custom-dictionary.utf-8.add
"   Custom words (version-controlled)
"
"   ~/.vim-local-dictionary.utf-8.add
"   More custom words (*not* version controlled)
"
set spellfile=~/.vim/custom-dictionary.utf-8.add,~/.vim-local-dictionary.utf-8.add

" Add word to the local dict
nnoremap zG 2zg

" Toggle spelling
noremap <F9> :setlocal spell! spell?<CR>


""""""""""""""""""""""" }}}
" Search                {{{
"""""""""""""""""""""""

set nohlsearch  " Don't highlight matches
set incsearch   " incremental searching
set ignorecase  " searches are case insensitive...
set smartcase   " ... unless they contain at least one capital letter

" Toggle search highlighting
noremap <leader><space> :set hlsearch! hlsearch?<CR>

" Search for current word in Ag
nnoremap <leader>sw :Ag! '\b<c-r><c-w>\b'<cr>
nnoremap <leader>ss :Ag!<space>

" Easy grep
let g:EasyGrepReplaceWindowMode=2


""""""""""""""""""""""" }}}
" Wildmenu completion   {{{
"""""""""""""""""""""""

" use zsh-style tab completion when selecting files, etc
set wildmode=full

" make tab completion for files/buffers act like bash
set wildmenu

set wildignore+=.hg,.git,.svn                    " Version control
set wildignore+=*.aux,*.out,*.toc                " LaTeX intermediate files
set wildignore+=*.jpg,*.bmp,*.gif,*.png,*.jpeg   " binary images
set wildignore+=*.o,*.obj,*.exe,*.dll,*.manifest " compiled object files
set wildignore+=*.spl                            " compiled spelling word lists
set wildignore+=*.sw?                            " Vim swap files
set wildignore+=*.DS_Store                       " OSX

set wildignore+=*.obj,*.rbc,*.class,*.gem        " Disable output and VCS files
set wildignore+=*.zip,*.tar.gz,*.tar.bz2,*.rar,*.tar.xz " Disable archive files

" Ignore bundler and sass cache
set wildignore+=**/vendor/gems/*,**/vendor/bundle/*,**/vendor/cache/*,**/.bundle/*,**/b/*,.sass-cache/*,doc/**,**/tmp/**

set wildignore+=*.luac                           " Lua byte code
set wildignore+=*.pyc                            " Python byte code
set wildignore+=*.orig                           " Merge resolution files


""""""""""""""""""""""" }}}
" History and undo      {{{
"""""""""""""""""""""""

set history=1000

" Undo, swap, and backup files
if has('persistent_undo')
  set undofile                " So is persistent undo ...
  set undolevels=1000         " Maximum number of changes that can be undone
  set undoreload=10000        " Maximum number lines to save for undo on a buffer reload
endif

set undodir=~/.vim/tmp/undo/
set backup
set backupdir=~/.vim/tmp/backups
set noswapfile
set directory=~/.vim/tmp/swaps
set writebackup

set autoread                  " Just load a changed file


""""""""""""""""""""""" }}}
" Folding               {{{
"""""""""""""""""""""""

set nofoldenable
set foldlevelstart=99

function! MyFoldText()
  let line = getline(v:foldstart)

  let nucolwidth = &fdc + &number * &numberwidth
  let windowwidth = winwidth(0) - nucolwidth - 3
  let foldedlinecount = v:foldend - v:foldstart

  " expand tabs into spaces
  let onetab = strpart('          ', 0, &tabstop)
  let line = substitute(line, '\t', onetab, 'g')

  let line = strpart(line, 0, windowwidth - 2 -len(foldedlinecount))
  let fillcharcount = windowwidth - len(line) - len(foldedlinecount)
  return line . '…' . repeat(" ",fillcharcount) . foldedlinecount . '…' . ' '
endfunction
set foldtext=MyFoldText()


""""""""""""""""""""""" }}}
" Colours               {{{
"""""""""""""""""""""""

let g:solarized_menu=0
let g:solarized_contrast="high"

set background=dark
colorscheme solarized


""""""""""""""""""""""" }}}
" Movement              {{{
"""""""""""""""""""""""

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
let g:HardMode_on = 0

if g:HardMode_on
  nnoremap <Left> <Nop>
  nnoremap <Right> <Nop>
  nnoremap <Up> <Nop>
  nnoremap <Down> <Nop>

  inoremap <Up> <nop>
  inoremap <Down> <nop>
  inoremap <Left> <nop>
  inoremap <Right> <nop>

  vnoremap <Up> <nop>
  vnoremap <Down> <nop>
  vnoremap <Left> <nop>
  vnoremap <Right> <nop>
end

" Move around splits with <c-hjkl>
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l

nnoremap <s-down> <c-w>j
nnoremap <s-up> <c-w>k
nnoremap <s-left> <c-w>h
nnoremap <s-right> <c-w>l

set splitright
set splitbelow

" Stop page movement on shift arrow
vnoremap <S-Down> <Down>
vnoremap <S-Up> <Up>

" Switch to last buffer
nnoremap <leader><leader> <c-^>


""""""""""""""""""""""" }}}
" Text manipulation     {{{
"""""""""""""""""""""""

" Indent or outdent and maintain selection in visual mode
vnoremap >> >gv
vnoremap << <gv

" Yank to the end of the line
noremap Y y$

" Yank to system clipboard
map <leader>y "*y

" Bubble lines up and down
" http://vim.wikia.com/wiki/Moving_lines_up_or_down
nnoremap <silent> <C-K> :m .-2<CR>==
nnoremap <silent> <C-J> :m .+1<CR>==
nnoremap <silent> <C-S-Up> :m .-2<CR>==
nnoremap <silent> <C-S-Down> :m .+1<CR>==

inoremap <silent> <C-S-Up> <Esc>:m .-2<CR>==gi
inoremap <silent> <C-S-Down> <Esc>:m .+1<CR>==gi

vnoremap <silent> <C-K> :m '<-2<CR>gv=gv
vnoremap <silent> <C-J> :m '>+1<CR>gv=gv
vnoremap <silent> <C-S-Up> :m '<-2<CR>gv=gv
vnoremap <silent> <C-S-Down> :m '>+1<CR>gv=gv

" Tabularise shortcuts
nmap <Leader>a= :Tabularize /=<CR>
vmap <Leader>a= :Tabularize /=<CR>
nmap <Leader>a: :Tabularize /:\zs<CR>
vmap <Leader>a: :Tabularize /:\zs<CR>

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

" Remove trailing white space and retab file
command! KillWhitespace :normal :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar>nohl<Bar>retab<CR>

" Re-wrap the entire file
nnoremap <leader>rwf ggVGgq

" Format the entire file
nnoremap <leader>rff ggVG=


""""""""""""""""""""""" }}}
" Proper quotes etc     {{{
"""""""""""""""""""""""

"
" RemoveFancyCharacters COMMAND
" Remove smart quotes, etc.
"
function! RemoveFancyCharacters()
    let typo = {}
    let typo["“"] = '"'
    let typo["”"] = '"'
    let typo["‘"] = "'"
    let typo["’"] = "'"
    let typo["–"] = '--'
    let typo["—"] = '---'
    let typo["…"] = '...'
    :exe ":%s/".join(keys(typo), '\|').'/\=typo[submatch(0)]/ge'
endfunction
command! RemoveFancyCharacters :call RemoveFancyCharacters()


""""""""""""""""""""""" }}}
" Working directory     {{{
"""""""""""""""""""""""

" Easier current directory in command mode
cnoremap <expr> %%  getcmdtype() == ':' ? fnameescape(expand('%:h')).'/' : '%%'

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
command! SetProjectDir :call s:setcwd()


""""""""""""""""""""""" }}}
" Abbreviations         {{{
"""""""""""""""""""""""

iabbrev teh the

command! InsertTime :normal a<c-r>=strftime('%F %H:%M:%S.0 %z')<cr>
command! InsertDate :normal a<c-r>=strftime('%F')<cr>

" Create a new dayone post from the buffer
command! NewDayonePost :w !dayone new


""""""""""""""""""""""" }}}
" Netrw                 {{{
"""""""""""""""""""""""

" No Netrw menu
let g:netrw_menu      = 0
let g:netrw_list_hide= '.DS_Store$'

" Preview in a vertical split
let g:netrw_preview   = 1
let g:netrw_winsize   = 30

" Remove netrw history files
let g:netrw_dirhistmax = 0


""""""""""""""""""""""" }}}
" Ctrl-P                {{{
"""""""""""""""""""""""

let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_mruf_last_entered = 1
let g:ctrlp_match_window_reversed = 0
let g:ctrlp_split_window = 0
let g:ctrlp_max_height = 20
let g:ctrlp_use_caching = 0

nnoremap <leader>d :CtrlPCurFile<cr>
nnoremap <leader>o :CtrlPBuffer<cr>


""""""""""""""""""""""" }}}
" Git                   {{{
"""""""""""""""""""""""

" Highlight VCS conflict markers
match ErrorMsg '^\(<\|=\|>\)\{7\}\([^=].\+\)\?$'

" Find merge conflict markers
nnoremap <silent> <leader>fc <ESC>/\v^[<=>]{7}( .*\|$)<CR>


""""""""""""""""""""""" }}}
" NerdTree              {{{
"""""""""""""""""""""""

nnoremap <leader>n :NERDTreeToggle<CR>
nnoremap <leader>ff :NERDTreeFind<CR>

let NERDTreeAutoDeleteBuffer=1
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1
let NERDChristmasTree = 1


""""""""""""""""""""""" }}}
" Ctags                 {{{
"""""""""""""""""""""""

set tags+=.tags

command! ListTagFiles :call ListTagFiles()
function! ListTagFiles()
  echo join(split(&tags, ","), "\n")
endfunction

" Let me select my tags
nnoremap <c-]> g<c-]>
nnoremap g<c-]> <c-]>


""""""""""""""""""""""" }}}
" All files             {{{
"""""""""""""""""""""""

augroup grass_allfiles
  autocmd!

  " Don't show trailing space in insert mode
  au InsertEnter * :set listchars-=trail:·
  au InsertLeave * :set listchars+=trail:·

  " Remember last location in file, but not for commit messages.
  " see :help last-position-jump
  autocmd BufReadPost * if &filetype !~ '^git\c' && line("'\"") > 0 && line("'\"") <= line("$")
    \| exe "normal! g`\"" | endif

  " Write all buffers once I lose focus
  autocmd FocusLost * :silent! wall
augroup END


""""""""""""""""""""""" }}}
" HTML and Markdown     {{{
"""""""""""""""""""""""

function! ExtendMarkdownSyntax()
  " Define some sytax groups that won't be spell checked
  " To be matched: Camel CCase CamelCase allDay
  " To be ignored: Hi there
  syntax match RGMixedCase /\v<(\u{-2,}\w*)|(\u+\w*\u+\w*)>/
  syntax match RGCamelCase /\v<\l+\u+\w+>/
  syntax match RGBareURL /https\?:\/\/\(\w\+\(:\w\+\)\?@\)\?\([A-Za-z][-_0-9A-Za-z]*\.\)\{1,}\(\w\{2,}\.\?\)\{1,}\(:[0-9]\{1,5}\)\?\S*/

  " Highlight bare urls in markdown
  hi def link RGBareURL markdownUrl
endfun

augroup grass_html
  autocmd!

  au FileType html setlocal foldmethod=manual

  " match (:),[:],{:} in html
  au FileType html,eruby let b:match_words = '(:),[:],{:},' . b:match_words

  " Fold current html tag
  autocmd FileType html nnoremap <buffer> <leader>z Vatzf

  " Reformat HTML files
  autocmd FileType html nnoremap <buffer> <leader>rff <Esc>:% !tidy -quiet  -indent --indent-spaces 2 --wrap 80<CR>

  " Indent current tag
  au FileType html,eruby nnoremap <buffer> <leader>= Vat=

  " Change tab width and wrap for markdown
  autocmd FileType markdown setlocal wrap softtabstop=4 tabstop=4 shiftwidth=4 spell

  autocmd FileType markdown call ExtendMarkdownSyntax()

  " Preview markdown files in Marked.app
  autocmd FileType markdown nnoremap <buffer> <leader>pm :silent !open -a Marked.app '%:p'<cr>
augroup END

" Highlight fenced code
let g:markdown_fenced_languages = ['ruby', 'javascript', 'clojure']

" Disable useless HTML5 stuff
let g:event_handler_attributes_complete = 0
let g:rdfa_attributes_complete = 0
let g:microdata_attributes_complete = 0
let g:atia_attributes_complete = 0


""""""""""""""""""""""" }}}
" XML                   {{{
"""""""""""""""""""""""

augroup grass_xml
  au!

  au FileType xml setlocal foldmethod=manual

  " Reformat XML files
  au FileType xml noremap <buffer> <leader>rff <Esc>:% !xmllint --format -<CR>

  " Use <localleader>f to fold the current tag.
  au FileType xml nnoremap <buffer> <leader>z Vatzf

  " Indent current tag
  au FileType xml nnoremap <buffer> <leader>= Vat=
augroup END


""""""""""""""""""""""" }}}
" Clojure               {{{
"""""""""""""""""""""""

function! JumpToClojureSymbolWithoutNamespace()
  let wordUnderCursor = expand("<cword>")
  let symbol = matchstr(wordUnderCursor, '\(.*/\)\?\zs[^\/]\+\ze')
  if !empty(symbol)
    execute 'try | tjump ' . symbol . '| catch | echom ''Could not find tag ' . symbol . ''' | endtry'
  endif
endfunction

augroup grass_clojure
  autocmd!

  autocmd filetype clojure setlocal wildignore+=classes
  autocmd filetype clojure setlocal wildignore+=lib

  autocmd filetype clojure silent! call TurnOnClojureFolding()

  " Rainbows
  autocmd filetype clojure RainbowParenthesesActivate
  autocmd syntax clojure RainbowParenthesesLoadRound
  autocmd syntax clojure RainbowParenthesesLoadSquare
  autocmd syntax clojure RainbowParenthesesLoadBraces

  " Eval and print top level form and return cursor to where it was
  autocmd filetype clojure nnoremap <buffer> <leader>co :normal cpaF``<cr>

  " Eval and print current form and return cursor to where it was
  autocmd filetype clojure nnoremap <buffer> <leader>ci :normal cpaf``<cr>

  " Eval and print current element and return cursor to where it was
  autocmd filetype clojure nnoremap <buffer> <leader>ce :normal cpie``<cr>

  " Better ctag matching
  autocmd filetype clojure nnoremap <buffer> <c-]> :call JumpToClojureSymbolWithoutNamespace()<CR>
augroup END

let g:clojure_fold_extra = [
            \ 'defgauge',
            \ 'defmeter',
            \ 'defhistogram',
            \ 'defcounter',
            \ 'deftimer',
            \
            \ 'defdb',
            \ 'defentity',
            \ 'defaspect',
            \ 'add-aspect',
            \ 'defmigration',
            \
            \ 'defsynth',
            \ 'definst',
            \ 'defproject',
            \
            \ 'defroutes',
            \
            \ 'defrec',
            \
            \ 'defparser',
            \
            \ 'defform',
            \ 'defform-',
            \
            \ 'defpage',
            \ 'defsketch'
            \
            \ ]

let g:clojure_syntax_keywords = {
    \ 'clojureMacro': [
            \ 'defproject',
            \ 'defcustom',
            \ 'defparser',
            \ 'deftest',
            \ 'match',
            \
            \ 'defproject',
            \
            \ 'defquery',
            \ 'defqueries',
            \
            \ 'defform',
            \
            \ 'deferror',
            \ 'when-found',
            \ 'when-valid',
            \
            \ 'defroutes',
            \ ],
    \ 'clojureFunc': ['string/join', 'string/replace']
    \ }

" Avoid red so I can easily see mismatched parens
let g:rbpt_colorpairs = [
    \ ['brown',       'RoyalBlue3'],
    \ ['Darkblue',    'SeaGreen3'],
    \ ['darkgray',    'DarkOrchid3'],
    \ ['darkgreen',   'chartreuse3'],
    \ ['darkcyan',    'RoyalBlue3'],
    \ ['darkblue',    'SeaGreen3'],
    \ ['darkmagenta', 'DarkOrchid3'],
    \ ['brown',       'DarkGoldenrod'],
    \ ['gray',        'RoyalBlue3'],
    \ ['black',       'SeaGreen3'],
    \ ['darkmagenta', 'DarkOrchid3'],
    \ ['Darkblue',    'DarkGoldenrod'],
    \ ['darkgreen',   'RoyalBlue3'],
    \ ['darkcyan',    'SeaGreen3'],
    \ ['darkmagenta', 'DarkOrchid3'],
    \ ['darkyellow',  'SlateBlue1'],
    \ ]


""""""""""""""""""""""" }}}
" Ruby                  {{{
"""""""""""""""""""""""

augroup grass_ruby
  autocmd!

  " Arb
  autocmd BufNewFile,BufRead *.arb set filetype=ruby
augroup END

let ruby_fold = 1

" Rspec
map <Leader>tc :call RunCurrentSpecFile()<CR>
map <Leader>tn :call RunNearestSpec()<CR>
map <Leader>l :call RunLastSpec()<CR>
let g:rspec_command = "!rspec --format doc --no-color {spec}"


""""""""""""""""""""""" }}}
" Lisp                  {{{
"""""""""""""""""""""""

augroup grass_lisps
  autocmd!

  autocmd filetype lisp,scheme RainbowParenthesesActivate
  autocmd syntax   lisp,scheme RainbowParenthesesLoadRound
  autocmd syntax   lisp,scheme RainbowParenthesesLoadSquare
  autocmd syntax   lisp,scheme RainbowParenthesesLoadBraces

  autocmd filetype lisp,scheme setlocal foldmethod=marker
augroup END

let g:slimv_swank_scheme = '!~/.vim/tools/slimv/iterm.applescript "scheme" --load "~/.vim/tools/slimv/swank-mit-scheme.scm"'
let g:slimv_leader = '\'
let g:slimv_disable_clojure = 1
let g:slimv_repl_split = 4

let g:paredit_disable_clojure = 1
let g:paredit_electric_return = 0


""""""""""""""""""""""" }}}
" Vagrant               {{{
"""""""""""""""""""""""

augroup grass_vagrant
  au!
  au BufRead,BufNewFile Vagrantfile set ft=ruby
augroup END


""""""""""""""""""""""" }}}
" Javascript and Coffee {{{
"""""""""""""""""""""""

augroup grass_js
  autocmd!

  " Setup JSON files
  autocmd BufNewFile,BufRead *.json set ft=json

  " Reformat JSON
  autocmd FileType json noremap <buffer> <leader>rff <Esc>:% !js-beautify -f - -s 2 --brace-style=expand<CR>

  " Indent folding for coffee (off by default) and undo vim-coffeescript
  " screwing with my formatoptions
  autocmd BufNewFile,BufReadPost *.coffee setlocal foldmethod=indent nofoldenable formatoptions-=o

augroup END


""""""""""""""""""""""" }}}
" Vimscript             {{{
"""""""""""""""""""""""

augroup ft_vim
    au!

    au FileType help setlocal textwidth=78
    au FileType vim setlocal foldmethod=marker

    " Help windows big on the right
    au BufWinEnter *.txt if &ft == 'help' | wincmd L | endif
augroup END


""""""""""""""""""""""" }}}
" Misc file types       {{{
"""""""""""""""""""""""

augroup grass_miscfiles
  autocmd!

  " Set wrap and shift size for text files
  autocmd BufRead,BufNewFile *.txt setlocal wrap tabstop=4 softtabstop=4 shiftwidth=4

  " In Makefiles, use real tabs, not tabs expanded to spaces
  autocmd FileType make set noexpandtab

  " make Python follow PEP8 ( http://www.python.org/dev/peps/pep-0008/ )
  autocmd FileType python setlocal softtabstop=4 tabstop=4 shiftwidth=4 textwidth=79

  " Less
  autocmd BufNewFile,BufRead *.less set filetype=less
augroup END

" Configure browser for haskell_doc.vim
let g:haddock_browser = "open"
let g:haddock_browser_callformat = "%s %s"


""""""""""""""""""""""" }}}
" Shortcut commands     {{{
"""""""""""""""""""""""

" Show cheats
command! Cheats :normal :silent! tabnew ~/Dropbox/Notes/Vim.md<cr>

" Edit hot files
command! Myrc :normal :edit $MYVIMRC<cr>
command! Notes :normal :silent! vsplit ~/Dropbox/Notes<cr>4j
command! WorkLog :normal :silent! edit ~/Dropbox/Notes/Work\ Log.md<cr>
command! Scratch :normal :silent! edit ~/Dropbox/Notes/Scratch.md<cr>

" Directory shortcuts in command mode
cnoremap <expr> nn  getcmdtype() == ':' ? fnameescape('~/Dropbox/Notes').'/' : 'nn'
cnoremap <expr> pp  getcmdtype() == ':' ? fnameescape('~/code/projects').'/' : 'pp'


""""""""""""""""""""""" }}}
" Snippets              {{{
"""""""""""""""""""""""

let g:UltiSnipsSnippetDirectories    = ["UltiSnips", "mysnippets"]
" Overcome Vundle runtime path so snippet overrides work
let g:UltiSnipsDontReverseSearchPath = "1"


""""""""""""""""""""""" }}}
" GUI                   {{{
"""""""""""""""""""""""

" Toggle indent guides
noremap <leader>vi :IndentGuideToggle<cr>

" Show the syntax group in place on the text under the cursor
nnoremap <F10> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
\ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
\ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>

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

  highlight SpellBad term=underline gui=undercurl guisp=Orange
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

