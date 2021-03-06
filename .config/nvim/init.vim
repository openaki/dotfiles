
" -------------------------------------------------------------------------------------------------
" plugins
" -------------------------------------------------------------------------------------------------
call plug#begin('~/.local/share/nvim/plugged')

Plug 'jremmen/vim-ripgrep'
Plug 'honza/vim-snippets'
"Plug 'kien/ctrlp.vim' "file fuzzy search
"Plug 'scrooloose/nerdcommenter'
Plug 'scrooloose/nerdtree'
Plug 'NLKNguyen/papercolor-theme'
Plug 'majutsushi/tagbar'
Plug 'fatih/vim-go'
Plug 'neoclide/coc.nvim', {'do': 'yarn install --frozen-lockfile'}
Plug 'itchyny/lightline.vim'
" (Optional) Multi-entry selection UI.
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'jiangmiao/auto-pairs'
"Plug 'scrooloose/syntastic'

"Plug 'SirVer/ultisnips'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'vim-scripts/a.vim'

Plug 'rust-lang/rust.vim'
Plug 'alaviss/nim.nvim'
call plug#end()

" -------------------------------------------------------------------------------------------------
" colors
" -------------------------------------------------------------------------------------------------
set t_Co=256 "required for urxvt
set background=dark "dark or light
colorscheme PaperColor

" -------------------------------------------------------------------------------------------------
" settings
" -------------------------------------------------------------------------------------------------
filetype on "detect files based on type
filetype plugin on "when a file is edited its plugin file is loaded (if there is one for the 
                   "detected filetype) 
filetype indent on "maintain indentation

autocmd BufNewFile,BufRead *.nim, set filetype=nim

set history=10000
set showcmd
set ignorecase
set smartcase       " Case insensitive searches become sensitive with capitals
set incsearch "persist search highlight
set hlsearch "highlight as search matches
set mouse=a "use the mouse; you're a terrible person
set noswapfile "the world is a better place without swap
set nobackup "backups never helped anyone
set nu "enable line numbers
set splitbelow "default open splits below (e.g. :GoDoc)
set listchars=eol:$,tab:>-,trail:~,extends:>,precedes:< "sets chars representing "invisibles when
                                                        "`set list!` is called
set expandtab "insert leader when tab key is pressed
set tabstop=4 "number of spaces inserted when tab is pressed
set softtabstop=4 
set shiftwidth=4 "number of spaces to use for each auto indent
set wildmenu
set wildmode=list:longest,full


"set cc=100 "draw bar down column 100

" -------------------------------------------------------------------------------------------------
" mapping
" -------------------------------------------------------------------------------------------------
let mapleader = " " "leader key is '<space>'
" nerd tree

nmap <Leader>tn :NERDTreeToggle<cr>
nmap <Leader>tf :NERDTreeFind<cr>

"! ensures first result is not auto opened
nmap <Leader>* :Rg<cr>
" toggle show invisibles
"ctl+space for assist
inoremap <C-@> <c-x><c-o>
nmap <Leader>m :set spell!<cr>

" disable vim-go :GoDef short cut (gd)
" this is handled by LanguageClient [LC]
let g:go_def_mapping_enabled = 0
" disable fmt on save
let g:go_fmt_autosave = 0


" use gopls over gocode although typically done
" via language server any way (see mapping below)
"let g:go_info_mode = 'gopls'

" Some servers have issues with backup files, see #649
set nobackup
set nowritebackup

" Better display for messages
set cmdheight=2

" Smaller updatetime for CursorHold & CursorHoldI
set updatetime=300

" don't give |ins-completion-menu| messages.
set shortmess+=c

" always show signcolumns
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction


" Coc Related bindings

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"


function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction


" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end



nmap <leader><space> :Files<cr>
nmap <leader>bb :Buffers<cr>

"Use `[c` and `]c` to navigate diagnostics
nmap <silent> [c <Plug>(coc-diagnostic-prev)
nmap <silent> ]c <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Remap for rename current word
nmap <leader>cr <Plug>(coc-rename)

" Remap for format selected region
vmap <leader>cf  <Plug>(coc-format-selected)
nmap <leader>cf  :call CocAction('format')<cr>

" Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
vmap <leader>cv  <Plug>(coc-codeaction-selected)
nmap <leader>cv  <Plug>(coc-codeaction-selected)

" Remap for do codeAction of current line
nmap <leader>ca  <Plug>(coc-codeaction)
" Fix autofix problem of current line
nmap <leader>cc  <Plug>(coc-fix-current)

"show documentation in preview window
nmap <silent> <leader>cu :call <SID>show_documentation()<CR>
" Show all diagnostics
nmap <silent> <leader>cl  :<C-u>CocList diagnostics<cr>
" Manage extensions
nmap <silent> <leader>ce  :<C-u>CocList extensions<cr>
" Show commands
" Find symbol of current document
nmap <silent> <leader>co  :<C-u>CocList outline<cr>

" Search workleader symbols
nmap <silent> <leader>cs  :<C-u>CocList -I symbols<cr>

" Do default action for next item.
nmap <silent> <leader>cj  :<C-u>CocNext<CR>
" Do default action for previous item.
nmap <silent> <leader>ck  :<C-u>CocPrev<CR>
" Resume latest coc list
nmap <silent> <leader>c'  :<C-u>CocListResume<CR>

" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')

" Use `:Fold` to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

command W w

" Add diagnostic info for https://github.com/itchyny/lightline.vim
let g:lightline = {
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'cocstatus', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'cocstatus': 'coc#status'
      \ },
      \ }


nmap <leader>wj :wincmd j<CR>
nmap <leader>wk :wincmd k<CR>
nmap <leader>wl :wincmd l<CR>
nmap <leader>wv :wincmd v<CR> :wincmd l<CR>
nmap <leader>ws :wincmd s<CR> :wincmd j<CR>
nmap <leader>wq :wincmd q<CR>
nmap <leader>wh :wincmd h<CR>
nmap <leader>ww :Windows<CR>
" (w)indow-(d)elete
nmap <leader>wd :wincmd q<CR>
" (w)indow-(m)aximize
nmap <leader>wm :only<CR>



autocmd TermOpen * if &buftype ==# 'terminal'|nnoremap <buffer>q :q<CR>|endif


" language related bindings .. all start with <leader>l

au FileType go nmap <silent> <leader>lu  :<C-u>GoDocBrowser<cr>
autocmd Filetype go command! -bang A call go#alternate#Switch(<bang>0, 'edit')
autocmd Filetype go command! -bang AV call go#alternate#Switch(<bang>0, 'vsplit')
autocmd Filetype go command! -bang AS call go#alternate#Switch(<bang>0, 'split')

au FileType rust nmap <leader>lt :w<CR> :<C-u>RustTest -- --nocapture<cr>
au FileType rust nmap <leader>la :w<CR> :<C-u>Ctest -- --nocapture<cr>
au FileType rust nmap <leader>lc :w<CR> :<C-u>Cbuild --tests<cr>




