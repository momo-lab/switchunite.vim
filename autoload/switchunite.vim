" Switch Unite source
" Version: 0.1.0
" Author: momo-lab <momotaro.n@gmail.com> <https://github.com/momo-lab>
" License: MIT

let s:save_cpo = &cpo
set cpo&vim

" initialize global variables
let g:switchunite = {}

function! switchunite#add(name, settings)
  " check settings
  " TODO Implement

  " normalize settings
  let settings = extend(a:settings, {
        \ 'name': a:name,
        \ 'keymap_next': get(g:, 'switchunite_keymap_next', '<C-f>'),
        \ 'keymap_prev': get(g:, 'switchunite_keymap_prev', '<C-b>'),
        \ 'option': '',
        \ }, 'keep')
  let g:switchunite[settings.name] = settings

  " setting keymap
  execute printf('nnoremap <silent> %s :<C-u>%s -profile-name=%s%i %s %s<CR>',
        \ settings['keymap'],
        \ settings['commands'][0][0],
        \ settings['name'], 0,
        \ settings['option'],
        \ settings['commands'][0][1])
endfunction

function! switchunite#autocmd()
  let unite = unite#get_current_unite()
  for name in keys(g:switchunite)
    if unite.profile_name !~ printf('^%s[0-9]\+$', name)
      continue
    endif
    let settings = g:switchunite[name]
    let num = str2nr(substitute(unite.profile_name, name, '', ''))
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
        \ a:settings['name'], a:index,
        \ a:settings['option'],
        \ a:settings['commands'][a:index][1])
  execute 'i' . cmd
  execute 'n' . cmd
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo

