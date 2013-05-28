module Dotman
  class Git
    def self.klone(git_location, alias_name = nil)
      unless git_location.nil?
        clone_repository(git_location, alias_name)
      end
    end

    def self.folder_name(git_location)
      folder_name = git_location.scan(/[^:]+[\/]?dotfile[s?]{1}/).first.gsub('/', '_')
    end

    def self.clone_repository(git_location, alias_name = nil)
      if (File.directory?("#{ENV['HOME']}/.dotman/#{folder_name(git_location)}"))
        STDOUT.puts("Dotfiles were already cloned")
      else
        system "git clone #{git_location} #{ENV['HOME']}/.dotman/#{folder_name(git_location)}"
        Dotman::DotfileCollection.new_configuration(folder_name(git_location), alias_name)
      end
    end
  end
end
