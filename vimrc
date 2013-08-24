set nocompatible                  " Must come first because it changes other options.
filetype off
autocmd

" Let leader key
let mapleader=","

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle
Bundle 'gmarik/vundle'
Bundle 'tpope/vim-rails'
Bundle 'tpope/vim-haml'
Bundle 'mileszs/ack.vim'
Bundle 'tpope/vim-rake'
Bundle 'tpope/vim-fugitive'
Bundle 'tpope/vim-endwise'
Bundle 'tpope/vim-surround'
Bundle 'ervandew/supertab'
Bundle 'tpope/vim-cucumber'
Bundle 'vim-scripts/ZoomWin'
Bundle 'msanders/snipmate.vim'
Bundle 'mattn/gist-vim'
Bundle 'tpope/vim-git'
Bundle 'tpope/vim-unimpaired'
Bundle 'cakebaker/scss-syntax.vim'
Bundle 'itspriddle/vim-jquery'
Bundle 'scrooloose/nerdcommenter'
Bundle 'vim-scripts/bufexplorer.zip'
Bundle 'vim-scripts/taglist.vim'
Bundle 'vim-scripts/bufkill.vim'
Bundle 'chrismetcalf/vim-yankring'
Bundle 'sjl/gundo.vim'
Bundle 'tpope/vim-markdown'
Bundle 'vim-scripts/buftabs'
Bundle 'majutsushi/tagbar'
Bundle 'vim-scripts/louver.vim'
Bundle 'sjl/badwolf'
Bundle 'slim-template/vim-slim'
Bundle 'airblade/vim-gitgutter'
Bundle 'kana/vim-textobj-user'

" Javascript {{{
Bundle 'kchmck/vim-coffee-script'
Bundle 'pangloss/vim-javascript'
" }}}

" Ruby {{{
Bundle 'vim-ruby/vim-ruby'
Bundle 'nelstrom/vim-textobj-rubyblock'
Bundle 'ecomba/vim-ruby-refactoring'
" }}}

" RSpec {{{
Bundle 'thoughtbot/vim-rspec'

map <Leader>t :call RunCurrentSpecFile()<CR>
map <Leader>s :call RunNearestSpec()<CR>
map <Leader>l :call RunLastSpec()<CR>
map <Leader>a :call RunAllSpecs()<CR>
" }}}

" Syntax {{{
" Syntastic
Bundle 'scrooloose/syntastic'
let g:syntastic_enable_signs=1 " Enable syntastic syntax checking
"let g:syntastic_quiet_warnings=1

" }}}

" Searching {{{
" Command-T
Bundle 'wincent/Command-T'
let g:CommandTMaxHeight=15
nmap <silent> <Leader>b :CommandTFlush<cr>\|:CommandTBuffer<CR>
map <leader>f :CommandTFlush<cr>\|:CommandT <cr>
map <leader>F :CommandTFlush<cr>\|:CommandT %%<cr>

" Ctrl-P
Bundle 'kien/ctrlp.vim'

" }}}

" Tabularize {{{
Bundle 'godlygeek/tabular'

if exists(":Tabularize")
  nmap <Leader>a= :Tabularize /=<CR>
  vmap <Leader>a= :Tabularize /=<CR>
  nmap <Leader>a: :Tabularize /:\zs<CR>
  vmap <Leader>a: :Tabularize /:\zs<CR>
endif

" }}}

" Indent Guides {{{
Bundle 'nathanaelkane/vim-indent-guides'

" Set the color change percent higher since you can just switch them on and off might as well see clearly ;)
let g:indent_guides_color_change_percent=30

" }}}


" Themes {{{
Bundle 'altercation/vim-colors-solarized'
Bundle 'tomasr/molokai'
Bundle 'jnurmine/Zenburn'
Bundle 'wgibbs/vim-irblack'
Bundle 'tpope/vim-vividchalk'
Bundle 'daoo/Mustang2'
Bundle 'fmoralesc/vim-vitamins'
Bundle 'grillpanda/github-colorscheme'
Bundle 'nelstrom/vim-mac-classic-theme'
Bundle 'vim-scripts/mayansmoke'
" }}}

set number                        " Show line numbers.
set ruler                         " Show cursor position.
set encoding=utf-8

syntax on                 " Without this it does not generate the helptags
syntax enable             " Turn on syntax highlighting.
set autoindent
filetype plugin indent on " Turn on file type detection.

" Solarized theme
set t_Co=256
let g:solarized_termcolors=256
set background=light
color solarized
"color mustang

" disable match parentheses hopefully speed up
" file loading
let g:loaded_matchparen = 1

set cursorline
set cmdheight=2
set switchbuf=useopen
set showtabline=2

set showmatch                     " Show matching brackets
set showcmd                       " Display partial/incomplete commands in the status line.
set showmode                      " Display the mode you're in.

" Hightlight whitespace
set list
set listchars=tab:\ \ ,trail:·

" History
set history=100                   " Commands to remember in history
set undolevels=100                " Undo level history

set hidden                        " Hide buffers instead of closing them

set wildmenu                                " Enhanced command line completion.
set wildmode=list:longest,list:full         " Complete files like a shell.
set wildignore=*.swp,*.bak,*.pyc,*.o,*.obj,*.class,*.rbc,.git,.svn,vendor/gems,vendor/bundle/**,vendor/cache/**,log/**,public/assets/**,tmp/**

" Searching
set incsearch                  " Highlight matches as you type.
set hlsearch                   " Highlight matches.
set ignorecase                 " Case-insensitive searching.
set smartcase                  " But case-sensitive if expression contains a capital letter.

" Whitespace
set nowrap                     " Turn off line wrapping.
set tabstop=2                  " Global tab width.
set shiftwidth=2               " And again, related.
set expandtab                  " Use spaces instead of tabs
set softtabstop=2

" Code Folding
" -------------------
" help fold-methods
" help folding
" help folds
" http://stackoverflow.com/questions/4789605/how-do-i-enable-automatic-folds-in-vim

set foldmethod=syntax
set foldlevelstart=1
set nofoldenable    " disable auto-folding


let javaScript_fold=1         " JavaScript
let perl_fold=1               " Perl
let php_folding=1             " PHP
let r_syntax_folding=1        " R
"let ruby_fold=1               " Ruby
let sh_fold_enabled=1         " sh
let vimsyn_folding='af'       " Vim script
let xml_syntax_folding=1      " XML


set backspace=indent,eol,start " allow backspacing over everything in insert mode

set scrolloff=3                   " Show 3 lines when scrolling off the buffer

set title                         " Set the terminal's title

set visualbell                    " No beeping.
set noerrorbells                  " No beeping.

" Until i figure things out then ill switch the backup off
set nobackup                      " Don't make a backup before overwriting a file.
set nowritebackup                 " And again.
set noswapfile
" set directory=$HOME/.vim/tmp//,.  " Keep swap files in one location
" Directories for swp files
set backup
set backupdir=~/.vim/backup
set directory=~/.vim/backup

" Pasting
set pastetoggle=<F2>              " Stupid paste. No auto-indent

set clipboard+=unnamed  " Yanks go on clipboard instead.


" Status Line
" https://github.com/mislav/vimfiles
if has("statusline") && !&cp
  set laststatus=2  " always show the status bar
  " Start the status line
  set statusline=%f\ %m\ %r
  " Add fugitive
  set statusline+=%{fugitive#statusline()}
endif

map <up> <nop>
map <down> <nop>
map <left> <nop>
map <right> <nop>

" Easy window navigation
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

" In insert mode, C-o and C-b open lines below and above
imap <C-o> <end><cr>
imap <C-b> <home><cr><Up>

" In visual line mode, I always accidently keep the shift key down
" which causes me to join lines (or lookup a keyword) instead of highlight them.
vnoremap K k
vnoremap J j

" keep selection when changing indention level
vnoremap < <gv
vnoremap > >gv
" or use tab...
vmap <tab> >gv
vmap <s-tab> <gv

" switch buffers with leader leader
nnoremap <leader><leader> <c-^>

" clear the search buffer when hitting return
nnoremap <CR> :nohlsearch<cr>
" Clear highlighted search history using ,/
nmap <silent> ,/ :silent :nohlsearch<CR>

" Forgot to use sudo? just use !!w instead
"cmap !!w w !sudo tee % >/dev/null

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

" make uses real tabs
au FileType make set noexpandtab

" Filetypes
au BufRead,BufNewFile *.txt call s:setupWrapping()
au BufRead,BufNewFile *.scss set filetype=scss        " SCSS Files
au BufRead,BufNewFile jquery.*.js set ft=javascript syntax=jquery
au BufRead,BufNewFile *.ejs set filetype=js.html
au BufNewFile,BufReadPost *.coffee setl shiftwidth=2 ft=coffee expandtab foldmethod=indent nofoldenable

" Commit Edit Msg file type
au BufRead,BufNewFile {COMMIT_EDITMSG}                                set ft=gitcommit

" Thorfile, Rakefile, Vagrantfile and Gemfile are Ruby
au BufRead,BufNewFile {Gemfile,Rakefile,Vagrantfile,Thorfile,config.ru}    set ft=ruby

" md, markdown, and mk are markdown and define buffer-local preview
au BufRead,BufNewFile *.{md,markdown,mdown,mkd,mkdn} call s:setupMarkup()

" add json syntax highlighting
au BufNewFile,BufRead *.json set ft=javascript

" make Python follow PEP8 ( http://www.python.org/dev/peps/pep-0008/ )
au FileType python set softtabstop=4 tabstop=4 shiftwidth=4 textwidth=79

" Opens an edit command with the path of the currently edited file filled in
" Normal mode: <Leader>e
map <Leader>e :e <C-R>=expand("%:p:h") . "/" <CR>

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

" http://vimcasts.org/e/14
cnoremap %% <C-R>=expand('%:h').'/'<cr>

" Automagically align stuff using tabular for cucumber
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

" Ruby indent hash
function IndentV()
  Tabularize /^[^:]*\zs:/r1c0l0
  Tabularize /^[^=>]*\zs=>/l1
endfunction
vmap <Leader>iv :call IndentV()

" Add some teaching/learning maps for now
" Regenerate tags
" for rvm: `rvm gemdir`/gems/* `rvm gemdir`/bundler/gems/*<CR><C-M>
map <leader>rt :!ctags --extra=+f --languages=-javascript --exclude=.git --exclude=log -R * ./vendor/bundle/ruby/*/gems/*/lib/*<CR><C-M>

" vim-rooter
let g:rooter_use_lcd = 1
