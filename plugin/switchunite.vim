" Switch Unite source
" Version: 0.1.0
" Author: momo-lab <momotaro.n@gmail.com> <https://github.com/momo-lab>
" License: MIT

if exists('g:loaded_switchunite')
  finish
endif
let g:loaded_switchunite = 1

let s:save_cpo = &cpo
set cpo&vim

augroup switchunite
  autocmd!
  autocmd FileType unite call switchunite#autocmd()
augroup END

let &cpo = s:save_cpo
unlet s:save_cpo
