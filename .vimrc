let $LANG = 'en'  "set message language  
set langmenu=en   "set menu's language of gvim. no spaces beside '='  
source $VIMRUNTIME/vimrc_example.vim
source $VIMRUNTIME/mswin.vim
behave mswin

set diffexpr=MyDiff()
function MyDiff()
  let opt = '-a --binary '
  if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
  if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
  let arg1 = v:fname_in
  if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
  let arg2 = v:fname_new
  if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
  let arg3 = v:fname_out
  if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
  if $VIMRUNTIME =~ ' '
    if &sh =~ '\<cmd'
      if empty(&shellxquote)
        let l:shxq_sav = ''
        set shellxquote&
      endif
      let cmd = '"' . $VIMRUNTIME . '\diff"'
    else
      let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
    endif
  else
    let cmd = $VIMRUNTIME . '\diff'
  endif
  silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3
  if exists('l:shxq_sav')
    let &shellxquote=l:shxq_sav
  endif
endfunction




" 设置编码自动识别, 中文引号显示  
"set fileencodings=utf-8,cp936,big5,euc-jp,euc-kr,latin1,ucs-bom  
set fileencodings=utf-8,gbk  
set ambiwidth=double 
set encoding=utf-8



" 允许退格键删除和tab操作  
set smartindent  
set smarttab  
set expandtab  
set tabstop=4  
set softtabstop=4  
set shiftwidth=4  
set backspace=2
set textwidth=79

" 启用鼠标  
set mouse=a  
  
" 启用行号  
set nu 
"取消备份文件
set noundofile
set nobackup  
set noswapfile



" ################### Bundles 配置 #########################                                                                                 
" 使用Vundle来管理插件                                                                                                                       
" vim plugin bundle control, command model                                                                                                   
"     :BundleInstall     install 安装配置的插件                                                                                              
"     :BundleInstall!    update  更新                                                                                                        
"     :BundleClean       remove plugin not in list 删除本地无用插件                                                                                                    
set rtp+=~/.vim/bundle/vundle/                                                                                                               
call vundle#rc()

Bundle 'gmarik/vundle' 

" ###### 主题 molokai 和 Solarized                                                                                                           
Bundle 'tomasr/molokai'                                                                                                                      
let g:molokai_original = 1                                                                                                                   
Bundle 'altercation/vim-colors-solarized'                                                                                                    
let g:solarized_termcolors=256                                                                                                               
let g:solarized_termtrans=1                                                                                                                  
let g:solarized_contrast="normal"                                                                                                            
let g:solarized_visibility="normal"                                                                                                          
" 主题使用                                                                                                                                   
set background=dark                                                                                                                          
"set background=light                                                                                                                        
set t_Co=256                                                                                                                                 
"colorscheme molokai                                                                                                                          
colorscheme solarized
"colorscheme rupza 


"TagList
Bundle 'TagList.vim'
let Tlist_Ctags_Cmd='ctags'
let Tlist_Show_One_File=1               "不同时显示多个文件的tag，只显示当前文件的
let Tlist_WinWidt =28                   "设置taglist的宽度
let Tlist_Exit_OnlyWindow=1             "如果taglist窗口是最后一个窗口，则退出vim
"let Tlist_Use_Right_Window=1           "在右侧窗口中显示taglist窗口
let Tlist_Use_Left_Windo =1             "在左侧窗口中显示taglist窗口

"NERDTree
Bundle 'scrooloose/nerdtree'

"NerdCommenter 注释
Bundle 'scrooloose/nerdcommenter'
",cc/cb 快捷键
let g:mapleader = ","
"自动补全
Bundle 'Shougo/neocomplete.vim'
"Bundle 'Valloric/YouCompleteMe'
"Bundle 'davidhalter/jedi-vim'  
"superTab 
"Bundle 'superTab'


"Note: This option must set it in .vimrc(_vimrc).  NOT IN .gvimrc(_gvimrc)!
" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
" Use neocomplete.
let g:neocomplete#enable_at_startup = 1
" Use smartcase.
let g:neocomplete#enable_smart_case = 1
" Set minimum syntax keyword length.
let g:neocomplete#sources#syntax#min_keyword_length = 3
let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'

" Define dictionary.
let g:neocomplete#sources#dictionary#dictionaries = {
    \ 'default' : '',
    \ 'vimshell' : $HOME.'/.vimshell_hist',
    \ 'scheme' : $HOME.'/.gosh_completions'
        \ }

" Define keyword.
if !exists('g:neocomplete#keyword_patterns')
    let g:neocomplete#keyword_patterns = {}
endif
let g:neocomplete#keyword_patterns['default'] = '\h\w*'

" Plugin key-mappings.
inoremap <expr><C-g>     neocomplete#undo_completion()
inoremap <expr><C-l>     neocomplete#complete_common_string()

" Recommended key-mappings.
" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  return neocomplete#close_popup() . "\<CR>"
  " For no inserting <CR> key.
  "return pumvisible() ? neocomplete#close_popup() : "\<CR>"
endfunction
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><C-y>  neocomplete#close_popup()
inoremap <expr><C-e>  neocomplete#cancel_popup()
" Close popup by <Space>.
"inoremap <expr><Space> pumvisible() ? neocomplete#close_popup() : "\<Space>"

" For cursor moving in insert mode(Not recommended)
"inoremap <expr><Left>  neocomplete#close_popup() . "\<Left>"
"inoremap <expr><Right> neocomplete#close_popup() . "\<Right>"
"inoremap <expr><Up>    neocomplete#close_popup() . "\<Up>"
"inoremap <expr><Down>  neocomplete#close_popup() . "\<Down>"
" Or set this.
"let g:neocomplete#enable_cursor_hold_i = 1
" Or set this.
"let g:neocomplete#enable_insert_char_pre = 1

" AutoComplPop like behavior.
"let g:neocomplete#enable_auto_select = 1

" Shell like behavior(not recommended).
"set completeopt+=longest
"let g:neocomplete#enable_auto_select = 1
"let g:neocomplete#disable_auto_complete = 1
"inoremap <expr><TAB>  pumvisible() ? "\<Down>" : "\<C-x>\<C-u>"

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" Enable heavy omni completion.
if !exists('g:neocomplete#sources#omni#input_patterns')
  let g:neocomplete#sources#omni#input_patterns = {}
endif
"let g:neocomplete#sources#omni#input_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
"let g:neocomplete#sources#omni#input_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
"let g:neocomplete#sources#omni#input_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'

" For perlomni.vim setting.
" https://github.com/c9s/perlomni.vim
let g:neocomplete#sources#omni#input_patterns.perl = '\h\w*->\h\w*\|\h\w*::'



"#搞不定啊
"set runtimepath+=E:/software/YouCompleteMe
"let g:ycm_global_ycm_extra_conf = '~/.vim/bundle/YouCompleteMe/python/ycmd/.ycm_extra_conf.py'   "配置默认的ycm_extra_conf.py
"nnoremap <leader>jd :YcmCompleter GoToDefinitionElseDeclaration<CR>  "按,jd 会跳转到定义
"let g:ycm_confirm_extra_conf=0    "打开vim时不再询问是否加载ycm_extra_conf.py配置
"let g:ycm_collect_identifiers_from_tag_files = 1 "使用ctags生成的tags文件


"#####需要配置#####


"tags 
"set tags=C:\Users\hanxiaowei\tags	

"NERDTree
" 将 NERDTree 的窗口设置在 vim 窗口的右侧（默认为左侧）
"let NERDTreeWinPos="right"
" 当打开 NERDTree 窗口时，自动显示 Bookmarks
let NERDTreeShowBookmarks=0


"############窗口配置########

" 在 vim 启动的时候默认开启 Tlist 可以缩写为 au）
autocmd VimEnter * Tlist 

"快捷键配置
" 按下 C-e 调出/隐藏 NERDTree
nnoremap <C-e> :exe 'NERDTreeToggle'<CR>
