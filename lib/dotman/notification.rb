module Dotman
  class Notification
    def self.show_help
    STDOUT.puts "USAGE:
      dot clone <git_repository> <alias> : clone the dotfiles repo
      dot use <alias> : use the dotfiles
      dot list : lists all downloaded dotfile aliases
      dot use default : switch to the default dot files
      dot delete <alias> : delete dotfile collection
      dot collect : collects all dot files within a directory called dotfiles
      dot alias rename <old alias> <new alias> : changes alias from old to new
      dot alias list : same as dot list"
    end

    def self.already_cloned
      STDOUT.puts "Dotfiles were already cloned"
    end

    def self.collecting
      STDOUT.puts "collecting..."
    end

    def self.copying_to_dotfiles(file)
      STDOUT.puts "copied #{file} to dotfiles"
    end

    def self.display_all_aliases
      STDOUT.puts Dotman::DotfileCollection.all_aliases.join("\n")
    end

    def self.dotfile_collection_not_found(alias_name)
      STDOUT.puts "Dotfile collection not found for #{alias_name}"
    end
  end
end
