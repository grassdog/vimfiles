
" Map Leader
let mapleader = ","

"""""""""""""""""""
"" Pathogen Setup
"""""""""""""""""""

let s:current_file = expand("<sfile>:p")

function s:add_group(name)
  let resolved = resolve(s:current_file)
  let dir = fnamemodify(resolved, ":h")
  let file = dir . "/" . a:name
  call pathogen#runtime_prepend_subdirectories(file)
endfunction


call s:add_group("langs")
call s:add_group("tools")
call s:add_group("colorpacks")

call pathogen#runtime_append_all_bundles()

" Some file types should wrap their text
function s:setupWrapping()
  set wrap
  set linebreak
  set textwidth=72
  set nolist
endfunction


""""""""""""""""
"" Basic Setup
""""""""""""""""

set nocompatible      " Use vim, no vi defaults
set number            " Show line numbers
set ruler             " Show line and column number
syntax enable         " Turn on syntax highlighting allowing local overrides
set encoding=utf-8    " Set default encoding to UTF-8


"""""""""""""""
"" Whitespace
"""""""""""""""

set nowrap                            " don't wrap lines
set tabstop=2                         " a tab is two spaces
set shiftwidth=2                      " an autoindent (with <<) is two spaces
set expandtab                         " use spaces, not tabs
set list listchars=tab:\ \ ,trail:.   " a tab should display as "  ", trailing whitespace as "."
set backspace=indent,eol,start        " backspace through everything in insert mode
set whichwrap+=<,>,h,l,[,]            "allow bs, del to cross lines
set listchars+=extends:>              " The character to show in the last column when wrap is
                                      " off and the line continues beyond the right of the screen
set listchars+=precedes:<             " The character to show in the last column when wrap is
                                      " off and the line continues beyond the right of the screen


"""""""""""""""
"" Searching
"""""""""""""""

set nohlsearch  " Don't highlight matches
set incsearch   " incremental searching
set ignorecase  " searches are case insensitive...
set smartcase   " ... unless they contain at least one capital letter

" Toggle search highlighting
map <leader><space> :set hlsearch! hlsearch?<CR>


""""""""""""""""""""
"" Tab Completion
""""""""""""""""""""

" Disable output and VCS files
set wildignore+=*.o,*.out,*.obj,.git,*.rbc,*.class,.svn,*.gem

" Disable archive files
set wildignore+=*.zip,*.tar.gz,*.tar.bz2,*.rar,*.tar.xz

" Ignore bundler and sass cache
set wildignore+=vendor/gems/*,vendor/cache/*,.bundle/*,.sass-cache/*,doc/**,tmp/**

""""""""""""""""""""""""""""
"" Undo and command history
""""""""""""""""""""""""""""
set undofile
set undoreload=10000
set history=1000

" Undo files
set undodir=~/.vim/tmp/undo//

" Don't close buffers, hide them
set hidden

"""""""""""""""
"" Status bar
"""""""""""""""

set laststatus=2  " always show the status bar
set showmode
set shortmess=atI " Shortens messages to avoid 'press a key' prompt

if has("statusline") && !&cp

  " Start the status line
  set statusline=%f\ %m\ %r

  " Finish the statusline
  set statusline+=\ \ Line:%l/%L[%p%%]
  set statusline+=\ \ Col:%v
  set statusline+=\ \ Buf:#%n
  set statusline+=\ \ [%b][0x%B]

  " Add fugitive
  set statusline+=\ \ %{fugitive#statusline()}
endif

"""""""""""""""""""""""
"" Visual feedback
"""""""""""""""""""""""

set scrolloff=3       " Always show at least three lines below cursor
set mat=3             " Blink matching brackets for 3 tenths of a second
set visualbell t_vb=  " No Noise or bell

" Color scheme (terminal)
set background=dark
colorscheme delek

""""""""""""""""""
" Other settings
""""""""""""""""""
set dictionary=/usr/share/dict/words

" Without setting this, ZoomWin restores windows in a way that causes
" equalalways behavior to be triggered the next time CommandT is used.
" This is likely a bludgeon to solve some other issue, but it works
set noequalalways


"""""""""""""""""
"" File Types
"""""""""""""""""

filetype plugin indent on " Turn on filetype plugins (:help filetype-plugin)

if has("autocmd")

  " Remember last location in file, but not for commit messages.
  " see :help last-position-jump
  au BufReadPost * if &filetype !~ '^git\c' && line("'\"") > 0 && line("'\"") <= line("$")
    \| exe "normal! g`\"" | endif

  " In Makefiles, use real tabs, not tabs expanded to spaces
  au FileType make set noexpandtab


  " Markdown and txt files should wrap
  au BufRead,BufNewFile *.{md,markdown,mdown,mkd,mkdn,txt} call s:setupWrapping()

  " Setup JSON files
  au BufNewFile,BufRead *.json set ft=json

  " make Python follow PEP8 ( http://www.python.org/dev/peps/pep-0008/ )
  au FileType python set softtabstop=4 tabstop=4 shiftwidth=4 textwidth=79

  " Less and Sass
  au BufNewFile,BufRead *.less set filetype=less

  " Add indent stuff for scheme files
  au filetype lisp,scheme,art setlocal equalprg=~/.vim/janus-tools/scheme-indent/scmindent.scm

  " Change tab width for markdown
  au FileType markdown set softtabstop=4 tabstop=4 shiftwidth=4
endif

" Highlight VCS conflict markers
match ErrorMsg '^\(<\|=\|>\)\{7\}\([^=].\+\)\?$'

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" General Mappings (Normal, Visual, Operator-pending)
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Map the arrow keys to be based on display lines, not physical lines
map <Down> gj
map <Up> gk
let macvim_hig_shift_movement = 1     " mvim shift-arrow-keys (required in vimrc)

" Make arrow keys work in visual mode
vnoremap <Left> h
vnoremap <Right> l
vnoremap <Up> k
vnoremap <Down> j

" Make cursor movement cross long lines
"nnoremap j gj
"nnoremap k gk
"nnoremap <down> gj
"nnoremap <up> gk

" Map ZoomWin
map <leader>zw :ZoomWin<CR>

" Use tab instead of % for brace matching
nmap <tab> %
vmap <tab> %

" Yank to the end of the line
map Y y$

" Fold html tags
nnoremap <leader>zfh Vatzf


"""""""""""""""""""""""""""
"" Command-Line Mappings
"""""""""""""""""""""""""""

" Insert the current directory into a command-line path
cmap <C-P> <C-R>=expand("%:p:h") . "/"


""""""""""""""""""""""""
"" Disable swap files
""""""""""""""""""""""""

set nobackup
set nowritebackup
set noswapfile


"""""""""""""""""""""""
"" Viewport Mappings
"""""""""""""""""""""""

" Command-Option-ArrowKey to switch viewports
map <D-M-Up> <C-w>k
imap <D-M-Up> <Esc> <C-w>k
map <D-M-Down> <C-w>j
imap <D-M-Down> <Esc> <C-w>j
map <D-M-Right> <C-w>l
imap <D-M-Right> <Esc> <C-w>l
map <D-M-Left> <C-w>h
imap <D-M-Left> <C-w>h

" Adjust viewports to the same size
map <Leader>= <C-w>=
imap <Leader>= <Esc> <C-w>=

" Open a new vertical split
map <leader>v <C-w>v<C-w>l

""""""""""""""""""""""""""""
"" Editing macros
""""""""""""""""""""""""""""

" Remove trailing white space from file
command! KillWhitespace :normal :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar>:nohl<CR>

" format the entire file
nmap <leader>rff ggVG=

" Reformat XML files
map <leader>rfx <Esc>:1,$!xmllint --format -<CR>

" upper/lower word
nmap <leader>u mQviwU`Q
nmap <leader>l mQviwu`Q

" upper/lower first char of word
nmap <leader>U mQgewvU`Q
nmap <leader>L mQgewvu`Q

" use :w!! to write to a file using sudo if you forgot to 'sudo vim file'
" (it will prompt for sudo password when writing)
cmap w!! %!sudo tee > /dev/null %

" cd to the directory containing the file in the buffer
nmap <silent> <leader>cd :lcd %:h<CR>

" Some helpers to edit mode
" http://vimcasts.org/e/14
cnoremap %% <C-R>=expand('%:h').'/'<cr>
map <leader>ew :e %%
map <leader>es :sp %%
map <leader>ev :vsp %%
map <leader>et :tabe %%

" Swap two words
nmap <silent> gw :s/\(\%#\w\+\)\(\_W\+\)\(\w\+\)/\3\2\1/<CR>`'

" Underline the current line with '='
nmap <silent> <leader>ul :t.\|s/./=/g\|:nohls<cr>

" set text wrapping toggles
nmap <silent> <leader>ztw :set invwrap<CR>:set wrap?<CR>

" find merge conflict markers
nmap <silent> <leader>zfc <ESC>/\v^[<=>]{7}( .*\|$)<CR>

" Unimpaired config

" Normal Mode: Bubble single lines
nmap <C-Up> [e
nmap <C-Down> ]e

" Visual Mode: Bubble multiple lines
vmap <C-Up> [egv
vmap <C-Down> ]egv

" Map Ack
map <leader>a :Ack<space>
imap <leader>a <Esc>:Ack<space>

" Comment lines
nmap <C-\> <plug>NERDCommenterToggle<CR>
vmap <C-\> <plug>NERDCommenterToggle<CR>
imap <C-\> <Esc><plug>NERDCommenterToggle<CR>i

""""""""""""""""""""""""""
"" Fix common mistypings
""""""""""""""""""""""""""

abbreviate teh the

""""""""""""""""""""""""""
"" Ctags config
""""""""""""""""""""""""""

" Open tag bar
map <leader>tb <Esc>:TagbarToggle<CR>

" Set our custom tag file path
set tags+=.tags
set tags+=.gems.tags

" Regenerate the tag lib
map <leader>zrt :!ctags-ruby -f .tags *<cr><cr>
map <leader>zrgt :!ctags-bundle<cr><cr>

" Reverse tag commands
nnoremap <c-]> g<c-]>
vnoremap <c-]> g<c-]>

nnoremap g<c-]> <c-]>
vnoremap g<c-]> <c-]>

"""""""""""""""""
"" Plugin Config
"""""""""""""""""

" No Solarized menu
let g:solarized_menu=0

" No Netrw menu
let g:netrw_menu=0

" Remove netrw history files
let g:netrw_dirhistmax = 0

" Disable useless HTML5 stuff
let g:event_handler_attributes_complete = 0
let g:rdfa_attributes_complete = 0
let g:microdata_attributes_complete = 0
let g:atia_attributes_complete = 0

" Buffergator
let g:buffergator_viewport_split_policy = 'B'
let g:buffergator_sort_regime = "mru"

" Jasmine snippets
let g:jasmine_snippets_directory = "~/.vim/mysnippets/jasmine"

" Gundo
let g:gundo_right = 1


""""""""""""""""""""""
"" Command T config
""""""""""""""""""""""

map <leader>gv :CommandTFlush<cr>\|:CommandT app/views<cr>
map <leader>gc :CommandTFlush<cr>\|:CommandT app/controllers<cr>
map <leader>gm :CommandTFlush<cr>\|:CommandT app/models<cr>
map <leader>gh :CommandTFlush<cr>\|:CommandT app/helpers<cr>
map <leader>gl :CommandTFlush<cr>\|:CommandT lib<cr>
map <leader>gf :CommandTFlush<cr>\|:CommandT features<cr>
map <leader>gs :CommandTFlush<cr>\|:CommandT spec<cr>
map <leader>gp :CommandTFlush<cr>\|:CommandT public<cr>
map <leader>ga :CommandTFlush<cr>\|:CommandT app/assets<cr>
map <leader>f :CommandTFlush<cr>\|:CommandT<cr>
map <leader>d :CommandTFlush<cr>\|:CommandT %%<cr>

" Switch to last buffer
nnoremap <leader><leader> <c-^>

" Show leader mappings
command! ShowLeaderMappings :normal :! grep -o ' <\<leader\>.*' ~/.vimrc | sort | uniq<cr>

" Show cheats
command! ShowCheats :normal :tabnew ~/.vim/vim-cheats.md<cr>

