module Dotman
  class AfterClone
    def self.run(after_clone_path)
      full_path = File.join(after_clone_path, '.dotman.after_clone')
      if File.exist?(full_path)
        system full_path
      end
    end
  end
end
