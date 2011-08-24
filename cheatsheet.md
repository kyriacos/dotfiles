z Toggle folding
    * zR -> open all folds
# NERD Commenter
    a: let NERDDefaultNesting = 1 " use nesting as default
    Use <Leader> followed by:
    * cc -> comment
    * cl -> erm
    * cn -> comment + force nesting
    * c<Space> -> toggle on off
# TComment
    * gcc -> toggle line comment
    * gc3j -> toggle comments on the next 3 lines
# Surround.vim
Can't stress this plugin enough. Made by Tim Pope again :).
So here's some shortcuts to remember
    * vips" -> surround paragraph with quotes
    * viss" -> surround sentence with quotes
    * VS" -> select whole line and surround with quote and indent. Good
      when typing html elements
    * Vs" -> same as above but without intent.
    * viws" -> select word and surround with double quotes
    * cst' -> change surrounding tag to single quotes (need to be on
      word or line with tag
    * cs'! -> change surrounding from single quote to bang
    * dst -> delete surrounding tag
    * ds" -> delete surrounding double quote
# Tabular.vim
    // https://gist.github.com/287147 -> auto align | tables.
    // Useful with cucumber
    * :<range>Tab /: -> align to ':'
    * :<range>Tab /:\zs -> exclude ':' from search. Basically align with
character right after ':' (even spaces)
# [ Vim Indent Guides ]( git://github.com/nathanaelkane/vim-indent-guides.git )
Indent Guides is a plugin for visually displaying indent levels in Vim.
When the background is set to either light or dark the highlight changes
accordingly. Check the site for more info

    * <Leader>ig -> toggles plugin on off

# [Search Complete](git://github.com/vim-scripts/SearchComplete.git)
Vim plugin to tab-complete words in search.
# [bufexplorer](git://github.com/vim-scripts/bufexplorer.zip.git)
With bufexplorer, you can quickly and easily switch between buffers by
using the one of the default public interfaces:

		* '\be' (normal open)  or
		* '\bs' (force horizontal split open)  or
		* '\bv' (force vertical split open)
# [Easy Motion](git://github.com/Lokaltog/vim-easymotion.git)
EasyMotion provides a much simpler way to use some motions in vim. It
takes the <number> out of <number>w or <number>f{char} by highlighting
all possible choices and allowing you to press one key to jump directly
to the target.

    * Use <Leader>w
# [NERDTree](none)

