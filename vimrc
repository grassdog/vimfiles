
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
colorscheme solarized

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" General Mappings (Normal, Visual, Operator-pending)
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Map the arrow keys to be based on display lines, not physical lines
map <Down> gj
map <Up> gk

" Map ZoomWin
map <leader>zz :ZoomWin<CR>

" Use tab instead of % for brace matching
nmap <tab> %
vmap <tab> %

" Yank to the end of the line
map Y y$

" Fold html tags
nnoremap <leader>zfh Vatzf

""""""""""""""""""""""""
"" Disable swap files and backups
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

" Switch to last buffer
nnoremap <leader><leader> <c-^>

" Without setting this, ZoomWin restores windows in a way that causes
" equalalways behavior to be triggered the next time CommandT is used.
" This is likely a bludgeon to solve some other issue, but it works
set noequalalways


"""""""""""""""""
"" File Types
"""""""""""""""""

" Turn on filetype plugins
filetype plugin indent on

if has("autocmd")

  " Remember last location in file, but not for commit messages.
  " see :help last-position-jump
  au BufReadPost * if &filetype !~ '^git\c' && line("'\"") > 0 && line("'\"") <= line("$")
    \| exe "normal! g`\"" | endif

  " In Makefiles, use real tabs, not tabs expanded to spaces
  au FileType make set noexpandtab

  " Setup JSON files
  au BufNewFile,BufRead *.json set ft=json

  " make Python follow PEP8 ( http://www.python.org/dev/peps/pep-0008/ )
  au FileType python set softtabstop=4 tabstop=4 shiftwidth=4 textwidth=79

  " Less
  au BufNewFile,BufRead *.less set filetype=less

  " Add indent stuff for scheme files
  au filetype lisp,scheme,art setlocal equalprg=~/.vim/janus-tools/scheme-indent/scmindent.scm

  " Change tab width for markdown
  au FileType markdown set softtabstop=4 tabstop=4 shiftwidth=4
endif

" Highlight VCS conflict markers
match ErrorMsg '^\(<\|=\|>\)\{7\}\([^=].\+\)\?$'

""""""""""""""""""""""""""""
"" Editing commands
""""""""""""""""""""""""""""

" Remove trailing white space from file
command! KillWhitespace :normal :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar>:nohl<CR>

" format the entire file
nmap <leader>rff ggVG=

" Reformat XML files
map <leader>rfx <Esc>:% !xmllint --format -<CR>

" Reformat HTML files
map <leader>rfh <Esc>:% !tidy -quiet  -indent --indent-spaces 2 --wrap 90<CR>

" Reformat JSON
map <leader>rfj <Esc>:% !js-beautify -i -s 2 --brace-style=expand<CR>

" use :w!! to write to a file using sudo if you forgot to 'sudo vim file'
" (it will prompt for sudo password when writing)
cmap w!! %!sudo tee > /dev/null %

" Underline the current line with '='
nmap <silent> <leader>ul :t.\|s/./=/g\|:nohls<cr>

" find merge conflict markers
nmap <silent> <leader>m <ESC>/\v^[<=>]{7}( .*\|$)<CR>


""""""""""""""""""""""""""
"" Fix common mistypings
""""""""""""""""""""""""""

abbreviate teh the

"""""""""
"" Ctags
"""""""""

" Set our custom tag file path
set tags+=.tags
set tags+=.gems.tags

" Regenerate the tag lib
command! GenRubyTags :normal :!ctags-ruby -f .tags *<cr><cr>
command! GenBundleTags :normal :!ctags-bundle<cr><cr>

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

" Jasmine snippets
let g:jasmine_snippets_directory = "~/.vim/mysnippets/jasmine"

" Gundo
let g:gundo_right = 1

" Switch default scss comment delimeters for NerdCommenter
let g:NERDCustomDelimiters = {
    \ 'scss': { 'left': '//', 'leftAlt': '/*', 'rightAlt': '*/' }
    \ }

" Ctrlp
let g:ctrlp_dont_split = 'NERD_tree_2'
let g:ctrlp_jump_to_buffer = 1
let g:ctrlp_working_path_mode = 0
let g:ctrlp_mruf_last_entered = 1
let g:ctrlp_match_window_reversed = 0
let g:ctrlp_split_window = 0
let g:ctrlp_max_height = 20
let g:ctrlp_use_caching = 0
"let g:ctrlp_extensions = ['tag']

map <leader>b :CtrlPBuffer<cr>
map <leader>f :CtrlP<cr>

" NerdTree

" Open NerdTree if no other file is open
autocmd vimenter * if !argc() | NERDTree | endif

" Close vim if NerdTree is the only remaining open window
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

map <leader>n :NERDTreeToggle<cr>

" Show cheats
command! ShowCheats :normal :tabnew ~/.vim/vim-cheats.md<cr>

" Show Work log
command! ShowWorkLog :normal :edit ~/Dropbox/Notes/Work\ Log.md<cr>

