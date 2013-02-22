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
" }}}


" functions {{{1
" ZoomWinTabIn {{{2
function! ZoomWinTabIn()
    if gettabvar(tabpagenr(),'zoomwintab') != '' 
        echo 'Already zoomed in'
        return
    endif
    if tabpagewinnr(tabpagenr(),'$') == 1
        echo 'Already only one window'
        return
    endif
    if bufname('%') != ''
        let bufn = bufnr('%')
        let tabpage = tabpagenr()
        let swbuf = &switchbuf
        set switchbuf&
        exe 'tab sb '.bufn
        let &switchbuf = swbuf
        if tabpage != tabpagenr()
            call settabvar(tabpagenr(),'zoomwintab',&stal)
            call settabvar(tabpagenr(),'zoomwintabnr',tabpage)
            set showtabline=0
        endif
    else
        echo 'No buffer'
    endif
endfunction

" ZoomWinTabClose {{{2
function! ZoomWinTabOut() 
    if gettabvar(tabpagenr(),'zoomwintab') == '' 
        echo 'Already zoomed out'
        return
    endif
    let &stal = gettabvar(tabpagenr(),'zoomwintab')
    let tabpage = gettabvar(tabpagenr(),'zoomwintabnr')
    tabclose
    if tabpagenr() != tabpage
        exe 'tabnext '.tabpage
    endif
endfunction

" ZoomWinTabToggle {{{2
function! ZoomWinTabToggle()
    if gettabvar(tabpagenr(),'zoomwintab') == '' 
        call ZoomWinTabIn()
    else
        call ZoomWinTabOut()
    endif
endfunction

" commands {{{1
command! ZoomWinTabIn call ZoomWinTabIn()
command! ZoomWinTabOut call ZoomWinTabOut()
command! ZoomWinTabToggle call ZoomWinTabToggle()

" mappings {{{1
if g:zoomwintab_remap
    nnoremap <C-w>o :ZoomWinTabToggle<CR>
    nnoremap <C-w><C-o> :ZoomWinTabToggle<CR>
endif

let g:zoomwintab_loaded = 1

let &cpo = s:save_cpo
unlet s:save_cpo

" vim: set sw=4 sts=4 et fdm=marker:
