syntax on

unlet b:current_syntax
syntax include @DESKTOP syntax/desktop.vim
syntax region shdesktopSnip matchgroup=ShDesktopSnip start=+<<DESKTOP\s*+ end=+^\s*DESKTOP$+ contains=@DESKTOP
hi link ShDesktopSnip SpecialComment
