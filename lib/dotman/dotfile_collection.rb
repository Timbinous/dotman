module Dotman

DOTFILES_PATH = "#{ENV['HOME']}/.dotman/dotfiles.yml"

  class DotfileCollection

    def initialize(yaml)
      @yaml = yaml
    end

    attr_accessor :yaml

    def self.dotfiles_yaml
      @dotfiles_yaml ||= File.exist?(DOTFILES_PATH) ? YAML::load_file(DOTFILES_PATH) : Hash.new
    end

    def self.find_by_alias(alias_name)
      ensure_default_dotfile_configuration_exists
      new(dotfiles_yaml.fetch(alias_name))
    end

    def self.new_configuration(folder_name, alias_name = nil)
      alias_name = folder_name unless alias_name
      dotfiles_yaml.store(alias_name, {
          'folder_name' => folder_name 
        })
      save_dotfile_yaml
    end
    
    def self.all_aliases
      ensure_default_dotfile_configuration_exists
      dotfiles_yaml.collect {|dfy| dfy.first }
    end

    def self.show_all_aliases
      STDOUT.puts all_aliases.join("\n")
    end

    def self.change_alias(old_alias, new_alias)
      dotfiles_yaml[new_alias] = dotfiles_yaml[old_alias]
      dotfiles_yaml.delete(old_alias)
      if Dotman::User.current_user_alias == old_alias
        Dotman::User.set_current_user(new_alias)
      end
      save_dotfile_yaml
    end

    def all_dotfiles
      Dir.entries("#{Dotman::Base.dotman_folder}/#{@yaml['folder_name']}").select{|x| x =~ /\.{1}\w+[^git]/ }
    end

    private

    def self.ensure_default_dotfile_configuration_exists
      unless dotfiles_yaml && dotfiles_yaml['default']
        new_configuration('default')
      end
    end

    def self.save_dotfile_yaml
      File.open(DOTFILES_PATH, 'w') { |f| f.write dotfiles_yaml.to_yaml }
    end

  end
end
