module Dotman
  class Collect

    def create_dotman
      if !File.directory?("#{ENV['HOME']}/dotfiles")
        FileUtils.mkdir("#{ENV['HOME']}/dotfiles")
      end
      collect_dotfiles
    end

    def collect_dotfiles
      puts "collecting..."
      Dir.entries("#{ENV['HOME']}").each do |file|
        if file =~ /^.{1}[a-zA-Z1-9]+\z/
          copy_over_dot file
        end
      end
    end

    def copy_over_dot file
      if !File.directory?("#{ENV['HOME']}/#{file}")
        puts "copying #{file} to dotfiles"
        FileUtils.copy "#{ENV['HOME']}/#{file}", "#{ENV['HOME']}/dotfiles"  
      end
    end
  end
end
