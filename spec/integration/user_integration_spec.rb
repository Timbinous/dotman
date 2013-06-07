require 'spec_helper'
describe Dotman::User do
  let (:tim)                 { Dotman::User.new('tim') }

  describe ".current_user_alias" do
    before :all do
      Dotman::Base.ensure_dotman_folder_exists
      File.open(Dotman::Base.current_dotman, 'w') { |f| f.write 'tim' }
    end

    it 'returns the alias of the current user' do
      Dotman::User.current_user_alias.should == 'tim'
    end
  end

  describe "#set_current_user" do
    before :each do
      Dotman::Base.ensure_dotman_folder_exists
      Dotman::Git.clone_repository("git@github.com:Timbinous/dotfiles.git", 'tim')
    end

    it 'writes to the .current file, the alias of the current user' do
      tim.set_current_user
      Dotman::User.current_user_alias.should == 'tim'
    end
  end


  describe ".current" do
    before :each do
      Dotman::Base.ensure_dotman_folder_exists
      Dotman::Git.clone_repository("git@github.com:Timbinous/dotfiles.git", 'tim')
    end

    it 'returns the current users information' do
      tim.set_current_user
      Dotman::User.current.folder_name.should == 'Timbinous_dotfiles'
    end
  end

  describe "#set" do

    before :each do
      Dotman::Base.ensure_dotman_folder_exists
      Dotman::Git.clone_repository("git@github.com:Timbinous/dotfiles.git", 'tim')
      $default_user.set_current_user
      FileUtils.touch(["#{ENV['HOME']}/.vimrc", "#{ENV['HOME']}/.zshrc", "#{ENV['HOME']}/.bashrc"])
      FileUtils.mkdir("#{ENV['HOME']}/.dotman/default")
      Dotman::User.set('tim')
    end

    context "when not the current user" do
      it "moves the default dotfiles over to the default folder" do
        $default_user.collection.all_dotfiles.should_not be_empty
      end

      it "symlinks your dotfiles to the home directory" do
        File.symlink?(File.join(ENV['HOME'], '.zshrc')).should be_true
        File.symlink?(File.join(ENV['HOME'], '.vimrc')).should be_true
        File.symlink?(File.join(ENV['HOME'], '.bashrc')).should be_true
      end
    end

  end
end
