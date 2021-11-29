" An example for a vimrc file.
"
" Maintainer:	Bram Moolenaar <Bram@vim.org>
" Last change:	2016 Jul 28
"
" To use it, copy it to
"     for Unix and OS/2:  ~/.vimrc
"	      for Amiga:  s:.vimrc
"  for MS-DOS and Win32:  $VIM\_vimrc
"	    for OpenVMS:  sys$login:.vimrc

" 关闭兼容模式
set nocompatible

" 打开语法高亮
syntax enable

" 开启文件类型检测
filetype plugin indent on

" 打开自动缩进
set autoindent

" 使用空格代替tab
set expandtab 

set tabstop=4
set softtabstop=4
set shiftwidth=4

" >> indents to next multiple of 'shiftwidth'.
set shiftround

" 自动跳转并高亮匹配的括号
set showmatch
set matchtime=1

" 开启特殊符号的回显
" set list listchars=eol:¬,tab:▸\ ,trail:.,
" set cindent
" set background=dark
" colorscheme solarized

" get a block cursor in Vim in the Cygwin terminal
let &t_ti.="\e[1 q"
let &t_SI.="\e[5 q"
let &t_EI.="\e[1 q"
let &t_te.="\e[0 q"
