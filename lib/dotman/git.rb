module Dotman
  class Git
    def self.klone(git_location, alias_name = nil)
      unless git_location.nil?
        Dotman::Base.ensure_dotman_folder_exists
        Dotman::Base.ensure_default_folder_exists
        Dotman::Base.ensure_current_dotman_file_exists
        clone_repository(git_location, alias_name)
      end
    end

    def self.folder_name(git_location)
      folder_name = git_location.scan(/[^:]+[\/]?dotfile[s?]{1}/).first.gsub('/', '_')
    end

    def self.clone_repository(git_location, alias_name = nil)
      dotfile_location = "#{ENV['HOME']}/.dotman/#{folder_name(git_location)}"
      if (File.directory?(dotfile_location))
        STDOUT.puts("Dotfiles were already cloned")
      else
        system "git clone #{git_location} #{dotfile_location}"
        Dotman::DotfileCollection.new_configuration(folder_name(git_location), alias_name)
      end
    end
  end
end
