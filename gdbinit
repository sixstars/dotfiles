source ~/.peda/peda.py

define re
    if $argc == 0
        target remote localhost:4444
    else
        target remote localhost:$arg0
    end
end
document re
Syntax: re PORT
| remote debuggin, attach gdbserver
end
