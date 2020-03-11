call plug#begin('~/.vim/plugged')
Plug 'prabirshrestha/async.vim'
Plug 'prabirshrestha/vim-lsp'
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/asyncomplete-lsp.vim'
Plug 'prabirshrestha/asyncomplete-flow.vim'
Plug 'runoshun/tscompletejob'
Plug 'prabirshrestha/asyncomplete-tscompletejob.vim'
Plug 'prabirshrestha/asyncomplete-gocode.vim'
Plug 'pangloss/vim-javascript'
Plug 'w0rp/ale'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'vim-airline/vim-airline'
Plug 'tpope/vim-fugitive'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'google/vim-jsonnet'
Plug 'tpope/vim-unimpaired'
call plug#end()

let g:ale_linters = {
      \ }
let g:ale_fixers = {
            \ }
" Rust
if executable('rls')
  au User lsp_setup call lsp#register_server({
        \ 'name': 'rls',
        \ 'cmd': {server_info->['rustup', 'run', 'nightly', 'rls']},
        \ 'workspace_config': {'rust': {'clippy_preference': 'on'}},
        \ 'whitelist': ['rust'],
        \ })
  let g:ale_linters.rust = ['rls']
  let g:ale_rust_rls_toolchain = 'nightly'
endif

if executable('rustfmt')
  let g:ale_fixers.rust = ['rustfmt']
endif

" C/C++ completion
if executable('clangd')
	au User lsp_setup call lsp#register_server({
				\ 'name': 'clangd',
				\ 'cmd': {server_info->['clangd']},
				\ 'whitelist': ['c', 'cpp', 'objc', 'objcpp'],
				\ })
  " clangd does this for us
  let g:ale_linters.cpp = []
endif

if executable('clang-format')
  let g:ale_fixers.cpp = ['clang-format']
endif

let g:ale_linters.javascript = []
let g:ale_fixers.javascript = []
if executable('eslint')
  let g:ale_linters.javascript = g:ale_linters.javascript + ['eslint']
endif
if executable('prettier')
  let g:ale_fixers.javascript = g:ale_fixers.javascript + ['prettier']
endif
let g:ale_fixers.typescript = g:ale_fixers.javascript
let g:ale_fixers.flow = g:ale_fixers.javascript

" Javascript / Flow setup
if executable('flow')
	au User asyncomplete_setup call asyncomplete#register_source(asyncomplete#sources#flow#get_source_options({
				\ 'name': 'flow',
				\ 'whitelist': ['javascript'],
				\ 'completor': function('asyncomplete#sources#flow#completor'),
				\ }))
  let g:javascript_plugin_flow = 1
  let g:ale_linters.javascript = g:ale_linters.javascript + ['flow']
endif

" General completion & linting setup
let g:asyncomplete_smart_completion = 1
let g:asyncomplete_auto_popup = 1
let g:asyncomplete_remove_duplicates = 1
let g:ale_c_parse_compile_commands = 1
imap <c-space> <Plug>(asyncomplete_force_refresh)
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<cr>"
if has('nvim')
  tnoremap <Esc> <C-\><C-n>
endif
set pumheight=10

" ctrlp
let g:ctrlp_custom_ignore = 'node_modules\|DS_Store\|git'
let g:ctrlp_max_files=0
let g:ctrlp_user_command = {
  \ 'types': {
    \ 1: ['.git', 'cd %s && git ls-files'],
    \ },
  \ 'fallback': 'find %s -type f'
  \ }

" Go
let g:go_def_mode='gopls'
call asyncomplete#register_source(asyncomplete#sources#gocode#get_source_options({
    \ 'name': 'gocode',
    \ 'whitelist': ['go'],
    \ 'completor': function('asyncomplete#sources#gocode#completor'),
    \ 'config': {
    \    'gocode_path': expand('~/go/bin/gocode')
    \  },
    \ }))

" Typescript
call asyncomplete#register_source(asyncomplete#sources#tscompletejob#get_source_options({
    \ 'name': 'tscompletejob',
    \ 'whitelist': ['typescript'],
    \ 'completor': function('asyncomplete#sources#tscompletejob#completor'),
    \ }))

" Python
if executable('pyls')
    " pip install python-language-server
    au User lsp_setup call lsp#register_server({
        \ 'name': 'pyls',
        \ 'cmd': {server_info->['pyls']},
        \ 'whitelist': ['python'],
        \ })
endif

if executable('autopep8')
  let g:ale_fixers.python = ['autopep8']
endif

" General vim options
set smartindent
set tabstop=2
set shiftwidth=2
set expandtab
set clipboard=unnamed
set hidden
colorscheme elflord
:highlight Pmenu ctermbg=gray guibg=gray
