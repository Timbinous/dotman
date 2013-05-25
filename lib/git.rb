class Git
  def self.klone(git_location)
    # clone_repository(git_location)
  end

  def self.folder_name(git_location)
    folder_name = git_location.scan(/[^:]+[\/]?dotfile[s?]{1}/).first.gsub('/', '_')
  end

  def self.clone_repository(git_location)
    if (File.directory?("#{ENV['HOME']}/.dotman/#{folder_name(git_location)}"))
      STDOUT.puts("Dotfiles were already cloned")
    else
      system "git clone #{git_location} #{ENV['HOME']}/.dotman/#{folder_name(git_location)}"
    end
  end
end
