if exists('g:loaded_nvim_yoink') | finish | endif

let s:save_cpo = &cpo
set cpo&vim

command! YoinkOpen lua require'nvim-yoink'.open()
command! YoinkSave lua require'nvim-yoink'.save()
command! YoinkVisualLineSave lua require'nvim-yoink'.visual_line_save()

let &cpo = s:save_cpo
unlet s:save_cpo

let g:loaded_nvim_yoink = 1
