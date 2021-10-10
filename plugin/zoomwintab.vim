" zoomwintab.vim - simple zoom window vim
" Maintainer: Dmitry "troydm" Geurkov <d.geurkov@gmail.com>
" Version: 0.1
" Description: zoomwintab.vim is a simple zoom window plugin
" that uses tabs feature to zoom into a window inspired by ZoomWin
" Last Change: 11 February, 2013
" License: Vim License (see :help license)
" Website: https://github.com/troydm/zoomwintab.vim
"
" See zoomwintab.vim for help.  This can be accessed by doing:
" :help zoomwintab

let s:save_cpo = &cpo
set cpo&vim

" options {{{
if !exists("g:zoomwintab_remap")
    let g:zoomwintab_remap = 1
endif

if !exists("g:zoomwintab_hidetabbar")
    let g:zoomwintab_hidetabbar = 1
endif
" }}}


" commands {{{1
command! ZoomWinTabIn call zoomwintab#In()
command! ZoomWinTabOut call zoomwintab#Out()
command! ZoomWinTabToggle call zoomwintab#Toggle()

" mappings {{{1
if g:zoomwintab_remap
    nnoremap <C-w>o :ZoomWinTabToggle<CR>
    nnoremap <C-w_o> :ZoomWinTabToggle<CR>
    nnoremap <C-w><C-o> :ZoomWinTabToggle<CR>
    for i in range(0,9)
        exe 'nnoremap <C-w>'.i.'o :ZoomWinTabToggle<CR>'
        exe 'nnoremap <C-w>'.i.'<C-o> :ZoomWinTabToggle<CR>'
    endfor
    if has('terminal')
        tnoremap <C-w>o <C-w>::ZoomWinTabToggle<CR>
        tnoremap <C-w><C-o> <C-w>::ZoomWinTabToggle<CR>
        for i in range(0,9)
            exe 'tnoremap <C-w>'.i.'o <C-w>::ZoomWinTabToggle<CR>'
            exe 'tnoremap <C-w>'.i.'<C-o> <C-w>::ZoomWinTabToggle<CR>'
        endfor
    endif
endif

let g:zoomwintab_loaded = 1

let &cpo = s:save_cpo
unlet s:save_cpo

" vim: set sw=4 sts=4 et fdm=marker:
