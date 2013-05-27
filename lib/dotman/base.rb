module Dotman
  class Base

    def self.move_home_files_to_default(folder)
      ensure_default_folder_exists
      ensure_dotman_folder_exists
      all_dotfiles(folder).each do |file|
        FileUtils.mv("#{folder}/#{file}", default_folder)
      end
    end

    def self.default_folder
      "#{ENV['HOME']}/.dotman/default"
    end

    def self.dotman_folder
      "#{ENV['HOME']}/.dotman"
    end

    def self.all_dotfiles(folder)
      Dir.entries(folder).select{|x| x =~ /\.{1}\w+/ }
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

  end
end
