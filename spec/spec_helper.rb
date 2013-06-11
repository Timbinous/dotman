ENV['HOME'] = File.expand_path('../data/home', __FILE__)
require 'fakefs/spec_helpers'
require_relative "../lib/dotman"

def create_home_directory
  FileUtils.mkdir_p(ENV['HOME']) unless File.directory?(ENV['HOME'])
end

def create_timbinous_dotfiles
  timbinous_path = File.join(ENV['HOME'], '../', 'Timbinous_dotfiles')
  FileUtils.mkdir_p(timbinous_path) unless File.directory?(timbinous_path)
  FileUtils.mkdir_p(timbinous_path, '.vim')
  FileUtils.touch(File.join(timbinous_path, '.vimrc'))
  FileUtils.touch(File.join(timbinous_path, '.bashrc'))
  FileUtils.touch(File.join(timbinous_path, '.tmux.conf'))
  FileUtils.touch(File.join(timbinous_path, '.vimrc'))
  FileUtils.touch(File.join(timbinous_path, '.zshrc'))
  FileUtils.touch(File.join(timbinous_path, '.tim.zsh-theme'))
end

RSpec.configure do |config|

  config.include FakeFS::SpecHelpers

  config.before(:all) do
  end

  config.before(:each) do
    create_home_directory
    create_timbinous_dotfiles
    Dotman::Git.stub(:system) do |arg|
      if arg == "git clone git@github.com:Timbinous/dotfiles.git /home/tim/source/dotman/spec/data/home/.dotman/Timbinous_dotfiles"
        FileUtils.cp_r(File.expand_path('../data/Timbinous_dotfiles', __FILE__), File.join(ENV['HOME'], '.dotman'))
      end
    end
  end


  config.after(:each) do
    FileUtils.rm_rf(File.join(ENV['HOME'], '.dotman')) if File.directory? (File.join(ENV['HOME'], '.dotman'))
    FileUtils.rm_rf(File.join(ENV['HOME'], 'dotfiles')) if File.directory? (File.join(ENV['HOME'], 'dotfiles'))
    FileUtils.rm(File.join(ENV['HOME'], '.bashrc')) if File.symlink? (File.join(ENV['HOME'], '.bashrc'))
    FileUtils.rm(File.join(ENV['HOME'], '.gitignore')) if File.symlink? (File.join(ENV['HOME'], '.gitignore'))
    FileUtils.rm(File.join(ENV['HOME'], '.tmux.conf')) if File.symlink? (File.join(ENV['HOME'], '.tmux.conf'))
    FileUtils.rm(File.join(ENV['HOME'], '.vim')) if File.symlink? (File.join(ENV['HOME'], '.vim'))
    FileUtils.rm(File.join(ENV['HOME'], '.vimrc')) if File.symlink? (File.join(ENV['HOME'], '.vimrc'))
    FileUtils.rm(File.join(ENV['HOME'], '.zshrc')) if File.symlink? (File.join(ENV['HOME'], '.zshrc'))
    FileUtils.rm(File.join(ENV['HOME'], 'tim.zsh-theme')) if File.symlink? (File.join(ENV['HOME'], 'tim.zsh-theme'))
  end
end
