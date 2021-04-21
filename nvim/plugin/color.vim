"************************************"
"======== MAKE IT PRETTY ============"
"************************************"

" gruvbox when im feeling froggy
"let g:gruvbox_italic=1
"let g:lightline = {}
"let g:lightline.colorscheme = 'gruvbox'
"colorscheme gruvbox

" ayu when spicy
"let g:lightline = { 'colorscheme': 'ayu' }
"let ayucolor="mirage"
"colorscheme ayu

" onedark when theres no place like home
let g:onedark_terminal_italics = 1
let g:lightline = { 'colorscheme': 'onedark' }
colorscheme onedark

" used for tmux color passing
if exists('+termguicolors')
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
endif
