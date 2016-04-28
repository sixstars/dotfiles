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

set prompt \033[1;37m[gdb] \033[m

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

define at
    python argc=$argc
    if $argc == 1
        python name="$arg0"
    end
# python code begin
    python 
import subprocess

if argc == 0:
    if len(gdb.objfiles()) == 0:
        print( "Attaching program: " )
        print( "No executable file specified." )
        print( "Use the \"file\" or \"exec-file\" command." )
        name = None
    else:
        name = gdb.objfiles()[0].filename.split("/")[-1]

if name:
    print( "Attaching to %s ..." % name )
    try:
        gdb.execute( "attach " + subprocess.check_output("pidof " + name, shell=True).decode("utf-8").split()[0] )
    except:
        print( "Attach failed!" )
    end
# python end
end
document at
Syntax: at [NAME]
| Attach process by process name or current executable name
end

# Useful functions from Pwngdb
define codebase
    python putcodebase()
end

define off
    python putoff("$arg0")
end

define got
    python got()
end

define dyn
    python dyn()
end

define rop
    python rop()
end

# Heap functions from Pwngdb

define heap
    python putheap()
end

define fastbin
    python putfastbin()
end

define heapinfo
    python putheapinfo()
end

define tracemode
    python tracemode("$arg0")
end

define reg
    python get_reg("$arg0")
end

define tracemalloc
    python set_trace_mode("$arg0")
end

define inused
    python putinused()
end
