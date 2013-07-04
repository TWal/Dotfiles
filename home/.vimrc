" Source a global configuration file if available
if filereadable("/etc/vim/vimrc.local")
  source /etc/vim/vimrc.local
endif
if filereadable("/etc/vim/vimrc")
  source /etc/vim/vimrc
endif

" Plugin management (trough Vundle) {

    filetype off
    set rtp+=~/.vim/bundle/vundle/
    call vundle#rc()

    " Vundle itself {
        " Plugin managment
        Bundle 'gmarik/vundle'
    " }

    " Games {
        " Sokoban
        Bundle 'sokoban.vim'
        " Tetris
        Bundle 'TeTrIs.vim'
    " }

    " Browsers {
        " Tree file browser
        Bundle 'scrooloose/nerdtree'
        " No per-tab nerdtree
        Bundle 'jistr/vim-nerdtree-tabs'
        " Class browser (java, c, c++, python, ...)
        Bundle 'majutsushi/tagbar'
    " }

    " Color things (syntax, helpers, colorscheme, etc) {
        " Syntax for HTML5
        Bundle 'othree/html5-syntax.vim'
        " Syntax for less (the improvement of CSS, not of more)
        Bundle 'groenewege/vim-less'
         "Syntax for CSS3
        Bundle 'hail2u/vim-css3-syntax'
        "Color parenthesis differently
        Bundle 'kien/rainbow_parentheses.vim'
        " Molokai colorscheme
        Bundle 'tomasr/molokai'
        " Jellybeans colorscheme
        Bundle 'nanotech/jellybeans.vim'
        " Scala support
        Bundle 'derekwyatt/vim-scala'
        " Add background to terminal vim
        if $TERM == "xterm-256color" || $TERM == "xterm" || $TERM == "screen-256color"
            Bundle 'godlygeek/csapprox'
        endif
    " }

    " Keystroke reducers {
        " Autocompletion
        Bundle 'Valloric/YouCompleteMe'
        " Snippets
        Bundle 'SirVer/ultisnips'
        " Supertab (make YCM and Ultisnips work together)
        Bundle 'ervandew/supertab'
        " Comment easily
        Bundle 'scrooloose/nerdcommenter'
    " }

    " Misc {
        " Switch .c / .h
        Bundle 'a.vim'
        " Move easily
        Bundle 'Lokaltog/vim-easymotion'
        " Show which lines have been modified
        Bundle 'airblade/vim-gitgutter'
        " Beat sublime text users best argument
        Bundle 'terryma/vim-multiple-cursors'
        " Syntax checker
        Bundle 'scrooloose/syntastic'
    " }

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
    " }

    " Search {
        set ignorecase " Do case insensitive matching
        set smartcase " Do smart case matching
        set incsearch " Incremental search
    " }

    " UI {
        "set ruler " Display informations about the cursor position in the status bar (no more needed with statusline)
        set showcmd " Show (partial) command in status line.
        set scrolloff=5 " 5 line above / below the cursor when scrolling
        set mat=1 " When typing ')', highlight the matching 0.1s '(' (also work with [] and {})

        set cursorline " Highlight where the cursor is
        set mouse=a " Enable mouse usage (all modes)

        set relativenumber " Enable relative numbers
        set numberwidth=4 " 4 width numbers
        "Relative number in command mode, absolute number in insert mode
        autocmd InsertEnter * :set number
        autocmd InsertLeave * :set relativenumber

        "Disable arrows. hjkl are a lot faster.
        nnoremap <Up> <nop>
        nnoremap <Down> <nop>
        nnoremap <Left> <nop>
        nnoremap <Right> <nop>
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
        set fcs=vert:│ "Solid line for vsplit
        set wildmenu
        set wildmode=list:longest,full
    " }

    " Tabs {
        set expandtab
        set softtabstop=4
        set shiftwidth=4
        set tabstop=4
        autocmd FileType make setlocal noexpandtab
        autocmd BufEnter keywords.txt noexpandtab "keywords.txt (for arduino lib) need tabs
    " }

    " Syntax highlighting {
        au BufRead,BufNewFile *.ino set filetype=cpp " Arduino's .ino are cpp files
        set background=dark " Enable dark background
        if $TERM == "xterm-256color" || $TERM == "xterm" || $TERM == "screen-256color"
            set t_Co=256 " Add 256-color support
        endif
        "colorscheme molokai " Load a nice colorscheme (desert is quite nice too)
        colorscheme jellybeans
        " Show trailing whitepace and spaces before a tab:
        :highlight ExtraWhitespace ctermbg=red guibg=red
        :autocmd Syntax * syn match ExtraWhitespace /\s\+$\| \+\ze\t/
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

        if exists("+undofile")
          " undofile - This allows you to use undos after exiting and restarting
          if isdirectory($HOME . '/.vim/undo') == 0
            :silent !mkdir -p ~/.vim/undo > /dev/null 2>&1
          endif
          set undodir=~/.vim/undo//
          set undofile
        endif
    " }
" }

" Plugin configuration {
    " YouCompleteMe, Ultisnips and Supertab {
        let g:ycm_key_list_select_completion = ['<C-TAB>', '<Down>']
        let g:ycm_key_list_previous_completion = ['<C-S-TAB>', '<Up>']
        let g:SuperTabDefaultCompletionType = '<C-Tab>'
        let g:ycm_global_ycm_extra_conf = '~/.vim/ycm_extra_conf.py'
    " }

    " EasyMotion {
        let g:EasyMotion_leader_key = '<Leader>'
        hi link EasyMotionTarget ErrorMsg
        hi link EasyMotionShade  Comment
    " }

    " Rainbow Parentheses {
        au VimEnter * RainbowParenthesesToggle
        au Syntax * RainbowParenthesesLoadRound
        au Syntax * RainbowParenthesesLoadSquare
        au Syntax * RainbowParenthesesLoadBraces
        " au Syntax * RainbowParenthesesLoadChevrons
    " }
    " NERDTree {
        noremap <F12> :NERDTreeTabsToggle<CR>
    " }

    " Multiple Cursors {
        let g:multi_cursor_exit_from_visual_mode = 0
        let g:multi_cursor_exit_from_insert_mode = 0
    " }
" }


" Programmer Dvorak utilities {
    " Don't hold the shift key to press ':'
    nnoremap ; :

    " HJKL => HTNS
    noremap t j
    "noremap T J
    noremap j t
    "noremap J T
    noremap <C-w>t <C-w>j
    noremap <C-w>j <C-w>t

    noremap n k
    "noremap N K
    noremap k n
    "noremap K N
    noremap <C-w>n <C-w>k
    noremap <C-w>k <C-w>n

    noremap s l
    "noremap S L
    noremap l s
    "noremap L S

" }

