def symlink_git_hooks
  `if [[ ! -L "./.git/hooks" && -d "./.git/hooks" ]]
  then
    echo -e  "\nHooks folder exists moving content into ./.git/hooks.old"
    mv "./.git/hooks" "./.git/hooks.old"
  fi`
  `if [[ ! -L "./.git/hooks" && -d "./hooks" ]]
  then
    echo -e "\nCreating symlink ./.git/hooks => hooks"
    ln -s "../hooks/" ".git/hooks"
  fi`
end