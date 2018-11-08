#!/bin/bash

fname=$1

if [ "${fname:0:1}" != "/" ]; then
  fname=$(cd `dirname $fname` && pwd)/${fname}
fi

[ "$fname" == "" ] && echo "usage: $0 <output-filename>" && exit 2

source `dirname $0`/common_init.sh

(cd $dest_path && hub pr list > $fname)
