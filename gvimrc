
if has("gui_macvim")
  set guifont=Menlo:h12

  " Map command-[ and command-] to indenting or outdenting
  " while keeping the original selection in visual mode
  vmap <D-]> >gv
  vmap <D-[> <gv

  nmap <D-]> >>
  nmap <D-[> <<

  omap <D-]> >>
  omap <D-[> <<

  imap <D-]> <Esc>>>i
  imap <D-[> <Esc><<i

  " Duplicate line
  nmap <D-d> yyp
  imap <D-d> <Esc>yypi

  if has("autocmd")
    " Automatically resize splits when resizing MacVim window
    autocmd VimResized * wincmd =
  endif

  " Command-Return for fullscreen
  macmenu Window.Toggle\ Full\ Screen\ Mode key=<D-CR>

  " Fullscreen takes up entire screen
  set fuoptions=maxhorz,maxvert

  " Hide some menus
  silent! aunmenu T&hemes
  silent! aunmenu Plugin
endif

" Show my current line
set cursorline

" No left scrollbar
set guioptions-=l
set guioptions-=L

" No toolbar
set guioptions-=T

" Default gui color scheme
set background=dark
colorscheme solarized

" Hide mouse after chars typed
set mousehide

