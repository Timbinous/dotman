ENV['HOME'] = File.expand_path('../data/home', __FILE__)
require 'fileutils'
require_relative "../lib/dotman/version"
require_relative "../lib/dotman/base"
Dotman::Base.ensure_dotman_folder_exists
Dotman::Base.ensure_default_folder_exists
Dotman::Base.ensure_current_dotman_file_exists
require_relative "../lib/dotman/git"
require_relative "../lib/dotman/dotfile_collection"
require_relative "../lib/dotman/user"


RSpec.configure do |config|

  config.after(:all) do
    FileUtils.rm_rf(File.join(ENV['HOME'], '.dotman')) if File.directory? (File.join(ENV['HOME'], '.dotman'))
    FileUtils.rm(File.join(ENV['HOME'], '.bashrc')) if File.symlink? (File.join(ENV['HOME'], '.bashrc'))
    FileUtils.rm(File.join(ENV['HOME'], '.gitignore')) if File.symlink? (File.join(ENV['HOME'], '.gitignore'))
    FileUtils.rm(File.join(ENV['HOME'], '.tmux.conf')) if File.symlink? (File.join(ENV['HOME'], '.tmux.conf'))
    FileUtils.rm(File.join(ENV['HOME'], '.vim')) if File.symlink? (File.join(ENV['HOME'], '.vim'))
    FileUtils.rm(File.join(ENV['HOME'], '.vimrc')) if File.symlink? (File.join(ENV['HOME'], '.vimrc'))
    FileUtils.rm(File.join(ENV['HOME'], '.zshrc')) if File.symlink? (File.join(ENV['HOME'], '.zshrc'))
  end
end
