"------------------------------------------------------
"  PLUGINS
"------------------------------------------------------

" auto-install vim-plug
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  "autocmd VimEnter * PlugInstall
  "autocmd VimEnter * PlugInstall | source $MYVIMRC
endif


" Directorio de plugins
call plug#begin('~/.config/nvim/autoload/plugged')
" Aquí irán los plugins a instalar

  " Linea de estado
  Plug 'vim-airline/vim-airline'
  Plug 'vim-airline/vim-airline-themes'

  " Navegador de ficheros
  Plug 'preservim/nerdtree'

  " Mejor sintaxis
  Plug 'sheerun/vim-polyglot'

  " Themes
  Plug 'joshdick/onedark.vim'
  Plug 'arcticicestudio/nord-vim'

  " Latex
  Plug 'lervag/vimtex'

  " Coc
  Plug 'neoclide/coc.nvim', {'branch': 'release'}

  " Snippets
  " Track the engine.
  Plug 'SirVer/ultisnips'
  " Snippets are separated from the engine. Add this if you want them:
  Plug 'honza/vim-snippets'


call plug#end()

