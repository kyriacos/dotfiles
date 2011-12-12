if has("gui_macvim")
  " Fullscreen takes up entire screen
  set fuoptions=maxhorz,maxvert

  " Command-T for CommandT
  macmenu &File.New\ Tab key=<D-T>
  map <D-t> :CommandT<CR>
  imap <D-t> <Esc>:CommandT<CR>

  " Command-Return for fullscreen
  macmenu Window.Toggle\ Full\ Screen\ Mode key=<D-CR>

  " Command-Shift-F for Ack
  map <D-F> :Ack<space>

  " Command-e for ConqueTerm
  map <D-e> :call StartTerm()<CR>

  " Command-/ to toggle comments
  map <D-/> <plug>NERDCommenterToggle<CR>
  imap <D-/> <Esc><plug>NERDCommenterToggle<CR>i

  " Command-][ to increase/decrease indentation
  vmap <D-]> >gv
  vmap <D-[> <gv

  set guifont=Inconsolata:h14
  "set guifont=Monaco:h14
  " Start without the toolbar
  set guioptions-=T
  " Remove the scrollbar
  "set guioptions-=r
  "set guioptions-=R
  set guioptions-=L " the left scroll bar only

  " Default gui color scheme
  "color ir_black
  "color solarized
  set background=dark
  color mustang

  " Dont beep
  set visualbell
endif

