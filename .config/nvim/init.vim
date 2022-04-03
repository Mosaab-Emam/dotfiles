call plug#begin()
Plug 'rbgrouleff/bclose.vim'
" Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'neovim/nvim-lspconfig'
Plug 'glepnir/lspsaga.nvim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'ellisonleao/gruvbox.nvim'
Plug 'leafOfTree/vim-svelte-plugin'
Plug 'Raimondi/delimitMate'
Plug 'tpope/vim-fugitive'
call plug#end()

" What is:
" noswpfile
" noshowmode
" omnifunc
" wildmenu
" lazyredraw



nnoremap <silent> gh <cmd>lua require'lspsaga.provider'.lsp_finder()<cr>

" General editor settings
set nu rnu
set tabstop=2
set autoindent
set smartindent
set nocompatible
filetype plugin on
set path+=**
set clipboard=unnamed
set softtabstop=2
set shiftwidth=2

" Netrw
set autochdir
let g:netrw_liststyle = 3
let g:netrw_banner = 0
let g:netrw_browse_split = 4
let g:netrw_winsize = 25

function! ToggleVExplorer()
    if exists("t:expl_buf_num")
        let expl_win_num = bufwinnr(t:expl_buf_num)
        let cur_win_num = winnr()

        if expl_win_num != -1
            while expl_win_num != cur_win_num
                exec "wincmd w"
                let cur_win_num = winnr()
            endwhile

            close
        endif

        unlet t:expl_buf_num
    else
         Vexplore!
         let t:expl_buf_num = bufnr("%")
    endif
endfunction

map <silent> <F2> :call ToggleVExplorer()<cr>
" Open file, but keep focus in Explorer
autocmd filetype netrw nmap <c-a> <cr>:wincmd W<cr>

" Themes and style
syntax enable
set termguicolors
set background=dark
colorscheme gruvbox
map <space> /
map <C-space> ?
map <silent> ,<cr> :noh<cr>
nnoremap \ :Prettier<cr>

" Airline
let g:airline_theme='onedark'
let g:airline_section_x=''
let g:airline_section_y=''
let g:airline_section_z=''
let g:airline#extensions#tabline#enabled = 1

command! -nargs=0 Prettier :call CocAction('runCommand', 'prettier.formatFile')

nnoremap <c-j> :tabprevious<cr>
nnoremap <c-k> :tabnext<cr>
nnoremap ,bn :bnext<cr>
nnoremap ,bp :bprevious<cr>
nnoremap ,bd :bdelete<cr>
nnoremap ,bd :Bclose<cr>
nnoremap ,ba :1,1000 bd!<cr>
nnoremap ,bf :bfirst<cr>
nnoremap ,bl :blast<cr>
nnoremap <silent> <c-space> :Lspsaga lsp_finder<cr>
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

vnoremap <C-r> "hy:%s/<C-r>h//gc<left><left><left>
