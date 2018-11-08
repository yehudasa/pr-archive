
# defaults

source_repo_name="origin"
dest_repo_name="pra"
dest_info_branch="archive-info"

# read config

source .config

[ "$dest_path" == "" ] && echo ".config: missing dest_path" && exit 1

GIT_PR="git -C $dest_path"
HUB_PR="hub -C $dest_path"

if [ ! -d "$dest_path" ]; then
  [ "$source_repo" == "" ] && echo ".config: source_repo is not specified" && exit 1
  [ "$dest_repo" == "" ] && echo ".config: dest_repo is not specified" && exit 1
  git clone --origin $source_repo_name $source_repo $dest_path
fi

$GIT_PR remote get-url $dest_repo_name > /dev/null 2>&1
[ $? != 0 ] && $GIT_PR remote add $dest_repo_name $dest_repo

