" Switch Unite source
" Version: 0.1.0
" Author: momo-lab <momotaro.n@gmail.com> <https://github.com/momo-lab>
" License: MIT

let s:save_cpo = &cpo
set cpo&vim

function! switchunite#autocmd()
  let unite = unite#get_current_unite()
  for prefix in keys(g:switchunite)
    if unite.profile_name !~ printf('^%s[0-9]\+$', prefix)
      continue
    endif
    let settings = g:switchunite[prefix]
    let num = str2nr(substitute(unite.profile_name, prefix, '', ''))
    let next = (num + 1) < len(settings['commands']) ? num + 1 : 0
    call s:map(settings, 'next', next)
    let prev = (num > 0 ? num : len(settings['commands'])) - 1
    call s:map(settings, 'prev', prev)
  endfor
endfunction

function! s:map(settings, mode, index)
  let cmd = printf('map <silent><buffer> %s <Plug>(unite_exit)' .
        \ ':<C-u>%s -profile-name=%s%i %s %s<CR>',
        \ a:settings['keymap_' . a:mode],
        \ a:settings['commands'][a:index][0],
        \ a:settings['prefix'], a:index,
        \ a:settings['option'],
        \ a:settings['commands'][a:index][1])
  execute 'i' . cmd
  execute 'n' . cmd
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo

