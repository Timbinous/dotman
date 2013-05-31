module Dotman
  class Base

    def self.default_folder
      "#{ENV['HOME']}/.dotman/default"
    end

    def self.dotman_folder
      "#{ENV['HOME']}/.dotman"
    end

    def self.current_dotman
      File.join(ENV['HOME'], '.dotman', '.current')
    end

    def self.ensure_dotman_folder_exists
      unless File.directory?(dotman_folder)
        FileUtils.mkdir(dotman_folder)
      end
    end

    def self.ensure_default_folder_exists
      unless File.directory?(default_folder)
        FileUtils.mkdir_p(default_folder)
      end
    end

    def self.ensure_current_dotman_file_exists
      unless File.exist?(current_dotman)
        File.open(current_dotman, 'w') do |f|
          f.write('default')
        end
      end
    end

  end
end
