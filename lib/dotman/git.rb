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
      folder_name = git_location.scan(/[^:]+[\/]{1}[a-zA-Z0-9]+/).first.gsub('/', '_')
    end

    def self.clone_repository(git_location, alias_name = nil)
      if git_location && !git_location.strip.empty?
        dotfile_location = "#{ENV['HOME']}/.dotman/#{folder_name(git_location)}"
      else
        return Dotman::Notification.unspecified_git_path
      end

      if (File.directory?(dotfile_location))
        Dotman::Notification.already_cloned
      else
        system "git clone #{git_location} #{dotfile_location}"
        Dotman::DotfileCollection.new_configuration(folder_name(git_location), alias_name)
        Dotman::AfterClone.run(dotfile_location)
      end
    end
  end
end
