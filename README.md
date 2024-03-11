# nvim-yoink

A very simple plugin to store text you'd like to paste later.<br>
Rather than jumping back and forth between files, you can just yeet it all into Yoink.<br>

## Updates
- Added `:YoinkClear` to easily clear Yoink list
- Added `:YoinkVisualSave` to Yoink current selection in visual mode
- Added print messages in functions for better feedback to commands

## Features
- Add lines to Yoink
- Copy from Yoink
- Paste from Yoink
- Edit Yoink contents

## Installation
With [lazy.nvim](https://github.com/folke/lazy.nvim)
```
{ "kilavila/nvim-yoink" }
```

## Keymaps
Copy current line to Yoink with `:YoinkSave` and `:YoinkClear` to clear the list

`:YoinkVisualSave` to Yoink current selection

Open Yoink window with `:YoinkOpen`

or bind to a key, f.ex:
```
nnoremap Y :YoinkSave<CR>
vnoremap Y :<C-U>YoinkVisualSave<CR>
nnoremap <leader>Y :YoinkOpen<CR>
nnoremap <leader>DY :YoinkClear<CR>
```

Keybinds to use in Yoink window
```
Escape = Close window
Enter  = Paste current line
yy     = Yank current line
Y      = Yank all lines
```

Want to delete a file from the list? Use `dd` like in any other buffer

## Commands
```
YoinkOpen
YoinkSave
YoinkVisualSave
YoinkClear
```
