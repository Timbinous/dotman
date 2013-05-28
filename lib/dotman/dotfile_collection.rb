module Dotman

  DOTFILES_PATH = "#{ENV['HOME']}/.dotman/dotfiles.yml"
  DOTFILES = File.exist?(DOTFILES_PATH) ? YAML::load_file(DOTFILES_PATH) : Hash.new

  class DotfileCollection

    def self.find_by_alias(alias_name)
      df = DOTFILES.fetch(alias_name) if DOTFILES
    end

    def self.new_configuration(folder_name, alias_name = nil)
      alias_name = folder_name unless alias_name
      DOTFILES.store(alias_name, {
          'folder_name' => folder_name 
        }
      )
      save_dotfile_yaml
    end

    private

    def self.save_dotfile_yaml
      File.open(DOTFILES_PATH, 'w') { |f| f.write DOTFILES.to_yaml }
    end

  end
end
