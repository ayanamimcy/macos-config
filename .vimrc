filetype on 
filetype plugin on 
set clipboard-=unnamed
set fileencodings=utf-8,ucd-bom,gb18030,gbk,gb2312,cp936

" 开启实时搜索功能
set incsearch

" 搜索时大小写不敏感
set ignorecase

" 关闭兼容模式
set nocompatible

" vim 自身命令行模式智能补全
set wildmenu

" 自动缩进
set smartindent
set autoindent 

""c自动缩进
set cindent
"关闭自动缩进
"set noai

"关闭自动预览
set completeopt-=preview

" 定义快捷键的前缀，即<Leader>
 let mapleader=";"
" 映射esc"

 " 一些快捷键的配置
nmap <leader>b 0 
nmap <leader>e $

" 将 pathogen 自身也置于独立目录中，需指定其路径 
runtime bundle/pathogen/autoload/pathogen.vim
" 运行 pathogen
execute pathogen#infect()

set laststatus=2
" 使用powerline打过补丁的字体
let g:airline_powerline_fonts = 0
" 开启tabline
let g:airline#extensions#tabline#enabled = 1
" tabline中当前buffer两端的分隔字符
let g:airline#extensions#tabline#left_sep = ' '
" tabline中未激活buffer两端的分隔字符
let g:airline#extensions#tabline#left_alt_sep = '|'
" tabline中buffer显示编号
let g:airline#extensions#tabline#buffer_nr_show = 1
" 映射切换buffer的键位
nnoremap [b :bp<CR>
nnoremap ]b :bn<CR>


" 配色方案
""set background=dark
""colorscheme solarized
""colorscheme molokai
" "colorscheme phd

" 禁止光标闪烁
 set gcr=a:block-blinkon0

 " " 禁止显示滚动条
 set guioptions-=l
 set guioptions-=L
 set guioptions-=r
 set guioptions-=R

"" 禁止显示菜单和工具条
 set guioptions-=m
 set guioptions-=T

" 总是显示状态栏
 set laststatus=2
" " 显示光标当前位置
 set ruler
" " 开启行号显示
 set number

" " 高亮显示当前行/列
 set cursorline
 set cursorcolumn

" " 高亮显示搜索结果
 set hlsearch

""取消高亮搜索结果
nmap <F4> :nohlsearch<CR>



" 开启语法高亮功能
 syntax enable

" 允许用指定语法高亮配色方案替换默认方案
 syntax on

" 自适应不同语言的智能缩进
 filetype indent on

" 设置编辑时制表符占用空格数
 set tabstop=4

 " 设置格式化时制表符占用空格数
 set shiftwidth=4
 set softtabstop=4
 set expandtab
"" autocmd FileType python setlocal et sta sw=4 sts=4
 
 "Smart way to move between windows 分屏窗口移动
 map nw <C-W><C-W>
 map <leader>j <C-W>j
 map <leader>k <C-W>k
 map <leader>h <C-W>h
 map <leader>l <C-W>l
 map <leader>q <C-W>q 

 " set taglist
 let Tlist_Ctags_Cmd='/bin/ctags' 
 map <F8> :TlistToggle<cr>
 let Tlist_Show_One_File = 1
 let Tlist_Use_Right_Window = 1
 let Tlist_Exit_OnlyWindow = 1

" set nerdtree
 map <F7> :NERDTreeToggle<cr>
 autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") &&b:NERDTreeType == "primary") | q | endif


" set ycm
let g:ycm_global_ycm_extra_conf = '~/.vim/.ycm_extra_conf.py'
let g:ycm_collect_identifiers_from_tags_files = 1
let g:ycm_seed_identifiers_with_syntax = 1  
let g:ycm_min_num_of_chars_for_completion=1  
let g:ycm_semantic_triggers = {}
let g:ycm_semantic_triggers.c = ['->', '.', ' ', '(', '[', '&']

" set syntas"
let g:syntastic_error_symbol='>>'
let g:syntastic_warning_symbol='>'
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open=1
let g:syntastic_check_on_wq=0
let g:syntastic_enable_highlighting=1
let g:syntastic_python_checkers=['pep8']

" set hightlight
let python_highlight_all = 1

"自动插入头文件
autocmd BufNewFile *.sh,*.py exec ":call AutoSetFileHead()"
function! AutoSetFileHead()
    "如果文件类型为.sh文件
    if &filetype == 'sh'
        call setline(1, "\#!/bin/bash")
    endif

    "如果文件类型为python
    if &filetype == 'python'
        call setline(1, "\#!/usr/bin/env python")
        call append(line("."),"\#coding:utf-8")
    endif

    normal G
    normal o
    normal o
endfunction

"自动补全
:inoremap ( ()<ESC>i
:inoremap ) <c-r>=ClosePair(')')<CR>
:inoremap { {}<ESC>i
:inoremap } <c-r>=ClosePair('}')<CR>
:inoremap [ []<ESC>i
:inoremap ] <c-r>=ClosePair(']')<CR>
:inoremap " ""<ESC>i
:inoremap ' ''<ESC>i
function! ClosePair(char)
    if getline('.')[col('.') - 1] == a:char
            return "\<Right>"
    else
            return a:char
    endif
endfunction

""markdown rst pandoc
function! Tohtml()
    exec "w"
    exec "!pandoc  -s -S --self-contained -c /home/mcy/.pandoc/github.css % -o %<.html"
endfunction

function! ToPdf()
        exec 'w'
        exec "!pandoc  % -o %<.pdf --mathjax --latex-engine=xelatex --template=/home/mcy/.pandoc/pm-template.latex"
endfunction

function! Todoc()
        exec 'w'
        exec "!pandoc -f rst -t html % | pandoc -f html -t docx -o %<.docx"
endfunction

function! Previewrst()
        exec 'w'
        exec "!rst2html.py --stylesheet-path=/home/mcy/.pandoc/github.css --traceback --smart-quotes=yes % ~/.pandoc/index.html && xdg-open ~/.pandoc/index.html &"
endfunction

:nmap mh :call Tohtml()<CR>
:nmap mp :call ToPdf()<CR>
:nmap md :call Todoc()<CR>
:nmap mw :call Previewrst()<CR><CR>

let g:pandoc#filetypes#handled = ["pandoc", "markdown"]
let g:pandoc#filetypes#pandoc_markdown = 0
let g:pandoc#modules#disabled = ["folding"]

