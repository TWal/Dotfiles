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
        " Class browser (java, c, c++, python, ...)
        "Bundle 'taglist.vim'
        Bundle 'majutsushi/tagbar'
    " }

    " Color things (syntax, helpers, colorscheme, etc) {
        " Syntax for HTML5
        Bundle 'othree/html5-syntax.vim'
        " Syntax for less (the improvement of CSS, not of more)
        Bundle 'groenewege/vim-less'
         "Syntax for CSS3
        Bundle 'hail2u/vim-css3-syntax'
        " CSS color helper
        Bundle 'skammer/vim-css-color'
        "Color parenthesis differently
        Bundle 'kien/rainbow_parentheses.vim'
        " Molokai colorscheme
        Bundle 'tomasr/molokai'
        " Jellybeans colorscheme
        Bundle 'nanotech/jellybeans.vim'
        " Add background to terminal vim
        Bundle 'godlygeek/csapprox'
        " Scala support
        Bundle 'derekwyatt/vim-scala'
    " }

    " Keystroke reducers {
        " Autocompletion
        Bundle 'Shougo/neocomplcache'
        Bundle 'Shougo/neocomplcache-snippets-complete'
        " Make repeat (.) work with plugins
        Bundle 'tpope/vim-repeat'
        " Surround things with html tags, (), {}, etc
        Bundle 'tpope/vim-surround'
        " Comment easily
        Bundle 'scrooloose/nerdcommenter'
    " }

    " Misc {
        " Switch .c / .h
        Bundle 'a.vim'
        " Move easily
        Bundle 'Lokaltog/vim-easymotion'
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
        set mousefocus
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
        set statusline+=%r "Readorny flag
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
    " }

    " Some mappings {
        let mapleader = "-"
        let maplocalleader = "\\"
        " Move lines up / down (in my dvorak config, t is j (down), and n is k (up))
        nnoremap <Leader>t ddp
        nnoremap <Leader>n ddkP
        " Delete a line in insert mode
        inoremap <C-d> <Esc>ddi
        " Uppercase a word
        nnoremap <C-u> viwUw
        inoremap <C-u> <Esc>viwUei
        " Edit my .vimrc
        nnoremap <Leader>ev :vsplit $MYVIMRC<CR>
        nnoremap <Leader>sv :source $MYVIMRC<CR>
        " Move to the begin / end of a line (S is the equivalent of L in my configuration
        nnoremap H 0
        nnoremap S $
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
    " NeoComplCache & SuperTab {
        let g:neocomplcache_enable_at_startup = 1

        imap <expr> <Tab> neocomplcache#sources#snippets_complete#expandable() ? '<Plug>(neocomplcache_snippets_expand)' : pumvisible() ? '<C-n>' : '<Tab>' 
        smap <tab> <right><plug>(neocomplcache_snippets_jump)
        inoremap <expr><c-e> neocomplcache#complete_common_string()
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
        noremap <F12> :NERDTreeToggle<CR>
    " }
" }

" Programmer Dvorak utilities {
    " Don't hold the shift key to press ':'
    nnoremap ; :

    " HJKL => HTNS
    noremap t j
    noremap T J
    noremap j t
    noremap J T
    noremap <C-w>t <C-w>j
    noremap <C-w>j <C-w>t

    noremap n k
    noremap N K
    noremap k n
    noremap K N
    noremap <C-w>n <C-w>k
    noremap <C-w>k <C-w>n

    noremap s l
    noremap S L
    noremap l s
    noremap L S

" }

