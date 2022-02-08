if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
      \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
call plug#begin('~/.config/nvim/bundle')

" General plugins
Plug 'autozimu/LanguageClient-neovim', { 'branch': 'next', 'do': 'bash install.sh' }
Plug 'Shougo/deoplete.nvim', { 'tag': '*', 'do': ':UpdateRemotePlugins' }
Plug 'itchyny/lightline.vim'
Plug 'mgee/lightline-bufferline'
Plug 'tpope/vim-fugitive', { 'tag': '*' }
Plug 'tpope/vim-rhubarb'
Plug 'airblade/vim-gitgutter'
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'scrooloose/nerdcommenter'
Plug 'junegunn/fzf', { 'tag': '*', 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-cucumber'
Plug 'jiangmiao/auto-pairs'
Plug 'ntpeters/vim-better-whitespace'
Plug 'christoomey/vim-tmux-navigator'
Plug 'terryma/vim-multiple-cursors'
Plug 'SirVer/ultisnips'
Plug 'tpope/vim-dispatch'
Plug 'majutsushi/tagbar'
Plug 'Shougo/echodoc.vim'
Plug 'ianding1/leetcode.vim'
Plug 'hashivim/vim-terraform'
Plug 'nguyenhoaibao/vim-base64'
Plug 'dhruvasagar/vim-zoom'

" colorscheme
Plug 'arcticicestudio/nord-vim' " should be used with nord-iterm2

" Language plugins
Plug 'fatih/vim-go', { 'tag': '*', 'do': ':GoInstallBinaries' }
Plug 'AndrewRadev/splitjoin.vim'
Plug 'rust-lang/rust.vim'
Plug 'ternjs/tern_for_vim', { 'do': 'npm install', 'for': ['javascript'] }
Plug 'pangloss/vim-javascript'
Plug 'carlitux/deoplete-ternjs', { 'do': 'npm install -g tern' }
Plug 'tomlion/vim-solidity'

Plug 'neovim/nvim-lspconfig'
Plug 'deoplete-plugins/deoplete-lsp'

call plug#end()

" General
syntax on
set number
set relativenumber
set lazyredraw
set numberwidth=5
set ruler
set autoindent
set smartindent
set nowrap
set nobackup
set nowritebackup
set noswapfile
set showcmd
set incsearch
set nojoinspaces
set laststatus=2
set splitbelow
set splitright
set autoread
set autowrite
set ignorecase
set smartcase
set backspace=2
set clipboard=unnamedplus
set tags=./tags;,tags;
filetype plugin indent on
set completeopt-=preview
set completeopt+=menuone,noinsert,noselect

" Softtabs
set expandtab
set shiftround
set tabstop=2
set shiftwidth=2
set softtabstop=2

" 100 chars
"set textwidth=100
"set colorcolumn=+1
set noshowmode
set shortmess+=c

" Folding
set foldmethod=indent
set foldnestmax=5
set foldlevel=5
set foldlevelstart=5
set nofoldenable

" persistent undo
if has('persistent-undo')
  call system('mkdir -p ~/.config/nvim/undo')
  set undofile
  set undodir=~/.config/nvim/undo
  set undolevels=1000
  set undoreload=10000
endif

" Colors
set t_Co=256
set termguicolors
colorscheme nord
"LuciusLightLowContrast

augroup vimrcEx
  autocmd!

  " When editing a file, always jump to the last known cursor position.
  " Don't do it for commit messages, when the position is invalid, or when
  " inside an event handler (happens when dropping a file on gvim).
  autocmd BufReadPost *
  \ if &ft != 'gitcommit' && line("'\"") > 0 && line("'\"") <= line("$") |
  \   exe "normal g`\"" |
  \ endif
  autocmd BufReadPost fugitive://* set bufhidden=delete

  " Set syntax highlighting for specific file types
  autocmd BufRead,BufNewFile *.md set filetype=markdown
  autocmd BufRead,BufNewFile .{jscs,jshint,eslint}rc set filetype=json
  autocmd BufNewFile,BufRead *.{js,yaml} setlocal expandtab tabstop=2 softtabstop=2 shiftwidth=2
  autocmd BufNewFile,BufRead *.{python,sh} setlocal expandtab tabstop=4 softtabstop=4 shiftwidth=4
  autocmd BufNewFile,BufRead *.go setlocal noexpandtab tabstop=8 softtabstop=8 shiftwidth=8
  autocmd BufNewFile,BufRead *.proto setlocal expandtab tabstop=2 softtabstop=2 shiftwidth=2
augroup END

" js folding
augroup jsFolds
  autocmd!

  autocmd FileType javascript syntax region foldBraces start=/{/ end=/}/ transparent fold keepend extend
  autocmd FileType javascript set foldmethod=syntax
augroup end

" Triger `autoread` when files changes on disk
" https://unix.stackexchange.com/questions/149209/refresh-changed-content-of-file-opened-in-vim/383044#383044
" autocmd FocusGained,BufEnter,CursorHold,CursorHoldI * if mode() != 'c' | checktime | endif
autocmd FocusGained,BufEnter,CursorHold,CursorHoldI *
            \ if mode() !~ '\v(c|r.?|!|t)' && getcmdwintype() == '' | checktime | endif
autocmd FileChangedShellPost * echohl WarningMsg | echo "File changed on disk. Buffer reloaded." | echohl None

" https://stackoverflow.com/questions/16743112/open-item-from-quickfix-window-in-vertical-split
" This is only availale in the quickfix window, owing to the filetype
" restriction on the autocmd (see below).
function! <SID>OpenQuickfix(new_split_cmd)
  " 1. the current line is the result idx as we are in the quickfix
  let l:qf_idx = line('.')
  " 2. jump to the previous window
  wincmd p
  " 3. switch to a new split (the new_split_cmd will be 'vnew' or 'split')
  execute a:new_split_cmd
  " 4. open the 'current' item of the quickfix list in the newly created buffer
  "    (the current means, the one focused before switching to the new buffer)
  execute l:qf_idx . 'cc'
endfunction

autocmd FileType qf nnoremap <buffer> <C-v> :call <SID>OpenQuickfix("vnew")<CR>
autocmd FileType qf nnoremap <buffer> <C-x> :call <SID>OpenQuickfix("split")<CR>

" nord-vim
let g:nord_italic = 1
let g:nord_uniform_diff_background = 1

" lightline
set showtabline=2
let g:lightline#bufferline#unnamed = '[No Name]'
let g:lightline = {
      \ 'tabline': {
      \   'left': [[ 'buffers' ]],
      \   'right': [[ 'close' ]]
      \ },
      \ 'colorscheme': 'nord',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ],
      \   'right': [ [ 'line-info' ],
      \             [ 'percent' ],
      \             [ 'fileformat', 'fileencoding', 'filetype' ] ]
      \ },
      \ 'component_expand': {
      \   'buffers': 'lightline#bufferline#buffers',
      \ },
      \ 'component_type': {
      \   'buffers': 'tabsel',
      \ },
      \ 'component_function': {
      \   'gitbranch': 'fugitive#head'
      \ },
      \ }

" custom key maps
let mapleader=' '
nnoremap <Leader>w :w<cr>
nnoremap <Leader>nh :noh<cr><c-l>
nnoremap <Leader><tab> :b#<cr>
nnoremap <Leader>[ :bp<cr>
nnoremap <Leader>] :bn<cr>
nnoremap [q :cprevious<cr>
nnoremap ]q :cnext<cr>
nnoremap [Q :cfirst<cr>
nnoremap ]Q :clast<cr>
nnoremap <Leader>qc :cclose<cr>
nnoremap [w :lprevious<cr>
nnoremap ]w :lnext<cr>
nnoremap [W :lfirst<cr>
nnoremap ]W :llast<cr>
nnoremap <Leader>lc :lclose<cr>
nnoremap g2 :diffg //2<cr>
nnoremap g3 :diffg //3<cr>

let g:terraform_fmt_on_save = 1

" echodoc
let g:echodoc#enable_at_startup = 1
let g:echodoc#type = 'popup'
highlight link EchoDocPopup Pmenu

" strip whitespace on save
let g:strip_whitespace_on_save = 1
let g:strip_whitespace_confirm = 0

" gitgutter
let g:gitgutter_close_preview_on_escape = 1

" fugitive git bindings
let g:fugitive_force_bang_command = 1
nnoremap <Leader>gs :Gstatus<cr>
nnoremap <Leader>gco :Gcommit -v -q<cr>
nnoremap <Leader>gt :Git commit -v -q %:p<cr>
nnoremap <Leader>gr :Gread<cr>
nnoremap <Leader>gw :Gwrite<cr><cr>
nnoremap <Leader>gl :silent! Glog<CR>:bot copen<CR>
nnoremap <Leader>gb :Git branch<Space>
nnoremap <Leader>gch :Git checkout<Space>
nnoremap <Leader>gpp :Git push<Space>
nnoremap <Leader>gpl :Git pull<Space>
nnoremap <Leader>gvd :Gvdiffsplit<cr>

" Key map for quick substitute a word...
nnoremap <Leader>s :%s/\<<C-r><C-w>\>//g<Left><Left>
" ...with confirmation
nnoremap <Leader>sc :%s/\<<C-r><C-w>\>//gc<Left><Left><Left>
nnoremap \\ :Rg <C-r><C-w><CR>

" auto fix some command typo
command! -bang -nargs=? -complete=file W w<bang> <args>
command! -bang -nargs=? -complete=file Wq wq<bang> <args>
command! -bang -nargs=? -complete=file WQ wq<bang> <args>

" write read-only file
cmap w!! w !sudo tee % >/dev/null

" NERDTree
let NERDTreeShowHidden = 1
let g:NERDTreeMapOpenSplit = "x"
let g:NERDTreeMapOpenVSplit = "v"
map <Leader>d :NERDTreeToggle<cr>

" nerdcommenter
let g:NERDSpaceDelims = 1
let g:NERDCompactSexyComs = 1
let g:NERDDefaultAlign = 'left'
let g:NERDCommentEmptyLines = 1
let g:NERDTrimTrailingWhiteSpace = 1

" fzf.vim
let g:fzf_layout = { 'down': '~25%' }
let g:fzf_tags_command = 'ctags -R --exclude=.git --exclude=node_modules --exclude=vendor'
nnoremap <Leader>pf :Files<cr>
nnoremap <Leader>pb :Buffers<cr>
nnoremap <Leader>pt :Tags<cr>
let g:fzf_preview_window = []
" let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.6 } }
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --smart-case --hidden --glob "!.git/*" -- '.shellescape(<q-args>), 1,
  \   fzf#vim#with_preview(), <bang>0)
nnoremap \ :Rg<SPACE>

" deoplete
let g:deoplete#enable_at_startup=1
call deoplete#custom#source('_', 'max_abbr_width', 0)
" call deoplete#custom#source('_', 'max_kind_width', 0)
" call deoplete#custom#source('_', 'max_info_width', 120)
call deoplete#custom#source('_', 'max_menu_width', 0)
" call deoplete#custom#source('omni', 'mark', '')
" call deoplete#custom#option('omni_patterns', { 'go': '[^. *\t]\.\w*' })

" tern
if exists('g:plugs["tern_for_vim"]')
  call g:deoplete#custom#var('javascript', 'tern#Complete')
  " let g:deoplete#omni#functions = {}
  " let g:deoplete#omni#functions.javascript = [ 'tern#Complete' ]
  let g:tern_request_timeout=1
  let g:tern#command = ['tern']
  let g:tern#arguments = ['--persistent']
endif
" deoplete-ternjs
let g:deoplete#sources#ternjs#types = 1
let g:deoplete#sources#ternjs#docs = 1

" ultisnips
let g:UltiSnipsExpandTrigger="<c-j>"
let g:UltiSnipsJumpForwardTrigner="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"
" inoremap <expr><cr> pumvisible() ? deoplete#close_popup() : "\<cr>"
autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | silent! pclose | endif

" vim-tmux-navigator
if has('nvim')
  nmap <BS> :<C-u>TmuxNavigateLeft<cr>
else
  namp <C-h> <C-w>h
endif
let g:tmux_navigator_disable_when_zoomed = 1

" tagbar
nmap <Leader>f :TagbarToggle<CR>
let g:tagbar_type_go = {
	\ 'ctagstype' : 'go',
	\ 'kinds'     : [
		\ 'p:package',
		\ 'i:imports:1',
		\ 'c:constants',
		\ 'v:variables',
		\ 't:types',
		\ 'n:interfaces',
		\ 'w:fields',
		\ 'e:embedded',
		\ 'm:methods',
		\ 'r:constructor',
		\ 'f:functions'
	\ ],
	\ 'sro' : '.',
	\ 'kind2scope' : {
		\ 't' : 'ctype',
		\ 'n' : 'ntype'
	\ },
	\ 'scope2kind' : {
		\ 'ctype' : 't',
		\ 'ntype' : 'n'
	\ },
	\ 'ctagsbin'  : 'gotags',
	\ 'ctagsargs' : '-sort -silent'
\ }

" vim-go
let g:go_gopls_enabled = 1
let g:go_imports_autosave = 1
let g:go_fmt_autosave = 1
let g:go_fmt_command = "goimports"
let g:go_list_type = "quickfix"
let g:go_auto_type_info = 0
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_fields = 0
let g:go_highlight_structs = 1
let g:go_highlight_interfaces = 1
let g:go_doc_popup_window = 1
let g:go_gopls_complete_unimported = 0
let g:go_gopls_use_placeholders = 1
let g:go_term_mode = "terminal"
let g:go_gopls_options=['-remote=auto']
let g:go_code_completion_enabled = 0
let g:go_echo_go_info = 0
let g:go_doc_keywordprg_enabled = 0
nnoremap <Leader><Space> :GoBuild<cr>
" let g:go_def_mapping_enabled = 0
"let g:go_term_enabled = 1
" let g:go_debug = ['lsp']
" let g:go_highlight_operators = 1

nnoremap <Leader>gfs :GoFillStruct<cr>
let g:go_debug_windows = {
  \ 'out':   'botright 10new',
  \ 'vars':  'leftabove 80vnew',
\ }
autocmd FileType go nmap <leader>gor <Plug>(go-run)
autocmd FileType go nmap <leader>gob <Plug>(go-build)
autocmd FileType go nmap <leader>got <Plug>(go-test)
autocmd FileType go nmap <Leader>goc <Plug>(go-coverage-toggle)
autocmd FileType go nmap <Leader>goi <Plug>(go-info)
autocmd FileType go nmap <Leader>god <Plug>(go-doc)
autocmd Filetype go command! -bang A call go#alternate#Switch(<bang>0, 'edit')
autocmd Filetype go command! -bang AV call go#alternate#Switch(<bang>0, 'vsplit')
autocmd Filetype go command! -bang AX call go#alternate#Switch(<bang>0, 'split')
autocmd Filetype go command! -bang AT call go#alternate#Switch(<bang>0, 'tabe')

" nmap <silent><c-]> <Plug>(lcn-definition)
nmap <silent>K <Plug>(lcn-hover)
let g:LanguageClient_showCompletionDocs = 0
let g:LanguageClient_hasSnippetSupport = 0
let g:LanguageClient_hideVirtualTextsOnInsert = 1
let g:LanguageClient_diagnosticsEnable = 0
let g:LanguageClient_useFloatingHover = 1
let g:LanguageClient_rootMarkers = {
  \ 'go': ['.git', 'go.mod'],
  \ }
let g:LanguageClient_serverCommands = {
  \ 'go': ['gopls', '-remote=auto']
  \ }
" autocmd BufWritePre *.go :call LanguageClient#textDocument_formatting_sync()

xnoremap @ :<C-u>call ExecuteMacroOverVisualRange()<CR>

function! ExecuteMacroOverVisualRange()
  echo "@".getcmdline()
  execute ":'<,'>normal @".nr2char(getchar())
endfunction
