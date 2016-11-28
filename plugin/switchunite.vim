" switch Unite source
" Version: 0.1.0
" Author: momo-lab <momotaro.n@gmail.com> <https://github.com/momo-lab>
" License: MIT

if exists('g:loaded_switchunite')
  finish
endif
let g:loaded_switchunite = 1

function! s:switchunite_init()
  let g:switchunite = get(g:, 'switchunite', {})
  for prefix in keys(g:switchunite)
    " normalize settings
    " TODO 不正なオプション(keymapは必須、commandsは1つ以上必須)の場合にエラーを表示する
    let g:switchunite[prefix] = extend(g:switchunite[prefix], {
          \ 'prefix': prefix,
          \ 'keymap_next': get(g:, 'switchunite_keymap_next', '<C-f>'),
          \ 'keymap_prev': get(g:, 'switchunite_keymap_prev', '<C-b>'),
          \ 'option': '',
          \ }, 'keep')

    " setting keymap
    let settings = g:switchunite[prefix]
    execute printf('nnoremap <silent> %s :<C-u>%s -profile-name=%s%i %s %s<CR>',
          \ settings['keymap'],
          \ settings['commands'][0][0],
          \ settings['prefix'], 0,
          \ settings['option'],
          \ settings['commands'][0][1])
  endfor
endfunction

call s:switchunite_init()

augroup switchunite
  autocmd!
  autocmd FileType unite call switchunite#autocmd()
augroup END

let s:save_cpo = &cpo
set cpo&vim


let &cpo = s:save_cpo
unlet s:save_cpo
