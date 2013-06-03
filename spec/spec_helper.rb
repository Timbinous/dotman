ENV['HOME'] = File.expand_path('../data/home', __FILE__)
require 'fileutils'
require_relative "../lib/dotman"

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
