syntax on

unlet b:current_syntax
syntax include @SCRIPT syntax/sh.vim
syntax region rbscriptSnip matchgroup=RubyShellSnip start=+<<SCRIPT\s*$+ end=+^\s*SCRIPT$+ contains=@SCRIPT
hi link RubyShellSnip SpecialComment
