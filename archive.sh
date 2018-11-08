#!/bin/bash

[ "$2" == "" ] && echo "usage: $0 <#pr> <message>"

# init

pr=$1
msg="$2"
branch="pr-$1"

source `dirname $0`/common_init.sh

GIT_PR="git -C $dest_path"


# checkout PR
echo "(cd $dest_path && hub pr checkout $pr $branch)"
(cd $dest_path && git branch -D $branch; hub pr checkout $pr $branch)
rc=$?; [ $rc != 0 ] && echo "ERROR: failed to fetch PR $pr" && exit $rc

# push branches

commit=`$GIT_PR rev-parse HEAD`

$GIT_PR push -f $dest_repo_name $branch
$GIT_PR push $dest_repo_name ${branch}:${branch}-${commit}


# create PR info
$GIT_PR checkout $dest_info_branch
[ $? != 0 ] && $GIT_PR branch $dest_info_branch

archive_dir="${dest_path}/pr/archive/${pr}/${commit}"
mkdir -p $archive_dir

desc_file=${archive_dir}/description
echo $msg > $desc_file


# commit and push PR info

$GIT_PR add $desc_file
$GIT_PR commit $desc_file -s -m "archive: PR #${pr} ($commit)"

$GIT_PR push $dest_repo_name $dest_info_branch
