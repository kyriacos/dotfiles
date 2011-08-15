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
