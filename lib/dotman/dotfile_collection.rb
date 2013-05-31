module Dotman

DOTFILES_PATH = "#{ENV['HOME']}/.dotman/dotfiles.yml"
DOTFILES_YAML = File.exist?(DOTFILES_PATH) ? YAML::load_file(DOTFILES_PATH) : Hash.new

  class DotfileCollection

    attr_accessor :yaml

    def self.find_by_alias(alias_name)
      dotfile_collection = new
      ensure_default_dotfile_configuration_exists
      dotfile_collection.yaml = DOTFILES_YAML.fetch(alias_name) if DOTFILES_YAML
      dotfile_collection
    end

    def self.new_configuration(folder_name, alias_name = nil)
      dotfile_collection = new
      alias_name = folder_name unless alias_name
      DOTFILES_YAML.store(alias_name, {
          'folder_name' => folder_name 
        }
      )
      save_dotfile_yaml
      dotfile_collection.yaml = DOTFILES_YAML
      dotfile_collection
    end


    def all_dotfiles
      Dir.entries("#{Dotman::Base.dotman_folder}/#{@yaml['folder_name']}").select{|x| x =~ /\.{1}\w+/ }
    end

    private

    def self.ensure_default_dotfile_configuration_exists
      unless DOTFILES_YAML && DOTFILES_YAML['default']
        new_configuration('default')
      end
    end

    def self.save_dotfile_yaml
      File.open(DOTFILES_PATH, 'w') { |f| f.write DOTFILES_YAML.to_yaml }
    end

  end
end
