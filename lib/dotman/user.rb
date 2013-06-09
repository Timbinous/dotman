module Dotman
  class User
    def initialize(shortcut)
      @alias = shortcut
      @collection = Dotman::DotfileCollection.find_by_alias(shortcut)
      @folder_name = @collection.yaml['folder_name']
    end

    attr_reader :alias, :folder_name, :collection

    def move_home_files_to_default
      @collection.all_dotfiles.each do |file|
        if File.exist?("#{ENV['HOME']}/#{file}")
          FileUtils.mv("#{ENV['HOME']}/#{file}", Dotman::Base.default_folder)
        end
      end
    end

    def self.move_default_back_to_home
      $default_user.collection.all_dotfiles.each do |file|
        FileUtils.mv(Dotman::Base.default_folder + '/' + file, ENV['HOME'] )
      end
    end

    def symlink_dotfiles
      @collection.all_dotfiles.each do |file|
        FileUtils.ln_s(File.join(Dotman::Base.dotman_folder, @folder_name, file), File.join(ENV['HOME'], file))
      end
    end

    def remove_symlink_dotfiles
      @collection.all_dotfiles.each do |file|
        if File.symlink?(File.join(ENV['HOME'], file))
          FileUtils.rm(File.join(ENV['HOME'], file))
        end
      end
    end

    def self.set(shortcut)
      current.remove_symlink_dotfiles
      move_default_back_to_home
      set_user = new(shortcut)
      set_user.move_home_files_to_default
      set_user.symlink_dotfiles
      set_user.set_current_user
    end



    def self.current
      new(current_user_alias)
    end

    def set_current_user
      File.open(Dotman::Base.current_dotman, 'w') do |f|
        f.write(@alias)
      end
    end

    def self.set_current_user(alias_name)
      File.open(Dotman::Base.current_dotman, 'w') do |f|
        f.write(alias_name)
      end
    end


    def self.current_user_alias
      File.open(Dotman::Base.current_dotman).read.strip
    end

    $default_user = new('default')

  end
end
