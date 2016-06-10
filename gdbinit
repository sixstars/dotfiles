source ~/.peda/peda.py
source ~/.pwngdb/pwngdb.py

# When inspecting large portions of code the scrollbar works better than 'less'
set pagination off

# Keep a history of all the commands typed. Search is possible using ctrl-r
set history save on
set history filename ~/.gdb_history
set history size 32768
set history expansion on

set print asm-demangle on

set prompt \001\033[38;5;214m\002[gdb]\$ \001\033[m\002

# Custom functions

define re
    if $argc == 0
        target remote localhost:4444
    else
        target remote localhost:$arg0
    end
end
document re
Syntax: re PORT
| Remote debug
end
