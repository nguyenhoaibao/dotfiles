if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
      \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
call plug#begin('~/.config/nvim/bundle')

" General plugins
Plug 'w0rp/ale'
Plug 'dracula/vim'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'itchyny/lightline.vim'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'scrooloose/nerdtree'
Plug 'scrooloose/nerdtree-git-plugin'
Plug 'scrooloose/nerdcommenter'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-surround'
Plug 'jiangmiao/auto-pairs'
Plug 'ntpeters/vim-better-whitespace'
Plug 'christoomey/vim-tmux-navigator'
Plug 'terryma/vim-multiple-cursors'
Plug 'SirVer/ultisnips'
Plug 'tpope/vim-dispatch'

" Language plugins
Plug 'fatih/vim-go', { 'do': ':GoInstallBinaries' }
Plug 'zchee/deoplete-go', { 'do': 'make'}
Plug 'ternjs/tern_for_vim', { 'do': 'npm install', 'for': ['javascript'] }
Plug 'carlitux/deoplete-ternjs', { 'do': 'npm install -g tern' }
Plug 'lvht/phpcd.vim', { 'for': 'php', 'do': 'composer update'}

call plug#end()

" General
syntax on
set number
set relativenumber
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
colorscheme dracula

augroup vimrcEx
  autocmd!

  " When editing a file, always jump to the last known cursor position.
  " Don't do it for commit messages, when the position is invalid, or when
  " inside an event handler (happens when dropping a file on gvim).
  autocmd BufReadPost *
  \ if &ft != 'gitcommit' && line("'\"") > 0 && line("'\"") <= line("$") |
  \   exe "normal g`\"" |
  \ endif

  " Set syntax highlighting for specific file types
  autocmd BufRead,BufNewFile *.md set filetype=markdown
  autocmd BufRead,BufNewFile *.ejs set filetype=html
  autocmd BufRead,BufNewFile .{jscs,jshint,eslint}rc set filetype=json
  autocmd BufNewFile,BufRead *.go setlocal noexpandtab tabstop=8 softtabstop=8 shiftwidth=8
  autocmd BufNewFile,BufRead *.php setlocal expandtab tabstop=4 softtabstop=4 shiftwidth=4
  autocmd BufEnter * EnableStripWhitespaceOnSave
augroup END

" omnifuncs
augroup omnifuncs
  autocmd!

  autocmd FileType php setlocal omnifunc=phpcd#CompletePHP
augroup END

" js folding
augroup jsFolds
  autocmd!

  autocmd FileType javascript syntax region foldBraces start=/{/ end=/}/ transparent fold keepend extend
  autocmd FileType javascript set foldmethod=syntax
augroup end

" Ag
if executable('ag')
  " Use Ag over Grep
  set grepprg=ag\ --nogroup\ --nocolor

  if !exists(":Ag")
    command -nargs=+ -complete=file -bar Ag silent! grep! <args>|cwindow|redraw!
    nnoremap \ :Ag<SPACE>
  endif
endif

" Airline
" let g:airline_theme='base16_ocean'
" let g:airline_powerline_fonts=1
" let g:airline#extensions#tabline#enabled=1
" let g:airline#extensions#tabline#left_sep=' '
" let g:airline#extensions#tabline#left_alt_sep = '|'
let g:lightline = {
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'fugitive#head'
      \ },
      \ }

let mapleader=' '
nnoremap <Left> :echoe "Use h"<cr>
nnoremap <Right> :echoe "Use l"<cr>
nnoremap <Up> :echoe "Use k"<cr>
nnoremap <Down> :echoe "Use j"<cr>
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

" Key map for quick substitute a word...
nnoremap <Leader>s :%s/\<<C-r><C-w>\>//g<Left><Left>
" ...with confirmation
nnoremap <Leader>sc :%s/\<<C-r><C-w>\>//gc<Left><Left><Left>

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
let $FZF_DEFAULT_COMMAND='ag --hidden --ignore .git --ignore node_modules --ignore vendor -g ""'
let g:fzf_layout = { 'down': '~25%' }
let g:fzf_tags_command = 'ctags -R --exclude=.git --exclude=node_modules --exclude=vendor'
nnoremap <Leader>pf :Files<cr>
nnoremap <Leader>pb :Buffers<cr>
nnoremap <Leader>pt :Tags<cr>

" deoplete
let g:deoplete#enable_at_startup=1
" tern
if exists('g:plugs["tern_for_vim"]')
  let g:deoplete#omni#functions = {}
  let g:deoplete#omni#functions.javascript = [ 'tern#Complete' ]
  let g:tern_request_timeout=1
  let g:tern#command = ['tern']
  let g:tern#arguments = ['--persistent']
endif
" deoplete-ternjs
let g:deoplete#sources#ternjs#types = 1
let g:deoplete#sources#ternjs#docs = 1
" deplete-go
let g:deoplete#sources#go#gocode_binary = $GOPATH.'/bin/gocode'
let g:deoplete#sources#go#sort_class = ['package', 'func', 'type', 'var', 'const']
let g:deoplete#sources#go#use_cache = 0
let g:deoplete#sources#go#json_directory = ''
" deoplete-php
let g:deoplete#ignore_sources = get(g:, 'deoplete#ignore_sources', {})
let g:deoplete#ignore_sources.php = ['omni']

" ultisnips
let g:UltiSnipsExpandTrigger="<c-j>"
let g:UltiSnipsJumpForwardTrigner="<c-f>"
let g:UltiSnipsJumpBackwardTrigger="<c-b>"

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
inoremap <expr><cr> pumvisible() ? deoplete#mappings#close_popup() : "\<cr>"
autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | silent! pclose | endif

" neomake
" autocmd! BufWritePost * Neomake
" eslint
" let s:eslint_path = system('PATH=$(npm bin):$PATH && which eslint')
" let g:neomake_javascript_eslint_exe = substitute(s:eslint_path, '^\n*\s*\(.\{-}\)\n*\s*$', '\1', '')
" let g:neomake_javascript_enabled_makers = ['eslint']
" let g:neomake_html_enabled_makers = []
" let g:neomake_open_list = 2
" let g:neomake_list_height = 3
let g:ale_open_list = 1
let g:ale_list_window_size = 3
let g:ale_sign_error = '⤫'
let g:ale_sign_warning = '⚠'
let g:ale_lint_on_text_changed = 'never'
let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = '[%linter%] [%severity%] %s'
let g:ale_linters = {
\   'javascript': ['eslint'],
\   'go': ['gometalinter'],
\}
let g:ale_go_gometalinter_options = '--disable-all'
\ . ' --enable=vet'
\ . ' --enable=golint'
\ . ' --enable=errcheck'
" \ . ' --enable=ineffassign'
" \ . ' --enable=goconst'
" \ . ' --enable=goimports'
" \ . ' --enable=lll --line-length=120'
" These are slow (>2s)
" \ . ' --enable=varcheck'
" \ . ' --enable=interfacer'
" \ . ' --enable=unconvert'
" \ . ' --enable=structcheck'
" \ . ' --enable=megacheck'

" vim-tmux-navigator
if has('nvim')
  nmap <BS> :<C-u>TmuxNavigateLeft<cr>
else
  namp <C-h> <C-w>h
endif

" Golang Configuration
let g:go_fmt_command = "goimports"
let g:go_list_type = "quickfix"
let g:go_auto_type_info = 1
let g:go_metalinter_autosave = 0
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_fields = 1
let g:go_highlight_structs = 1
let g:go_highlight_interfaces = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1
autocmd FileType go nmap <leader>r <Plug>(go-run)
autocmd FileType go nmap <leader>b <Plug>(go-build)
autocmd FileType go nmap <leader>t <Plug>(go-test)
autocmd FileType go nmap <Leader>c <Plug>(go-coverage-toggle)
autocmd FileType go nmap <Leader>i <Plug>(go-info)
autocmd FileType go nmap <Leader>gd <Plug>(go-doc)
autocmd Filetype go command! -bang A call go#alternate#Switch(<bang>0, 'edit')
autocmd Filetype go command! -bang AV call go#alternate#Switch(<bang>0, 'vsplit')
autocmd Filetype go command! -bang AX call go#alternate#Switch(<bang>0, 'split')
autocmd Filetype go command! -bang AT call go#alternate#Switch(<bang>0, 'tabe')
