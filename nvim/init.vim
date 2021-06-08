if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
      \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
call plug#begin('~/.config/nvim/bundle')

" General plugins
Plug 'w0rp/ale', { 'tag': '*' }
Plug 'Shougo/deoplete.nvim', { 'tag': '*', 'do': ':UpdateRemotePlugins' }
Plug 'autozimu/LanguageClient-neovim', { 'branch': 'next', 'do': 'bash install.sh' }
Plug 'itchyny/lightline.vim'
Plug 'mgee/lightline-bufferline'
Plug 'maximbaz/lightline-ale'
Plug 'tpope/vim-fugitive', { 'tag': '*' }
Plug 'tpope/vim-rhubarb'
Plug 'airblade/vim-gitgutter'
Plug 'scrooloose/nerdtree'
Plug 'scrooloose/nerdtree-git-plugin'
Plug 'scrooloose/nerdcommenter'
Plug 'junegunn/fzf', { 'tag': '*', 'dir': '~/.fzf', 'do': './install --all' }
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
Plug 'jonathanfilip/vim-lucius'
Plug 'dhruvasagar/vim-zoom'

" colorscheme
Plug 'dracula/vim'
Plug 'arcticicestudio/nord-vim' " should be used with nord-iterm2

" Language plugins
Plug 'fatih/vim-go', { 'tag': '*' }
Plug 'AndrewRadev/splitjoin.vim'
Plug 'rust-lang/rust.vim'
" Plug 'deoplete-plugins/deoplete-go', { 'do': 'make'}
Plug 'ternjs/tern_for_vim', { 'do': 'npm install', 'for': ['javascript'] }
Plug 'pangloss/vim-javascript'
Plug 'carlitux/deoplete-ternjs', { 'do': 'npm install -g tern' }
Plug 'tomlion/vim-solidity'

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

" Folding
set foldmethod=indent
set foldnestmax=5
set foldlevel=5
set foldlevelstart=5
set nofoldenable

" persistent undo
if has('persistent_undo')
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
      \   'right': [ [ 'linter_checking', 'linter_errors', 'linter_warnings', 'linter_ok' ],
      \             [ 'line-info' ],
      \             [ 'percent' ],
      \             [ 'fileformat', 'fileencoding', 'filetype' ] ]
      \ },
      \ 'component_expand': {
      \   'buffers': 'lightline#bufferline#buffers',
      \   'linter_checking': 'lightline#ale#checking',
      \   'linter_warnings': 'lightline#ale#warnings',
      \   'linter_errors': 'lightline#ale#errors',
      \   'linter_ok': 'lightline#ale#ok'
      \ },
      \ 'component_type': {
      \   'buffers': 'tabsel',
      \   'linter_checking': 'left',
      \   'linter_warnings': 'warning',
      \   'linter_errors': 'error',
      \   'linter_ok': 'left'
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
let g:echodoc_enable_at_startup = 1
let g:echodoc#type = "echo"

" strip whitespace on save
let g:strip_whitespace_on_save = 1
let g:strip_whitespace_confirm = 0

" fugitive git bindings
let g:fugitive_force_bang_command = 1
nnoremap <Leader>gs :Gstatus<cr>
nnoremap <Leader>gco :Gcommit -v -q<cr>
nnoremap <Leader>gt :Gcommit -v -q %:p<cr>
nnoremap <Leader>gr :Gread<cr>
nnoremap <Leader>gw :Gwrite<cr><cr>
nnoremap <Leader>gl :silent! Glog<CR>:bot copen<CR>
nnoremap <Leader>gb :Git branch<Space>
nnoremap <Leader>gch :Git checkout<Space>
nnoremap <Leader>gpp :Gpush<Space>
nnoremap <Leader>gpl :Gpull<Space>
nnoremap <Leader>gvd :Gvdiff<cr>

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
nnoremap \ :Rg<SPACE>

" deoplete
let g:deoplete#enable_at_startup=1
call deoplete#custom#source('_', 'max_abbr_width', 0)
call deoplete#custom#source('_', 'max_kind_width', 0)
call deoplete#custom#source('_', 'max_info_width', 120)
call deoplete#custom#source('_', 'max_menu_width', 0)
call deoplete#custom#source('omni', 'mark', '')
call deoplete#custom#option('omni_patterns', { 'go': '[^. *\t]\.\w*' })
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
let g:UltiSnipsJumpForwardTrigner="<c-j>"
let g:UltiSnipsJumpBackwardTrigger="<c-k>"

function! g:AutoCompleteOrSnippetsOrReturnTab()
 if pumvisible()
   return "\<c-n>"
 endif
 call UltiSnips#ExpandSnippet()
 if g:ulti_expand_res == 0
    call UltiSnips#JumpForwards()
    if g:ulti_jump_forwards_res == 0
      return "\<tab>"
    endif
 endif
 return ""
endfunction

inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"
inoremap <expr><cr> pumvisible() ? deoplete#close_popup() : "\<cr>"
autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | silent! pclose | endif

" ALE
nnoremap <Leader>aj :ALENextWrap<cr>
nnoremap <Leader>ak :ALEPreviousWrap<cr>
let g:ale_open_list = 1
let g:ale_list_window_size = 3
let g:ale_lint_on_text_changed = 'never'
let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = '[%linter%] [%severity%] %s'
let g:ale_linters_explicit = 1
let g:ale_fix_on_save = 1
" let g:ale_linters = {
" \   'javascript': ['prettier']
" \}
" let g:ale_fixers = {
" \   'javascript': ['prettier_standard']
" \}
let g:ale_go_golangci_lint_package = 1
" let g:ale_go_golangci_lint_options = '--disable-all --presets=bugs --enable=deadcode --enable=varcheck'
let g:ale_go_golangci_lint_options = '--fast'

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
let g:go_fmt_command = "goimports"
let g:go_list_type = "quickfix"
let g:go_auto_type_info = 0
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_fields = 0
let g:go_highlight_structs = 1
let g:go_highlight_interfaces = 1
let g:go_doc_popup_window = 1
let g:go_gopls_complete_unimported = 1
let g:go_gopls_use_placeholders = 0
let g:go_term_mode = "terminal"
nnoremap <Leader>gfs :GoFillStruct<cr>

"let g:go_term_enabled = 1
" let g:go_debug = ['lsp']
" let g:go_highlight_operators = 1
" let g:go_highlight_build_constraints = 1
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

let g:LanguageClient_rootMarkers = {
  \ 'go': ['.git', 'go.mod'],
  \ }

let g:LanguageClient_serverCommands = {
  \ 'go': ['gopls']
 \ }
" let g:LanguageClient_loggingFile = expand('~/.config/nvim/LanguageClient.log')
" let g:LanguageClient_loggingLevel = 'DEBUG'
let g:LanguageClient_diagnosticsEnable = 0

xnoremap @ :<C-u>call ExecuteMacroOverVisualRange()<CR>

function! ExecuteMacroOverVisualRange()
  echo "@".getcmdline()
  execute ":'<,'>normal @".nr2char(getchar())
endfunction
