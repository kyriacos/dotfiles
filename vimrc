set nocompatible                  " Must come first because it changes other options.
autocmd

set number                        " Show line numbers.
set ruler                         " Show cursor position.

" Set encoding
set encoding=utf-8

" Pathogen configuration. 
" filetype off and ddback on again forces plugins to load correctly.
" http://blog.darevay.com/2010/10/a-brief-note-on-pathogen-for-vim/
silent! source ~/.vim/bundle/vim-pathogen/autoload/pathogen.vim
silent! call pathogen#runtime_append_all_bundles()
silent! call pathogen#helptags()
filetype off " On some Linux systems, this is necessary to make sure pathogen
             " picks up ftdetect directories in plugins!
syntax on													" Without this it does not generate the helptags
syntax enable                     " Turn on syntax highlighting.
set autoindent
filetype plugin indent on         " Turn on file type detection.

" Solarized theme
"let g:solarized_termcolors=256
"let g:solarized_contrast="high"
"color solarized
set t_Co=256
set background=dark
colorscheme mustang
" colorscheme ir_black

" Controversial...swap colon and semicolon for easier commands
" Also remember that commands you put in the vimrc they need to
" be prefixed by the key you choose if you change it.
" nnoremap ; :
" nnoremap : ;
" vnoremap ; :
" vnoremap : ;
map ; :
noremap ;; ;

" switch buffers with leader leader
nnoremap <leader><leader> <c-^>

" clear the search buffer when hitting return
:nnoremap <CR> :nohlsearch<cr>

"map :W :w
"imap <Space>i<Space> <Space>I<Space>

" Let leader key
let mapleader=","

" Quickly edit/reload the vimrc file
"nmap <silent> <leader>ev :e $MYVIMRC<CR>
" nmap <silent> <leader>sv :so $MYVIMRC<CR>
" Source the vimrc file after saving it
if has("autocmd")
  autocmd bufwritepost .vimrc source $MYVIMRC
endif

set showmatch                     " Show matching brackets
set showcmd                       " Display partial/incomplete commands in the status line.
set showmode                      " Display the mode you're in.

" Hightlight whitespace
set list
set listchars=tab:\ \ ,trail:·

set history=100                   " Commands to remember in history
set undolevels=100                " Undo level history

set hidden                        " Hide buffers instead of closing them

set wildmenu                                " Enhanced command line completion.
set wildmode=list:longest,list:full         " Complete files like a shell.
set wildignore=*.swp,*.bak,*.pyc,*.o,*.obj,*.class,*.rbc,.git,.svn,vendor/gems

" Searching
set incsearch                     " Highlight matches as you type.
set hlsearch                      " Highlight matches.
set ignorecase                    " Case-insensitive searching.
set smartcase                     " But case-sensitive if expression contains a capital letter.

" Whitespace
set nowrap                        " Turn off line wrapping.
set tabstop=2                    " Global tab width.
set shiftwidth=2                 " And again, related.
set softtabstop=2
set expandtab                    " Use spaces instead of tabs

set scrolloff=3                   " Show 3 lines of context around the cursor.

set title                         " Set the terminal's title

set visualbell                    " No beeping.
set noerrorbells                  " No beeping.

" Until i figure things out then ill switch the backup off
" set nobackup                      " Don't make a backup before overwriting a file.
" set nowritebackup                 " And again.
" set noswapfile
" set directory=$HOME/.vim/tmp//,.  " Keep swap files in one location
" Directories for swp files
set backupdir=~/.vim/backup
set directory=~/.vim/backup

set laststatus=2                  " Show the status line all the time

set pastetoggle=<F2>              " Stupid paste. No auto-indent

" Automatic fold settings for specific files. Uncomment to use.
"autocmd FileType ruby setlocal foldmethod=syntax
"autocmd FileType css  setlocal foldmethod=indent shiftwidth=2 tabstop=2

" KILL THE ARROW KEYS FOR NOW
map <up> <nop>
map <down> <nop>
map <left> <nop>
map <right> <nop>

" Easy window navigation
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

" In insert mode, hold down control to do movement, cursor keys suck.
imap <C-h> <Left>
imap <C-j> <Down>
imap <C-k> <Up>
imap <C-l> <Right>

" In insert mode, C-o and C-b open lines below and above
imap <C-o> <end><cr>
imap <C-b> <home><cr><Up>

" In visual line mode, I always accidently keep the shift key down
" which causes me to join lines (or lookup a keyword) instead of highlight 
" them.
vnoremap K k
vnoremap J j

" keep selection when changing indention level
vnoremap < <gv
vnoremap > >gv
" or use tab...
vmap <tab> >gv
vmap <s-tab> <gv

" Clear highlighted search history using ,/
nmap <silent> ,/ :silent :nohlsearch<CR>

" Forgot to use sudo? just use w!! instead
cmap w!! w !sudo tee % >/dev/null

" Use Q for formatting the current paragraph (or selection)
" vmap Q gq
" nmap Q gqap

" Remember last location in file
if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
    \| exe "normal g'\"" | endif
endif

" Got this from carlhuda janus bundle
function s:setupWrapping()
  set wrap
  set wrapmargin=2
  set textwidth=72
endfunction

function s:setupMarkup()
  call s:setupWrapping()
  let g:HammerTemplate="default_inline"
  map <buffer> <Leader>p :Hammer<CR>
endfunction

" make uses real tabs
au FileType make set noexpandtab

" Filetypes
au BufRead,BufNewFile *.scss set filetype=scss        " SCSS Files
au BufRead,BufNewFile jquery.*.js set ft=javascript syntax=jquery

" Thorfile, Rakefile, Vagrantfile and Gemfile are Ruby
au BufRead,BufNewFile {Gemfile,Rakefile,Vagrantfile,Thorfile,config.ru}    set ft=ruby

" md, markdown, and mk are markdown and define buffer-local preview
au BufRead,BufNewFile *.{md,markdown,mdown,mkd,mkdn} call s:setupMarkup()

" add json syntax highlighting
au BufNewFile,BufRead *.json set ft=javascript

au BufRead,BufNewFile *.txt call s:setupWrapping()

" make Python follow PEP8 ( http://www.python.org/dev/peps/pep-0008/ )
au FileType python set softtabstop=4 tabstop=4 shiftwidth=4 textwidth=79

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

" Opens an edit command with the path of the currently edited file filled in
" Normal mode: <Leader>e
map <Leader>e :e <C-R>=expand("%:p:h") . "/" <CR>

" Opens a tab edit command with the path of the currently edited file filled in
" Normal mode: <Leader>t
map <Leader>te :tabe <C-R>=expand("%:p:h") . "/" <CR>

" Inserts the path of the currently edited file into a command
" Command mode: Ctrl+P
cmap <C-P> <C-R>=expand("%:p:h") . "/" <CR>

" Unimpaired configuration
" Bubble single lines
nmap <C-Up> [e
nmap <C-Down> ]e
" Bubble multiple lines
vmap <C-Up> [egv
vmap <C-Down> ]egv

" Enable syntastic syntax checking
let g:syntastic_enable_signs=1
let g:syntastic_quiet_warnings=1

" gist-vim defaults
if has("mac")
  let g:gist_clip_command = 'pbcopy'
elseif has("unix")
  let g:gist_clip_command = 'xclip -selection clipboard'
endif
let g:gist_detect_filetype = 1
let g:gist_open_browser_after_post = 1

" Use modeline overrides
set modeline
set modelines=10

" % to bounce from do to end etc.
runtime! macros/matchit.vim

" Command-T configuration
let g:CommandTMaxHeight=20
nmap <silent> <Leader>b :CommandTBuffer<CR>
nmap <silent> <Leader>t :CommandT<CR>
" http://vimcasts.org/e/14
cnoremap %% <C-R>=expand('%:h').'/'<cr>
map <leader>F :CommandTFlush<cr>\|:CommandT %%<cr>

" Tabular Config
let mapleader=','
if exists(":Tabularize")
  nmap <Leader>a= :Tabularize /=<CR>
  vmap <Leader>a= :Tabularize /=<CR>
  nmap <Leader>a: :Tabularize /:\zs<CR>
  vmap <Leader>a: :Tabularize /:\zs<CR>
endif

" Automagically align stuff using tabular
" for cucumber
inoremap <silent> <Bar>   <Bar><Esc>:call <SID>align()<CR>a
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

" To auto generate Ctags for gems in current gemset
"autocmd FileType ruby let &l:tags = pathogen#legacyjoin(pathogen#uniq(
     "\ pathogen#split(&tags) +
     "\ map(split($GEM_PATH,':'),'v:val."/gems/*/tags"')))

" Ruby indent hash
function IndentV()
	Tabularize /^[^:]*\zs:/r1c0l0
	Tabularize /^[^=>]*\zs=>/l1
endfunction
vmap <Leader>iv :call IndentV()

" autocmd rooter BufEnter *.coffee, *.scss :Rooter

" NERDTree configuration
let NERDTreeIgnore=['\.pyc$', '\.rbc$', '\~$']
map <Leader>n :NERDTreeToggle<CR>

" GRB: use fancy buffer closing that doesn't close the split
" This used to use Bclose command which works great but since then i found
" this other script on wikia which seems to have improved it
cnoremap <expr> bd (getcmdtype() == ':' ? 'Kwbd' : 'bd')

""""""Big Script
" here is a more exotic version of my original Kwbd script
" delete the buffer; keep windows; create a scratch buffer if no buffers left
" http://vim.wikia.com/wiki/VimTip165
" same as BufKill
function s:Kwbd(kwbdStage)
  if(a:kwbdStage == 1)
    if(!buflisted(winbufnr(0)))
      bd!
      return
    endif
    let s:kwbdBufNum = bufnr("%")
    let s:kwbdWinNum = winnr()
    windo call s:Kwbd(2)
    execute s:kwbdWinNum . 'wincmd w'
    let s:buflistedLeft = 0
    let s:bufFinalJump = 0
    let l:nBufs = bufnr("$")
    let l:i = 1
    while(l:i <= l:nBufs)
      if(l:i != s:kwbdBufNum)
        if(buflisted(l:i))
          let s:buflistedLeft = s:buflistedLeft + 1
        else
          if(bufexists(l:i) && !strlen(bufname(l:i)) && !s:bufFinalJump)
            let s:bufFinalJump = l:i
          endif
        endif
      endif
      let l:i = l:i + 1
    endwhile
    if(!s:buflistedLeft)
      if(s:bufFinalJump)
        windo if(buflisted(winbufnr(0))) | execute "b! " . s:bufFinalJump | endif
      else
        enew
        let l:newBuf = bufnr("%")
        windo if(buflisted(winbufnr(0))) | execute "b! " . l:newBuf | endif
      endif
      execute s:kwbdWinNum . 'wincmd w'
    endif
    if(buflisted(s:kwbdBufNum) || s:kwbdBufNum == bufnr("%"))
      execute "bd! " . s:kwbdBufNum
    endif
    if(!s:buflistedLeft)
      set buflisted
      set bufhidden=delete
      set buftype=nofile
      setlocal noswapfile
    endif
  else
    if(bufnr("%") == s:kwbdBufNum)
      let prevbufvar = bufnr("#")
      if(prevbufvar > 0 && buflisted(prevbufvar) && prevbufvar != s:kwbdBufNum)
        b #
      else
        bn
      endif
    endif
  endif
endfunction

command! Kwbd call <SID>Kwbd(1)
nnoremap <silent> <Plug>Kwbd :<C-u>Kwbd<CR>

" Create a mapping (e.g. in your .vimrc) like this:
"nmap <C-W>! <Plug>Kwbd

" Easymotion. Disable the mappings. There's just too many of them
" let g:EasyMotion_do_mapping=0
let g:EasyMotion_leader_key="<Leader>ss"

" Indent Guides. Set the color change percent higher
" since you can just switch them on and off might as well see clearly ;)
let g:indent_guides_color_change_percent=20

" try this out with minibuf and remove if no luckI:e ~/.
let miniBufExplMaxSize=4
