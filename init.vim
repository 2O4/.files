"
" vim/neovim config file
"

syntax enable
filetype indent plugin on
set termguicolors
let g:mapleader="\<Space>"
set hidden
set noswapfile
set nobackup
set undodir=~/.config/nvim/undodir
set undofile
set updatetime=300      " to fix gitgutter signs taking few seconds to appear
set foldmethod=indent   " enable folding
set nofoldenable        " disable autofolding when opening file
set noshowmode
set visualbell
set number
set relativenumber
set cursorline
set wildmenu
set path+=**
set wildignore+=**/node_modules/**,**/venv/**
set autoread
set autowrite
set scrolloff=3
set smartindent
set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4

augroup numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave,WinEnter * if &nu | set rnu   cursorline   | endif
  autocmd BufLeave,FocusLost,InsertEnter,WinLeave   * if &nu | set nornu nocursorline | endif
augroup END

au Filetype vim,html,css,scss,typescript setl ts=2 sw=2 et

imap jj <Esc>
"nnoremap <A-l> gt
"nnoremap <A-h> gT


" Tweaks for browsing
let g:netrw_banner=0        " disable annoying banner
"let g:netrw_browse_split=4  " open in prior window
"let g:netrw_altv=1          " open splits to the right
let g:netrw_liststyle=3     " tree view

" Change indent continuously
vmap < <gv
vmap > >gv

" Automatic installation vim-plug
if has('nvim') && empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
elseif empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif

autocmd VimEnter *
  \  if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \|   PlugInstall --sync | q
  \| endif

call plug#begin('~/.files/gitignore/vim/plugins')

Plug 'chriskempson/base16-vim'
Plug 'mbbill/undotree'
"Plug 'tpope/vim-fugitive'
Plug 'junegunn/fzf', { 'do': './install --all' }
"Plug 'ycm-core/YouCompleteMe', { 'do': './install.py' }
Plug 'neoclide/coc.nvim', {'branch': 'release'}
"Plug 'dense-analysis/ale'
Plug 'sheerun/vim-polyglot'
Plug 'junegunn/vim-easy-align'
Plug 'alvan/vim-closetag'
Plug 'jiangmiao/auto-pairs'
Plug 'airblade/vim-gitgutter'
Plug 'yuttie/comfortable-motion.vim'
Plug 'ap/vim-css-color'

"Plug 'SirVer/ultisnips'
"Plug 'honza/vim-snippets'

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

Plug 'preservim/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'ryanoasis/vim-devicons'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'

call plug#end()


"base16-vim
let base16colorspace=256
function! s:base16_customize() abort
  call Base16hi("Bold", "", "", "", "", "NONE")
  " get list of colorschemes
  let l:colorschemes = getcompletion('', 'highlight')
  for c in l:colorschemes
    if synIDattr(synIDtrans(hlID(c)), 'bold')
      call Base16hi(c, "", "", "", "", "NONE")
    endif
  endfor
endfunction
augroup on_change_colorschema
  autocmd!
  autocmd ColorScheme * call s:base16_customize()
augroup END
try
  colorscheme base16-tomorrow-night-custom
catch
  colorscheme base16-tomorrow-night
endtry


"custom colors
set list
set listchars=tab:↦\ ,trail:·,space:·
hi Whitespace ctermfg=237 guifg=#414550
hi SpecialKey ctermfg=237 guifg=#414550
hi Bold term=NONE cterm=NONE gui=NONE guisp=NONE

hi EndOfBuffer ctermfg=234 guifg=#1b1b1b
hi Normal ctermbg=234 guibg=#1b1b1b
hi LineNr ctermbg=234 guibg=#1b1b1b

hi CursorLine ctermbg=236 guibg=#282A2E
hi CursorLineNR ctermbg=236 guibg=#282A2E
hi Visual ctermbg=236 guibg=#282A2E

set fillchars+=vert:│
hi VertSplit ctermfg=238 ctermbg=NONE cterm=NONE guibg=NONE guifg=#444444
hi StatusLine ctermfg=238 ctermbg=238 cterm=NONE guibg=#444444
hi StatusLineNC ctermfg=238 ctermbg=238 cterm=NONE guibg=#444444 guifg=#444444

if !has('nvim')
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  let &t_SI = "\e[6 q"  " cursor set to small vertical line in insert mode
  let &t_EI = "\e[2 q"
endif


" vim-easy-align
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)


"ultisnips
let g:UltiSnipsExpandTrigger       = "<c-Space>s"
let g:UltiSnipsJumpForwardTrigger  = "<c-Space>s"
let g:UltiSnipsJumpBackwardTrigger = "<c-Space>p"
let g:UltiSnipsListSnippets        = "<c-Space>k"

"fzf
nmap <leader>f :FZF<CR>


"coc
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"


"undotree
nnoremap <leader>u :UndotreeToggle<CR>
let g:undotree_WindowLayout = 3
let g:undotree_ShortIndicators = 1


"nerdtree
map <leader>n :NERDTreeToggle <CR>
" open a NERDTree automatically
"autocmd vimenter * NERDTree
"autocmd vimenter * wincmd p
" open NERDTree automatically when vim starts up on opening a directory
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | exe 'cd '.argv()[0] | endif
" close vim if the only opened window left is NERDTree
autocmd BufEnter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
let NERDTreeIgnore = [ '__pycache__', '\.pyc$', '\.o$', '\.swp',  '*\.swp',  'node_modules/' ]
let NERDTreeShowHidden=1
let g:NERDTreeDirArrowExpandable = ''
let g:NERDTreeDirArrowCollapsible = ''
let g:WebDevIconsNerdTreeAfterGlyphPadding = ' '
let NERDTreeMapOpenSplit="s"
let NERDTreeMapPreviewSplit="gs"
let NERDTreeMapOpenVSplit="v"
let NERDTreeMapPreviewVSplit="gv"
let NERDTreeMapActivateNode="l"
let NERDTreeMapJumpNextSibling="<leader>j"
let NERDTreeMapJumpPrevSibling="<leader>k"
let NERDTreeMinimalUI = 1
let NERDTreeShowLineNumbers = 0
let NERDTreeQuitOnOpen=1
"" Auto reveal file in tree
"" source: https://stackoverflow.com/a/59977029
"" Check if NERDTree is open or active
"function! IsNERDTreeOpen()
"  return exists("t:NERDTreeBufName") && (bufwinnr(t:NERDTreeBufName) != -1)
"endfunction
"" Call NERDTreeFind iff NERDTree is active, current window contains a modifiable
"" file, and we're not in vimdiff
"function! SyncTree()
"  if &modifiable && IsNERDTreeOpen() && strlen(expand('%')) > 0 && !&diff
"    NERDTreeFind
"    wincmd p
"  endif
"endfunction
"" Highlight currently open buffer in NERDTree
"autocmd BufEnter * call SyncTree()
"function! ToggleNerdTree()
"  set eventignore=BufEnter
"  "NERDTreeToggle
"  " https://github.com/jistr/vim-nerdtree-tabs
"  NERDTreeTabsToggle
"  set eventignore=
"endfunction


"YouCompleteMe
let g:ycm_collect_identifiers_from_tags_files = 1
let g:ycm_seed_identifiers_with_syntax = 1
let g:ycm_complete_in_comments = 1
let g:ycm_complete_in_strings = 1
let g:ycm_autoclose_preview_window_after_insertion = 1


"vim-airline-themes
let g:airline_theme='custom'


"vim-airline
let g:airline_focuslost_inactive=1
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'unique_tail'
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif
let g:airline_left_sep = ""
let g:airline_left_alt_sep = "│"
let g:airline_right_sep = ""
let g:airline_right_alt_sep = "│"
"let g:airline_left_sep = "\uE0BC"
"let g:airline_left_alt_sep = "\uE0BD"
"let g:airline_right_sep = "\uE0BA"
"let g:airline_right_alt_sep = "\uE0BB"
let g:airline_symbols.maxlinenr = '☰'   " ㏑
let g:airline_symbols.branch = ''       " ⎇  ⮁
let g:airline_symbols.readonly = ''


"vim-nerdtree-syntax
let g:NERDTreeLimitedSyntax = 1
let g:NERDTreeExtensionHighlightColor = {}
let g:NERDTreeExtensionHighlightColor['py'] = '87AFD7'


"vim-gitgutter
hi! link SignColumn LineNr
let g:gitgutter_set_sign_backgrounds = 1
hi GitGutterAdd guifg=#B5BD68 ctermfg=150
hi GitGutterChange guifg=#75BEFF ctermfg=179
hi GitGutterDelete guifg=#CC6666 ctermfg=174
hi GitGutterChangeDelete guifg=#CC6666 ctermfg=174
let g:gitgutter_highlight_lines = 0
"let g:gitgutter_highlight_linenrs = 1
hi GitGutterAddLineNr guifg=#B5BD68 ctermfg=150
hi GitGutterChangeLineNr guifg=#75BEFF ctermfg=179
hi GitGutterDeleteLineNr guifg=#CC6666 ctermfg=174
hi GitGutterChangeDeleteLineNr guifg=#CC6666 ctermfg=174
let g:gitgutter_sign_added = '▕'        " ▍▏
let g:gitgutter_sign_modified = '▕'
let g:gitgutter_sign_removed = '▸'      " ➤ ► ▁
let g:gitgutter_sign_modified_removed = '▸'

