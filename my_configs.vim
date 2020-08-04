syntax enable
colorscheme solarized
set number
set background=dark

"1 tab == 2 spaces
set expandtab
set shiftwidth=2
set tabstop=2
set softtabstop=2

let g:AutoPairsFlyMode = 1

" add jbuilder syntax highlighting
au BufNewFile,BufRead *.json.jbuilder set ft=ruby

" Move to the end of the selected text after yankink or pasting
vnoremap <silent> y y`]
vnoremap <silent> p p`]
nnoremap <silent> p p`]

" Show line position at the bottom
func! STL()
  let stl = '%f [%{(&fenc==""?&enc:&fenc).((exists("+bomb") && &bomb)?",B":"")}%M%R%H%W] %y [%l/%L,%v] [%p%%]'
  let barWidth = &columns - 65 " <-- wild guess
  let barWidth = barWidth < 3 ? 3 : barWidth

  if line('$') > 1
    let progress = (line('.')-1) * (barWidth-1) / (line('$')-1)
  else
    let progress = barWidth/2
  endif

  " line + vcol + %
  let pad = strlen(line('$'))-strlen(line('.')) + 3 - strlen(virtcol('.')) + 3 - strlen(line('.')*100/line('$'))
  let bar = repeat(' '<Plug>PeepOpenad).' [%1*%'.barWidth.'.'.barWidth.'('
          \.repeat('-'<Plug>PeepOpenrogress )
          \.'%2*0%1*'
          \.repeat('-',barWidth - progress - 1).'%0*%)%<]'
  
  return stl.bar
endfun
  
hi def link User1 DiffAdd
hi def link User2 DiffDelete
set stl=%!STL()
 
set clipboard+=unnamed
imap jj <Esc>
  
autocmd QuickFixCmdPost *grep* cwindow

packloadall

let g:NERDTreeWinPos = "left"
let g:ctrlp_use_caching = 0
if executable('ag')
  set grepprg=ag\ --nogroup\ --nocolor

  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
else
  let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files . -co --exclude-standard', 'find %s -type f']
  let g:ctrlp_prompt_mappings = {
      \ 'AcceptSelection("e")': ['<space>', '<cr>', '<2-LeftMouse>'],
      \ }
endif

au FileType javascript imap <c-t> console.log()<esc>i
let g:syntastic_javascript_checkers = ['eslint']
let g:syntastic_javascript_eslint_exe = 'npm run lint --'
nmap <Leader>pr <Plug>(Prettier)
let g:prettier#autoformat_require_pragma = 0
setl foldmethod=manual

set clipboard+=unnamed
imap jj <Esc>

autocmd QuickFixCmdPost *grep* cwindow

