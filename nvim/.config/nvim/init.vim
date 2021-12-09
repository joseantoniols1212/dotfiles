""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" /$$           /$$   /$$                    /$$              
" |__/          |__/  | $$                   |__/              
" /$$ /$$$$$$$  /$$ /$$$$$$       /$$    /$$ /$$ /$$$$$$/$$$$ 
" | $$| $$__  $$| $$|_  $$_/      |  $$  /$$/| $$| $$_  $$_  $$
" | $$| $$  \ $$| $$  | $$         \  $$/$$/ | $$| $$ \ $$ \ $$
" | $$| $$  | $$| $$  | $$ /$$      \  $$$/  | $$| $$ | $$ | $$
" | $$| $$  | $$| $$  |  $$$$/ /$$   \  $/   | $$| $$ | $$ | $$
" |__/|__/  |__/|__/   \___/  |__/    \_/    |__/|__/ |__/ |__/
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Basic settins
source $HOME/.config/nvim/vim-plug/plugins.vim
source $HOME/.config/nvim/general/settings.vim
source $HOME/.config/nvim/keys/mappings.vim

" Visual themes
source $HOME/.config/nvim/themes/onedark.vim
source $HOME/.config/nvim/themes/airline.vim                  " Remember to change airline theme when changing vim theme.

" Plugin configuration
source $HOME/.config/nvim/plug-config/coc.vim
source $HOME/.config/nvim/plug-config/UltiSnips.vim

" Utils
" Scripts
source $HOME/.config/nvim/utils/scripts/bclose.vim
" Spell
source $HOME/.config/nvim/utils/spelling/spell.vim
