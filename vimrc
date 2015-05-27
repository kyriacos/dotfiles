" vimrc
" Author: Kyriacos Souroullas
" Source: https://github.com/kyriacos/vim
"
" Based on numerous other vim configs.
"
" All credit for the package loading goes to vimified
" by Zaiste!
" https://github.com/zaiste/vimified

set nocompatible
filetype off

" Load external configuration before anything else {{{
if filereadable(expand("~/.vim/before.vimrc"))
  source ~/.vim/before.vimrc
endif
" }}}

let mapleader = ","
let maplocalleader = "\\"

" Local vimrc configuration {{{
let s:localrc = expand($HOME . '/.vim/local.vimrc')
if filereadable(s:localrc)
  exec ':so ' . s:localrc
endif
" }}}

runtime! macros/matchit.vim " % to bounce from do to end etc.

" PACKAGE LIST {{{
" Use this variable inside your local configuration to declare
" which package you would like to include
if ! exists('g:vimified_packages')
  let g:vimified_packages = ['general', 'fancy', 'os', 'coding', 'color', 'python', 'ruby', 'html', 'css', 'js', 'clojure', 'haskell']
endif
" }}}

" VUNDLE {{{
  let s:bundle_path=$HOME."/.vim/bundle/"
  " execute "set rtp+=".s:bundle_path."vundle/"
  set rtp+=~/.vim/bundle/Vundle.vim
  call vundle#begin()

  Plugin 'gmarik/vundle.vim'
" }}}

" PACKAGES {{{

" Install user-supplied Plugins {{{
  let s:extrarc = expand($HOME . '/.vim/extra.vimrc')
  if filereadable(s:extrarc)
    exec ':so ' . s:extrarc
  endif
" }}}

" _. General {{{
if count(g:vimified_packages, 'general')
  " Searching {{{
    Plugin 'wincent/Command-T'
    let g:CommandTMaxHeight=15
    nmap <silent> <Leader>b :CommandTFlush<cr>\|:CommandTBuffer<CR>
    map <leader>f :CommandTFlush<cr>\|:CommandT <cr>
    map <leader>F :CommandTFlush<cr>\|:CommandT %%<cr>

    Plugin 'kien/ctrlp.vim'
  " }}}

   "Tabularize {{{
  Plugin 'godlygeek/tabular'

  if exists(":Tabularize")
    nmap <Leader>a= :Tabularize /=<CR>
    vmap <Leader>a= :Tabularize /=<CR>
    nmap <Leader>a: :Tabularize /:\zs<CR>
    vmap <Leader>a: :Tabularize /:\zs<CR>
  endif

  " }}}

  Plugin 'tpope/vim-unimpaired'
  " Bubble single lines
  nmap <C-Up> [e
  nmap <C-Down> ]e
  " Bubble multiple lines
  vmap <C-Up> [egv
  vmap <C-Down> ]egv

  Plugin 'mileszs/ack.vim'
  Plugin 'tpope/vim-endwise'
  Plugin 'tpope/vim-repeat'
  Plugin 'tpope/vim-speeddating'
  Plugin 'tpope/vim-surround'
  Plugin 'maxbrunsfeld/vim-yankstack'
  Plugin 'tpope/vim-eunuch'

  Plugin 'scrooloose/nerdtree'
  nmap <C-i> :NERDTreeToggle<CR>
  " Disable the scrollbars (NERDTree)
  set guioptions-=r
  set guioptions-=L

  Plugin 'kana/vim-textobj-user'
  " LOOK
  "Plugin 'vim-scripts/YankRing.vim'
  "let g:yankring_replace_n_pkey = '<leader>['
  "let g:yankring_replace_n_nkey = '<leader>]'
  "let g:yankring_history_dir = '~/.vim/tmp/'
  "nmap <leader>y :YRShow<cr>

  Plugin 'michaeljsmith/vim-indent-object'
  let g:indentobject_meaningful_indentation = ["haml", "sass", "python", "yaml", "markdown"]

  Plugin 'Spaceghost/vim-matchit'

  Plugin 'vim-scripts/scratch.vim'

  Plugin 'troydm/easybuffer.vim'
  nmap <leader>be :EasyBufferToggle<enter>

  Plugin 'terryma/vim-multiple-cursors'

  Plugin 'tpope/vim-rake'
  Plugin 'ervandew/supertab'
  Plugin 'tpope/vim-cucumber'
  Plugin 'vim-scripts/ZoomWin'
  Plugin 'mattn/gist-vim'
  Plugin 'tpope/vim-git'
  Plugin 'itspriddle/vim-jquery'
  Plugin 'vim-scripts/taglist.vim'
  Plugin 'vim-scripts/bufkill.vim'
  Plugin 'chrismetcalf/vim-yankring'
  Plugin 'sjl/gundo.vim'
  Plugin 'tpope/vim-markdown'
  Plugin 'vim-scripts/buftabs'
  Plugin 'majutsushi/tagbar'
  Plugin 'vim-scripts/louver.vim'
  Plugin 'sjl/badwolf'
  Plugin 'slim-template/vim-slim'
endif
" }}}

" _. Fancy {{{
  if count(g:vimified_packages, 'fancy')
    Plugin 'bling/vim-airline'
    let g:airline_left_sep = ''
    let g:airline_right_sep = ''
    let g:airline_branch_prefix = ''
  endif
" }}}

" _. Indent {{{
  if count(g:vimified_packages, 'indent')
    Plugin 'nathanaelkane/vim-indent-guides'
    map <Leader>ig :IndentGuidesToggle<cr>

    set ts=1 sw=1 et
    let g:indent_guides_color_change_percent=30
    let g:indent_guides_start_level=2
    let g:indent_guides_guide_size=1
  endif
" }}}

" _. OS {{{
  if count(g:vimified_packages, 'os')
    Plugin 'zaiste/tmux.vim'
    Plugin 'benmills/vimux'
    map <Leader>rp :VimuxPromptCommand<CR>
    map <Leader>rl :VimuxRunLastCommand<CR>

    map <LocalLeader>d :call VimuxRunCommand(@v, 0)<CR>

    " Vipe
    Plugin 'luan/vipe'
  endif
" }}}

" _. Coding {{{

  if count(g:vimified_packages, 'coding')
    Plugin 'majutsushi/tagbar'
    nmap <leader>tb :TagbarToggle<CR>

    "Plugin 'gregsexton/gitv'

    " the msanders version conflicts with supertab
    " Snipmate {{{
      Plugin "MarcWeber/vim-addon-mw-utils"
      Plugin "tomtom/tlib_vim"
      Plugin 'garbas/vim-snipmate'
    " }}}

    Plugin 'scrooloose/nerdcommenter'
    nmap <leader># :call NERDComment(0, "invert")<cr>
    vmap <leader># :call NERDComment(0, "invert")<cr>

    Plugin 'sjl/splice.vim'

    Plugin 'tpope/vim-fugitive'
    "nmap <leader>g :Ggrep
    " ,f for global git serach for word under the cursor (with highlight)
    "nmap <leader>f :let @/="\\<<C-R><C-W>\\>"<CR>:set hls<CR>:silent Ggrep -w "<C-R><C-W>"<CR>:ccl<CR>:cw<CR><CR>
    " same in visual mode
    ":vmap <leader>f y:let @/=escape(@", '\\[]$^*.')<CR>:set hls<CR>:silent Ggrep -F "<C-R>=escape(@", '\\"#')<CR>"<CR>:ccl<CR>:cw<CR><CR>

    Plugin 'scrooloose/syntastic'
    "let g:syntastic_enable_signs=1
    let g:syntastic_auto_loc_list=1
    let g:syntastic_mode_map = { 'mode': 'active', 'active_filetypes': ['ruby'], 'passive_filetypes': ['html', 'css', 'slim'] }

    Plugin 'vim-scripts/Reindent'

    autocmd FileType gitcommit set tw=68 spell
    autocmd FileType gitcommit setlocal foldmethod=manual
  endif
" }}}

" Javascript {{{
  Plugin 'kchmck/vim-coffee-script'
  Plugin 'pangloss/vim-javascript'
" }}}

" _. HTML {{{
  if count(g:vimified_packages, 'html')
    Plugin 'tpope/vim-haml'
    Plugin 'juvenn/mustache.vim'
    Plugin 'tpope/vim-markdown'
    Plugin 'digitaltoad/vim-jade'
    Plugin 'slim-template/vim-slim'

    au BufNewFile,BufReadPost *.jade setl shiftwidth=2 tabstop=2 softtabstop=2 expandtab
    au BufNewFile,BufReadPost *.html setl shiftwidth=2 tabstop=2 softtabstop=2 expandtab
    au BufNewFile,BufReadPost *.slim setl shiftwidth=2 tabstop=2 softtabstop=2 expandtab

    " html-indent
    let g:html_indent_inctags = "html,body,head,tbody"
  endif
" }}}

" _. CSS {{{
  if count(g:vimified_packages, 'css')
    Plugin 'cakebaker/scss-syntax.vim'
    Plugin 'wavded/vim-stylus'
    Plugin 'lunaru/vim-less'
    nnoremap ,m :w <BAR> !lessc % > %:t:r.css<CR><space>
  endif
" }}}

" _. Python {{{
  if count(g:vimified_packages, 'python')
    Plugin 'klen/python-mode'
    Plugin 'python.vim'
    Plugin 'python_match.vim'
    Plugin 'pythoncomplete'
  endif
" }}}

" _. Ruby {{{
  if count(g:vimified_packages, 'ruby')
    Plugin 'vim-ruby/vim-ruby'
    Plugin 'tpope/vim-rails'
    Plugin 'nelstrom/vim-textobj-rubyblock'
    Plugin 'ecomba/vim-ruby-refactoring'

    autocmd FileType ruby,eruby,yaml set tw=80 ai sw=2 sts=2 et
    autocmd FileType ruby,eruby,yaml setlocal foldmethod=manual
    autocmd User Rails set tabstop=2 shiftwidth=2 softtabstop=2 expandtab
  endif
" }}}

" Themes {{{
  if count(g:vimified_packages, 'color')
    Plugin 'Elive/vim-colorscheme-elive'
    Plugin 'altercation/vim-colors-solarized'
    Plugin 'chriskempson/base16-vim'
    Plugin 'daoo/Mustang2'
    Plugin 'fmoralesc/vim-vitamins'
    "Plugin 'grillpanda/github-colorscheme'
    Plugin 'jnurmine/Zenburn'
    Plugin 'nelstrom/vim-mac-classic-theme'
    Plugin 'sjl/badwolf'
    Plugin 'tomasr/molokai'
    Plugin 'tpope/vim-vividchalk'
    Plugin 'vim-scripts/mayansmoke'
    Plugin 'wgibbs/vim-irblack'
    Plugin 'zaiste/Atom'
    Plugin 'zeis/vim-kolor'
    Plugin 'luan/vim-hybrid'

    " Solarized theme
    "set t_Co=256
    "let g:solarized_termcolors=256
    "set background=light
    "color solarized

    let g:hybrid_use_iTerm_colors = 1
    set background=dark
    colorscheme hybrid
  else
    colorscheme default
  endif
" }}}


" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

"" RSpec {{{
  "Plugin 'thoughtbot/vim-rspec'

  "map <Leader>t :call RunCurrentSpecFile()<CR>
  "map <Leader>s :call RunNearestSpec()<CR>
  "map <Leader>l :call RunLastSpec()<CR>
  "map <Leader>a :call RunAllSpecs()<CR>
"" }}}

" General {{{
filetype plugin indent on " Turn on file type detection.
syntax on                 " Without this it does not generate the helptags
syntax enable             " Turn on syntax highlighting.

set autoindent
set cursorline
set cmdheight=2
set switchbuf=useopen " use the buffer
set showtabline=2

set number                        " Show line numbers.
set ruler                         " Show cursor position.
set encoding=utf-8


" disable match parentheses hopefully speed up
" file loading
let g:loaded_matchparen = 1


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
set wildignore=*.swp,*.bak,*.pyc,*.o,*.obj,*.class,*.rbc,.git,.svn,vendor/gems,vendor/bundle/**,vendor/cache/**,log/**,public/assets/**,public/uploads/**,tmp/**

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

" Highlight VCS conflict markers
match ErrorMsg '^\(<\|=\|>\)\{7\}\([^=].\+\)\?$'

" Status Line
" https://github.com/mislav/vimfiles
if has("statusline") && !&cp
  set laststatus=2  " always show the status bar
  " Start the status line
  set statusline=%f\ %m\ %r
  " Add fugitive
  set statusline+=%{fugitive#statusline()}
endif

" Mappings {{{
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

" Yank from current cursor position to end of line
map Y y$
" Yank content in OS's clipboard. `o` stands for "OS's Clipoard".
vnoremap <leader>yo "*y
" Paste content from OS's clipboard
nnoremap <leader>po "*p

" better ESC
inoremap <C-k> <Esc>
inoremap <C-c> <Esc>

" Seriously, guys. It's not like :W is bound to anything anyway.
command! W :w

" Emacs bindings in command line mode
cnoremap <c-a> <home>
cnoremap <c-e> <end>

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

" expand to file path in command mode
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
" }}}

" Triggers {{{

  " Save when losing focus
  au FocusLost    * :silent! wall

  " When vimrc is edited, reload it
  autocmd! BufWritePost vimrc source ~/.vimrc

" }}}

" Cursorline {{{
  " Only show cursorline in the current window and in normal mode.
  augroup cline
    au!
    au WinLeave * set nocursorline
    au WinEnter * set cursorline
    au InsertEnter * set nocursorline
    au InsertLeave * set cursorline
  augroup END
" }}}

" Trailing whitespace {{{

" Only shown when not in insert mode so I don't go insane.
"augroup trailing
  "au!
  "au InsertEnter * :set listchars-=trail:␣
  "au InsertLeave * :set listchars+=trail:␣
"augroup END

" Load addidional configuration (ie to overwrite shorcuts) {{{
  if filereadable(expand("~/.vim/after.vimrc"))
    source ~/.vim/after.vimrc
  endif
" }}}
