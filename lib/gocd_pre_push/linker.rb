require_relative 'pretty_printer'

module GOCD_PRE_PUSH
  class Linker
    include GOCD_PRE_PUSH::PrettyPrinter

    def symlink_git_hooks
      return unless File.exists?('./hooks')

      print_info "Creating symlink ./.git/hooks => hooks"
      print_info "Your old hooks will be saved inside ./.git/hooks.old\n"

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
  end
end