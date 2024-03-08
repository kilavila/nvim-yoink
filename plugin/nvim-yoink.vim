if exists('g:loaded_nvim_yoink') | finish | endif

let s:save_cpo = &cpo
set cpo&vim

command! YoinkOpen lua require'nvim-yoink'.open_yoink()
command! YoinkSave lua require'nvim-yoink'.save_yoink()

let &cpo = s:save_cpo
unlet s:save_cpo

let g:loaded_nvim_yoink = 1
