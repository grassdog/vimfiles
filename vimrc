
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
" This currently hard wraps at 85 columns because I can't work out a way to
" soft wrap to a column width that is smaller than the window
function s:setupWrapping()
  setlocal textwidth=85
  setlocal linebreak
  setlocal nolist
endfunction


""""""""""""""""
"" Basic Setup
""""""""""""""""

set nocompatible      " Use vim, no vi defaults
set number            " Show line numbers
syntax enable         " Turn on syntax highlighting allowing local overrides
set encoding=utf-8    " Set default encoding to UTF-8
set hidden            " Hide buffers, don't close them


"""""""""""""""
"" Whitespace
"""""""""""""""

set wrap                              " wrap lines
set tabstop=2                         " a tab is two spaces
set shiftwidth=2                      " an autoindent (with <<) is two spaces
set expandtab                         " use spaces, not tabs

" Display tabs and whitepace
set list
set listchars=tab:·\ ,trail:·,extends:»,precedes:«

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
noremap <leader><space> :set hlsearch! hlsearch?<CR>


""""""""""""""""""""
"" Tab Completion
""""""""""""""""""""

" Disable output and VCS files
set wildignore+=*.o,*.out,*.obj,.git,*.rbc,*.class,.svn,*.gem,.DS_Store

" Disable archive files
set wildignore+=*.zip,*.tar.gz,*.tar.bz2,*.rar,*.tar.xz

" Ignore bundler and sass cache
set wildignore+=**/vendor/gems/*,**/vendor/bundle/*,**/vendor/cache/*,**/.bundle/*,**/b/*,.sass-cache/*,doc/**,**/tmp/**

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
set showcmd


"""""""""""""""""""""""
"" Visual feedback
"""""""""""""""""""""""

set scrolloff=3       " Always show at least three lines below cursor
set mat=3             " Blink matching brackets for 3 tenths of a second
set visualbell t_vb=  " No Noise or bell

" Color scheme
let g:solarized_menu=0
let g:solarized_contrast="high"

set background=dark
colorscheme solarized

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" General Mappings (Normal, Visual, Operator-pending)
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Map the arrow keys to be based on display lines, not physical lines
noremap <Down> gj
noremap <Up> gk

" Stop page movement on shift arrow
noremap <S-Down> <Down>
noremap <S-Up> <Up>

" Map ZoomWin
noremap <leader>zz :ZoomWin<CR>

" Use tab instead of % for brace matching
nmap <tab> %
vnoremap <tab> %

" Yank to the end of the line
noremap Y y$

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
noremap <D-M-Up> <C-w>k
inoremap <D-M-Up> <Esc> <C-w>k
noremap <D-M-Down> <C-w>j
inoremap <D-M-Down> <Esc> <C-w>j
noremap <D-M-Right> <C-w>l
inoremap <D-M-Right> <Esc> <C-w>l
noremap <D-M-Left> <C-w>h
inoremap <D-M-Left> <C-w>h

" Adjust viewports to the same size
noremap <Leader>= <C-w>=
inoremap <Leader>= <Esc> <C-w>=

" Open a new vertical split
noremap <leader>v <C-w>v<C-w>l

" Toggle indent guides
noremap <leader>vi :IndentGuideToggle<cr>

" Switch to last buffer
nnoremap <leader><leader> <c-^>

" Without setting this, ZoomWin restores windows in a way that causes
" equalalways behavior to be triggered the next time CommandT is used.
" This is likely a bludgeon to solve some other issue, but it works
set noequalalways

" Setup my language
set spelllang=en_au

"""""""""""""""""
"" File Types
"""""""""""""""""

" Turn on filetype plugins
filetype plugin indent on

" Remember last location in file, but not for commit messages.
" see :help last-position-jump
au BufReadPost * if &filetype !~ '^git\c' && line("'\"") > 0 && line("'\"") <= line("$")
  \| exe "normal! g`\"" | endif

" In Makefiles, use real tabs, not tabs expanded to spaces
au FileType make set noexpandtab

" Setup JSON files
au BufNewFile,BufRead *.json set ft=json

" make Python follow PEP8 ( http://www.python.org/dev/peps/pep-0008/ )
au FileType python setlocal softtabstop=4 tabstop=4 shiftwidth=4 textwidth=79

" Markdown and txt files should wrap
au BufRead,BufNewFile *.{md,markdown,mdown,mkd,mkdn,txt} call s:setupWrapping()

" Preview markdown files in Marked app
nnoremap <leader>mp :silent !open -a Marked.app '%:p'<cr>

" Less
au BufNewFile,BufRead *.less set filetype=less

" Add indent stuff for scheme files
au filetype lisp,scheme,art setlocal equalprg=~/.vim/janus-tools/scheme-indent/scmindent.scm

" Change tab width for markdown
au FileType markdown setlocal softtabstop=4 tabstop=4 shiftwidth=4

" Highlight VCS conflict markers
match ErrorMsg '^\(<\|=\|>\)\{7\}\([^=].\+\)\?$'

""""""""""""""""""""""""""""
"" Editing commands
""""""""""""""""""""""""""""

" Normal Mode: Bubble single lines
nnoremap <C-Up> [e
nnoremap <C-Down> ]e

" Visual Mode: Bubble multiple lines
vnoremap <C-Up> [egv
vnoremap <C-Down> ]egv

" Remove trailing white space from file
command! KillWhitespace :normal :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar>:nohl<CR>

" Insert today's date as a markdown header
nnoremap <leader>id "=strftime("# %Y-%m-%d")<CR>P

" Format the entire file
nnoremap <leader>rff ggVG=

" Re-wrap the entire file
nnoremap <leader>rwf ggVGgq

" Reformat XML files
noremap <leader>rfx <Esc>:% !xmllint --format -<CR>

" Reformat HTML files
noremap <leader>rfh <Esc>:% !tidy -quiet  -indent --indent-spaces 2 --wrap 90<CR>

" Reformat JSON
noremap <leader>rfj <Esc>:% !js-beautify -i -s 2 --brace-style=expand<CR>

" use :w!! to write to a file using sudo if you forgot to 'sudo vim file'
" (it will prompt for sudo password when writing)
cnoremap w!! %!sudo tee > /dev/null %

" Underline the current line with '='
nnoremap <silent> <leader>ul :t.\|s/./=/g\|:nohls<cr>

" Find merge conflict markers
nnoremap <silent> <leader>mm <ESC>/\v^[<=>]{7}( .*\|$)<CR>

" Edit my vimrc
nnoremap <leader>ev :vsplit $MYVIMRC<cr>

""""""""""""""""""""""""""
"" Fix common mistypings
""""""""""""""""""""""""""

iabbrev teh the

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

" Seach for current word in Ack
nnoremap <bs> :Ack! '\b<c-r><c-w>\b'<cr>

" Powerline
let g:Powerline_symbols = 'fancy'

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

noremap <leader>p :CtrlPBuffer<cr>
noremap <leader>f :CtrlP<cr>
noremap <leader>d :CtrlPCurFile<cr>

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

autocmd BufEnter * call s:setcwd()


" NerdTree

" Close vim if NerdTree is the only remaining open window
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

noremap <leader>n :NERDTreeToggle<cr>
noremap <leader>rr :NERDTreeFind<cr>

" Clojure

let g:vimclojure#ParenRainbow = 1
let g:vimclojure#HighlightBuiltins = 1

" TODO Get a REPL working with vim
"let vimclojure#WantNailgun = 1

" Show cheats
command! Cheats :normal :silent! tabnew ~/.vim/cheats.md<cr>

" Edit hot files
command! WorkLog :normal :silent! edit ~/Dropbox/Notes/Work\ Log.md<cr>
command! Journal :normal :silent! edit ~/Dropbox/Notes/Journal.md<cr>
command! Spad :normal :silent! edit ~/Dropbox/Notes/Scratch.md<cr>

" Write all buffers once I lose focus
au FocusLost * :silent! wall

"""""""""""""
" GUI stuff
"""""""""""""

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
  set guifont=Menlo\ for\ Powerline:h12

  " Map command-[ and command-] to indenting or outdenting
  " while keeping the original selection in visual mode
  vnoremap <D-]> >gv
  vnoremap <D-[> <gv

  nnoremap <D-]> >>
  nnoremap <D-[> <<

  onoremap <D-]> >>
  onoremap <D-[> <<

  inoremap <D-]> <Esc>>>i
  inoremap <D-[> <Esc><<i

  " Duplicate line
  nnoremap <D-d> yyp
  inoremap <D-d> <Esc>yypi

  " Comment lines
  nmap <D-/> <plug>NERDCommenterToggle<CR>
  vmap <D-/> <plug>NERDCommenterToggle<CR>
  imap <D-/> <Esc><plug>NERDCommenterToggle<CR>i

  " Automatically resize splits when resizing MacVim window
  autocmd VimResized * wincmd =

  " Command-Return for fullscreen
  macmenu Window.Toggle\ Full\ Screen\ Mode key=<D-CR>

  " Fullscreen takes up entire screen
  set fuoptions=maxhorz,maxvert

  " Hide some menus
  silent! aunmenu T&hemes
  silent! aunmenu Plugin
endif

