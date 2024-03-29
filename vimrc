" show existing tab with 4 spaces width
set tabstop=4
" when indenting with '>', use 4 spaces width
set shiftwidth=4
" On pressing tab, insert 4 spaces
set expandtab
call pathogen#infect()
syntax on
filetype plugin indent on
let g:codedark_term256=1
set t_ut=
colorscheme codedark
" word wrapping off by default
set nowrap
" indentation guides on by default. Turn off with :IndentGuidesDisable
"let g:indent_guides_enable_on_vim_startup = 1

" auto install of vim-plug 
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin()
" on first startup call :PlugUpdate to install these
" note: you'll want to install clangd -- i guess by doing :LspInstallServer
" inside a c file??
Plug 'prabirshrestha/vim-lsp'
Plug 'mattn/vim-lsp-settings'
Plug 'm-pilia/vim-ccls'
call plug#end()

" Register ccls C++ lanuage server.
" I don't think this is doing anything since I installed clang through
" vim-lsp??
if executable('ccls')
   au User lsp_setup call lsp#register_server({
      \ 'name': 'ccls',
      \ 'cmd': {server_info->['ccls']},
      \ 'root_uri': {server_info->lsp#utils#path_to_uri(lsp#utils#find_nearest_parent_file_directory(lsp#utils#get_buffer_path(), 'compile_commands.json'))},
      \ 'initialization_options': {'cache': {'directory': expand('~/.cache/ccls') }},
      \ 'allowlist': ['c', 'cpp', 'objc', 'objcpp', 'cc'],
      \ })
endif

" Key bindings for vim-lsp.
nn <silent> <M-d> :LspDefinition<cr>
nn <silent> <M-r> :LspReferences<cr>
nn <f2> :LspRename<cr>
nn <silent> <M-a> :LspWorkspaceSymbol<cr>
nn <silent> <M-l> :LspDocumentSymbol<cr>

let g:lsp_semantic_enabled = 1
"highlight lspReference ctermfg=white guifg=white ctermbg=darkgrey guibg=darkgrey
" this will make the diagnostics messages appear at the bottom following the
" cursor:
let g:lsp_diagnostics_echo_cursor = 1
" disable diagnostics by default(they're annoying if the project isn't set up)
let g:lsp_diagnostics_enabled = 0

