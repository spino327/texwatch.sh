# texwatch.sh
A daemon that watch for changes in latex files and recompiles them if it detects a change.

# Inspiration
Automatic TeX Recompilation script by http://c9x.me/texwatch.

# Dependencies
- fswatch: https://github.com/emcrisostomo/fswatch. In osx you can install it using `brew install fswatch`

# How to use
> texwatch.sh start|stop|compile <main.tex> <tex_cmd>.  
>    To start: texwatch.sh start file.tex folder.  
>    To stop: texwatch.sh stop.  
>    main.tex: main tex file.  
>    tex_cmd: tex command to execute, e.g. pdflatex, xelatex,... 

For instance, to watch changes for a tmp.tex file that you want to compile with xelatex:  

> $ /path/to/texwatch.sh start tmp.tex xelatex

To stop the daemon you need to go to the folder where tmp.tex

> $ /path/to/texwatch.sh stop  
