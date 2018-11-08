#!/bin/bash

[ "$2" == "" ] && echo "usage: $0 <fetched-prs-fnamet> <[--all | pr#]>" && exit 2

fname=$1
ARCHIVE=`dirname $0`/archive.sh
all=false
filter_pr=$2

[ "$filter_pr" == "--all" ] && all=true


while read line; do
  pos=`expr "$line" : '.[0-9]* '`
  pr=${line:1:$((pos-2))}
  msg=${line:$pos}

  [ "$all" = false ] && [ "$pr" != "$filter_pr" ] && continue

  echo $ARCHIVE $pr "$msg"
  $ARCHIVE $pr "$msg"
done < $fname

