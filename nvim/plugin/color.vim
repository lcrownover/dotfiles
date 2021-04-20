"************************************"
"======== MAKE IT PRETTY ============"
"************************************"

" turn on the color
let g:lightline = { 'colorscheme': 'ayu' }
let ayucolor="mirage"
colorscheme ayu

" used for tmux color passing
if exists('+termguicolors')
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
endif
