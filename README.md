# switchunite.vim

## Example

```.vimrc
    let g:switchunite = {
                \ 'toggle_file': {
                \   'keymap': '<C-p>',
                \   'option': '-hide-source-names',
                \   'commands': [
                \       ['Unite', 'file_rec/git file/new'],
                \       ['UniteWithBufferDir', 'file_rec file/new'],
                \       ['Unite', 'meomru/file file/new'],
                \   ]
                \ }}
```
