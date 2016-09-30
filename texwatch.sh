#!/bin/bash

# https://github.com/spino327/texwatch.sh
# author: spino327

USAGE="texwatch.sh start|stop|compile <main.tex> <folder>. To start: texwatch.sh start file.tex folder. To stop: texwatch.sh stop"

if [ "$#" -lt "1" ]; then
    echo $USAGE
    exit -1
fi

THIS=$0
CMD=$1
FOLDER=$PWD
if [ "$#" -gt "1" ]; then
    MAIN=$2
fi
if [ "$#" -gt "2" ]; then
    FOLDER=$3
fi

function compile {
    pdflatex -synctex=1 -interaction=nonstopmode $MAIN > /dev/null
    echo "$MAIN recompiled!"
}

function listening_changes {
    fswatch -o `ls $FOLDER/*.tex` | xargs -n 1 -I {} $THIS compile $MAIN $FOLDER
}

function start {
    echo "starting texwatch..."
    echo "Listening folder: '$FOLDER' and target: '$MAIN'"
    listening_changes& 
    spid=$!
    echo background pid=$spid
    echo $spid > .spid
}

function stop {
    echo "stopping texwatch..."
    
    for pid in `cat .spid`; do 
        echo killing pid=$pid
        pkill -P $pid
    done
}

# start
if [ "$CMD" == "start" -a "$#" -ge "2" ]; then
    start
elif [ "$CMD" == "stop" ]; then
    stop
elif [ "$CMD" == "compile" ]; then
    compile
else
    echo $USAGE
fi