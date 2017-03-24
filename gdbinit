source ~/.peda/peda.py
source ~/.pwngdb/pwngdb.py
source ~/.pwngdb/angelheap/gdbinit.py

python
import angelheap
config.Option.set("pagesize", 0)
config.Option.set("session", "~/.peda/sessions/peda-session-#FILENAME#.txt")
end

# When inspecting large portions of code the scrollbar works better than 'less'
set pagination off

# Keep a history of all the commands typed. Search is possible using ctrl-r
set history save on
set history filename ~/.gdb_history
set history size 32768
set history expansion on

set prompt \001\033[38;5;214m\002[gdb]\> \001\033[m\002

define hook-run
python
angelheap.init_angelheap()
end
end

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

define tret
    stepuntil ret
end
document tret
Syntax: tret
| Step until ret instruction
end

define tcall
    stepuntil tcall
end
document tcall
Syntax: tcall
| Step until ret instruction
end

