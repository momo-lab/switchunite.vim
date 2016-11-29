# switchunite.vim

## Example

```.vimrc
call switchunite#add('toggle_file', {
            \ 'keymap': '<C-p>',
            \ 'option': '-hide-source-names',
            \ 'commands': [
            \     ['Unite', 'file_rec/git file/new'],
            \     ['UniteWithBufferDir', 'file_rec file/new'],
            \     ['Unite', 'meomru/file file/new'],
            \ ]})
```
