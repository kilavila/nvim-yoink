if exists('g:loaded_nvim_yoink') | finish | endif

let s:save_cpo = &cpo
set cpo&vim

command! YoinkOpen lua require'nvim-yoink'.open()
command! YoinkSave lua require'nvim-yoink'.save()
command! YoinkVisualSave lua require'nvim-yoink'.visual_save()
command! YoinkClear lua require'nvim-yoink'.clear_list()

let &cpo = s:save_cpo
unlet s:save_cpo

let g:loaded_nvim_yoink = 1
