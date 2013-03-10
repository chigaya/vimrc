" Common
set nocompatible
set mouse=a
:colorscheme torte

" File
set noswapfile
set nowrap
syntax on

" Indent
set tabstop=4 shiftwidth=4 softtabstop=0
set autoindent smartindent

" Assist input
set backspace=indent,eol,start
set whichwrap=b,s,h,s,<,>,[,]
set clipboard=unnamed,autoselect

" Complement
set wildmenu
set wildmode=list:full

" Search
set wrapscan
set ignorecase
set smartcase
set incsearch
set hlsearch

" View
set showmatch
set showcmd
set number
set nowrap



set cursorline				" カーソル行をハイライト
augroup cch
	autocmd! cch
	autocmd WinLeave * set nocursorline
	autocmd WinEnter,BufRead * set cursorline
augroup END
:hi clear CursorLine
:hi CursorLine gui=underline
hi CursorLine ctermbg=black guibg=black


" StatusLine ---------------------------
set laststatus=2				" ステータスラインを2行に
set statusline=%<%f\ #%n%m%r%h%w%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']'}%y%=%l,%c%V%8P

" Charset, Line ending -----------------
set termencoding=utf-8
set encoding=utf-8
set fileencodings=utf-8,cp932,euc-jp,iso-2022-jp
set ffs=unix,dos,mac			" LF, CRLF, CR
if exists('&ambiwidth')
	set ambiwidth=double		" UTF-8の□や○でカーソル位置がずれないようにする
endif

" --------------------------------------
"              my config
" --------------------------------------
" When insert mode, change statusline.
let g:hi_insert = 'hi StatusLine gui=None guifg=Black guibg=Yellow cterm=None ctermfg=Black ctermbg=Yellow'

if has('syntax')
  augroup InsertHook
    autocmd!
    autocmd InsertEnter * call s:StatusLine('Enter')
    autocmd InsertLeave * call s:StatusLine('Leave')
  augroup END
endif

let s:slhlcmd = ''
function! s:StatusLine(mode)
  if a:mode == 'Enter'
    silent! let s:slhlcmd = 'highlight ' . s:GetHighlight('StatusLine')
    silent exec g:hi_insert
  else
    highlight clear StatusLine
    silent exec s:slhlcmd
  endif
endfunction

function! s:GetHighlight(hi)
  redir => hl
  exec 'highlight '.a:hi
  redir END
  let hl = substitute(hl, '[\r\n]', '', 'g')
  let hl = substitute(hl, 'xxx', '', '')
  return hl
endfunction

