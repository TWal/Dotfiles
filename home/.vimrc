" Source a global configuration file if available
if filereadable("/etc/vim/vimrc.local")
  source /etc/vim/vimrc.local
endif
if filereadable("/etc/vim/vimrc")
  source /etc/vim/vimrc
endif

" Plugin management (trough Vundle) {

    filetype off
    set rtp+=~/.vim/bundle/Vundle.vim
    call vundle#begin()

    " Vundle itself {
        " Plugin managment
        Plugin 'VundleVim/Vundle.vim'
    " }

    " Games {
        " Sokoban
        "Plugin 'sokoban.vim'
        " Tetris
        "Plugin 'TeTrIs.vim'
    " }

    " Browsers {
        " Tree file browser
        "Plugin 'scrooloose/nerdtree'
        " No per-tab nerdtree
        "Plugin 'jistr/vim-nerdtree-tabs'
        " Class browser (java, c, c++, python, ...)
        "Plugin 'majutsushi/tagbar'
    " }

    " Color things (syntax, helpers, colorscheme, etc) {
        " Syntax for HTML5
        "Plugin 'othree/html5-syntax.vim'
        " Syntax for less (the improvement of CSS, not of more)
        "Plugin 'groenewege/vim-less'
         "Syntax for CSS3
        "Plugin 'hail2u/vim-css3-syntax'
        "Color parenthesis differently
        "Plugin 'kien/rainbow_parentheses.vim'
        " Molokai colorscheme
        "Plugin 'tomasr/molokai'
        " Jellybeans colorscheme
        "Plugin 'nanotech/jellybeans.vim'
        " Scala support
        "Plugin 'derekwyatt/vim-scala'
        " Add background to terminal vim
        "if $TERM == "xterm-256color" || $TERM == "xterm" || $TERM == "screen-256color"
            "Plugin 'godlygeek/csapprox'
        "endif
        " Fix colorschemes
        Plugin 'KevinGoodsell/vim-csexact'
        " Semantic highlighting
        "Plugin 'jeaye/color_coded'
        " Spacemacs colorscheme
        Plugin 'liuchengxu/space-vim-dark'
    " }

    " Keystroke reducers {
        " Autocompletion
        Plugin 'Valloric/YouCompleteMe'
        "Plugin 'Shougo/neocomplete.vim'
        " Snippets
        "Plugin 'SirVer/ultisnips'
        " Comment easily
        Plugin 'scrooloose/nerdcommenter'
        " Autocompletion for haskell
        Plugin 'ujihisa/neco-ghc'
        " Haskell utility
        Plugin 'eagletmt/ghcmod-vim'
        " ghc-mod dependency
        Plugin 'Shougo/vimproc.vim'
        " Generate ycm config files
        Plugin 'rdnetto/YCM-Generator'
    " }

    " Language specific {
        " Coqide-like
        Plugin 'the-lambda-church/coquille'
        " coquille dependency
        Plugin 'let-def/vimbufsync'
        "Plugin 'eagletmt/coqtop-vim'
        Plugin 'rust-lang/rust.vim'
        Plugin 'JuliaEditorSupport/julia-vim'
        Plugin 'himito/vim-rml'
    " }

    " Misc {
        " Switch .c / .h
        Plugin 'a.vim'
        " Move easily
        "Plugin 'Lokaltog/vim-easymotion'
        " Show which lines have been modified
        "Plugin 'airblade/vim-gitgutter'
        " Beat sublime text users best argument
        " Plugin 'terryma/vim-multiple-cursors'
        " Syntax checker
        Plugin 'scrooloose/syntastic'
    " }

    call vundle#end()

    filetype plugin indent on
" }

"VIM configuration {
        " General {
        syntax on " Enable syntax highlighting
        set nocompatible " Be IMproved!
        set autoindent " Indent automatically
        set foldenable " Enable folding
        set bs=2 " Erase all you want in insert mode
        set history=500 " Keep 500 lines of history
        set showmatch " Show matching brackets.
        set autowrite " Automatically save before commands like :next and :make
        set ttimeoutlen=100 " Don't wait when doing <Esc>O
    " }

    " Search {
        set ignorecase " Do case insensitive matching
        set smartcase " Do smart case matching
        set incsearch " Incremental search
        set hlsearch " Highlight search
    " }

    " UI {
        set showcmd " Show (partial) command in status line.
        set scrolloff=5 " 5 line above / below the cursor when scrolling
        set mat=1 " When typing ')', highlight the matching 0.1s '(' (also work with [] and {})

        set cursorline " Highlight where the cursor is
        "set mouse=a " Enable mouse usage (all modes)

        "Set relative number, and absolute number where the 0 is
        set number
        set relativenumber
        set numberwidth=4 " 4 width numbers

        " No relative number in insert mode
        autocmd InsertEnter * :set norelativenumber
        autocmd InsertLeave * :set relativenumber

        set lazyredraw " Be lazy

        "Status line
        set statusline=%f "File name
        set statusline+=%m "Modified flag
        set statusline+=%r "Readonly flag
        set statusline+=%h "Help buffer flag
        set statusline+=%w "Preview window flag
        set statusline+=\ %y "Space + file type
        set statusline+=\ [%{&fileformat}] "File format
        set statusline+=\ [%{&fileencoding}] "File encoding
        set statusline+=%= "Left / Right separator
        set statusline+=[%b-0x%B] "Ascii character in decimal and hexadecimal
        set statusline+=\ [%c%V, "Cursor column
        set statusline+=\ %l "Cursor line
        set statusline+=/%L] "Total line
        set statusline+=\ %P "Percent of the file
        set statusline+=\  "Final space
        set laststatus=2
        "set fcs=vert:│ "Solid line for vsplit
        set wildmenu
        set wildmode=list:longest,full
    " }

    " Tabs {
        set expandtab
        set softtabstop=4
        set shiftwidth=4
        set tabstop=4
        autocmd FileType make setlocal noexpandtab
        " keywords.txt (for arduino lib) need tabs
        autocmd BufEnter keywords.txt setlocal noexpandtab
        autocmd BufEnter,BufRead,BufNewFile */Unvanquished/* setlocal noexpandtab
    " }

    " Syntax highlighting {
        au BufRead,BufNewFile *.ino set filetype=cpp " Arduino's .ino are cpp files
        set background=dark " Enable dark background
        if $TERM == "xterm-256color" || $TERM == "xterm" || $TERM == "screen-256color"
            set t_Co=256 " Add 256-color support
        endif

        let g:jellybeans_overrides = {
        \   'StatusLine': {
        \       'guifg': 'c0c0c0', 'guibg': '202020',
        \       'ctermfg': 'Grey', 'ctermbg': 'Black'
        \   },
        \   'StatusLineNC': {
        \       'guifg': '4E4E4E', 'guibg': '202020',
        \       'ctermfg': 'Grey', 'ctermbg': 'Black'
        \   }
        \}

        "colorscheme darkblue " Colorscheme not too ugly which is there by default
        "colorscheme twilighted " Load a better colorscheme
        "colorscheme jellybeans
        colorscheme space-vim-dark
        hi Normal guibg=#141517
        let g:csexact_term_override = "tmux.rxvt"

        " Show trailing whitepace and spaces before a tab:
        highlight ExtraWhitespace ctermbg=red guibg=red
        autocmd Syntax * syn match ExtraWhitespace /\s\+$\| \+\ze\t/
    " }

    " Some mappings {
        " Leader
        let mapleader = "-"
        let maplocalleader = "\\"
        " Keep selection when indenting
        xnoremap < <gv
        xnoremap > >gv
        " Swap 0 and ^
        noremap 0 ^
        noremap ^ 0
        " Some mappings like ZZ, ZQ
        nnoremap ZW :w<cr>
        nnoremap ZAW :wa<cr>
        nnoremap ZAQ :qa!<cr>
        nnoremap ZAZ :xa<cr>
        nnoremap ZT :tabe 

        " Disable arrows. hjkl are a lot faster.
        noremap <Up> <nop>
        noremap <Down> <nop>
        noremap <Left> <nop>
        noremap <Right> <nop>

        " Move in tabs
        noremap <C-p> gT
        noremap <C-n> gt

        " Center line when pressing n or N
        "nnoremap n nzz
        "nnoremap N Nzz

        " Exchange [[ and [{, ]] and ]} because [[ and ]] are much easier to
        " type than [{ and ]} but I use them less often
        noremap [{ [[
        noremap ]} ]]
        noremap [[ [{
        noremap ]] ]}
    " }

    " nocompatible++ {
        " Make Y behave like C and D
        nnoremap Y y$
        " Make cw behave like yw, dw (otherwise, cw = ce)
        function WordMotion(motion)
            let before = line('.')
            execute 'normal! v'.v:count1.a:motion
            if line('.') != before
                let target = winsaveview()
                let before = line('.')
                exe 'normal! ge'
                if line('.') != before
                    return
                else
                    call winrestview(target)
                endif
            endif
            execute 'normal! h'
        endfunction
        onoremap <silent> w :call WordMotion('w')<CR>
        onoremap <silent> W :call WordMotion('W')<CR>
    " }

    " Persistence (undo, swap, info, etc) {
        " Thanks to http://stackoverflow.com/a/9528322
        " Save backups to a less annoying place than the current directory.
        if isdirectory($HOME . '/.vim/backup') == 0
          :silent !mkdir -p ~/.vim/backup >/dev/null 2>&1
        endif
        set backupdir-=.
        set backupdir+=.
        set backupdir-=~/
        set backupdir^=~/.vim/backup/
        set backup

        " Save swp files to a less annoying place than the current directory.
        if isdirectory($HOME . '/.vim/swap') == 0
          :silent !mkdir -p ~/.vim/swap >/dev/null 2>&1
        endif
        set directory=~/.vim/swap//
        set directory+=.

        " viminfo stores the the state of your previous editing session
        set viminfo+=n~/.vim/viminfo
        " Jump to the last position
        au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif

        if exists("+undofile")
          " undofile - This allows you to use undos after exiting and restarting
          if isdirectory($HOME . '/.vim/undo') == 0
            :silent !mkdir -p ~/.vim/undo > /dev/null 2>&1
          endif
          set undodir=~/.vim/undo//
          set undodir=~/.vim/undo//
          set undofile
        endif
    " }
" }

" Plugin configuration {
    " YouCompleteMe, Ultisnips, neco-ghc {
        let g:ycm_global_ycm_extra_conf = '~/.vim/ycm_extra_conf.py'
        let g:ycm_filetype_whitelist = {'cpp' : 1, 'python' : 1, 'c' : 1, 'haskell': 1, 'rust': 1}
        let g:ycm_semantic_triggers = {'haskell' : ['.']}
        let g:ycm_rust_src_path = '~/.vim/thirdparty/rustc-src/src'
        " let g:UltiSnipsExpandTrigger = '<Leader>s'
        let g:necoghc_enable_detailed_browse = 1
        let g:neocomplete#enable_at_startup = 1
        let g:neocomplete#enable_smart_case = 1
        let g:neocomplete#lock_buffer_name_pattern = "\\v(\\.h|\\.hpp|\\.cpp|\\.c|\\.py)$"
        au BufRead,BufNewFile *.hs setlocal omnifunc=necoghc#omnifunc
        inoremap <expr><Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
        inoremap <expr><S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
    " }

    " EasyMotion {
        let g:EasyMotion_leader_key = '<Leader>'
        hi link EasyMotionTarget ErrorMsg
        hi link EasyMotionShade  Comment
    " }

    " Rainbow Parentheses {
        "au VimEnter * RainbowParenthesesToggle
        "au Syntax * RainbowParenthesesLoadRound
        "au Syntax * RainbowParenthesesLoadSquare
        "au Syntax * RainbowParenthesesLoadBraces
        " au Syntax * RainbowParenthesesLoadChevrons
    " }
    " NERDTree {
        noremap <F12> :NERDTreeTabsToggle<CR>
    " }

    " Multiple Cursors {
        let g:multi_cursor_exit_from_visual_mode = 0
        let g:multi_cursor_exit_from_insert_mode = 0
    " }

    " Syntastic {
        set statusline+=%#warningmsg#
        set statusline+=%{SyntasticStatuslineFlag()}
        set statusline+=%*
    " }

    " ghc-mod {
        au BufRead,BufNewFile *.hs noremap <silent> <buffer> <LocalLeader>w :GhcModTypeInsert<CR>
        au BufRead,BufNewFile *.hs noremap <silent> <buffer> <LocalLeader>s :GhcModSplitFunCase<CR>
        au BufRead,BufNewFile *.hs noremap <silent> <buffer> <LocalLeader>q :GhcModType<CR>
        au BufRead,BufNewFile *.hs noremap <silent> <buffer> <LocalLeader>e :GhcModTypeClear<CR>
    " }

    " coquille {
        au FileType coq noremap <buffer> <silent> <Up>    :CoqUndo<CR>
        au FileType coq noremap <buffer> <silent> <Left>  :CoqToCursor<CR>
        au FileType coq noremap <buffer> <silent> <Down>  :CoqNext<CR>
        au FileType coq noremap <buffer> <silent> <Right> :CoqToCursor<CR>
    " }

    " HOL mode {
        au! BufRead,BufNewFile *?Script.sml source $HOLDIR/tools/vim/hol.vim
    " }
" }

"let g:opamshare = substitute(system('opam config var share'),'\n$','','''')
"execute "set rtp+=" . g:opamshare . "/merlin/vim"
