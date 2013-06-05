module Dotman
  class Collect

    def initialize
      create_dotman    
    end

    def create_dotman
      if !File.directory?("#{ENV['HOME']}/.dotman")
        puts "creating..."
        #FileUtils.mv("#{ENV['HOME']}/#{file}", Dotman::Base.default_folder)
      end

    end

  end
end
