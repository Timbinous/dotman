require 'spec_helper'
describe Dotman::User do
  describe ".current_user_alias" do
    before :all do
      File.open(Dotman::Base.current_dotman, 'w') { |f| f.write 'tim' }
    end

    it 'returns the alias of the current user' do
      Dotman::User.current_user_alias.should == 'tim'
    end
  end

  describe "#set_current_user" do
    let (:user)             { Dotman::User.new('frank') }

    before :all do
      Dotman::DotfileCollection.new_configuration('frankie_dotfiles', 'frank')
    end

    it 'writes to the .current file, the alias of the current user' do
      user.set_current_user
      Dotman::User.current_user_alias.should == 'frank'
    end
  end


  describe ".current" do

    it 'returns the current users information' do
      Dotman::User.current.folder_name.should == 'frankie_dotfiles'
    end
  end

  describe "#set" do

    before :each do
      Dotman::Git.clone_repository("git@github.com:Timbinous/dotfiles.git", 'tim')
      FileUtils.touch(["#{ENV['HOME']}/.vimrc", "#{ENV['HOME']}/.zshrc", "#{ENV['HOME']}/.bashrc"])
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

    after :each do
      FileUtils.rm_r("#{ENV['HOME']}/.dotman/dotfiles.yml")
      FileUtils.rm_rf("#{ENV['HOME']}/.dotman/Timbinous_dotfiles")
      $default_user.collection.all_dotfiles.each do |df|
        FileUtils.rm("#{ENV['HOME']}/.dotman/default/#{df}")
      end
    end
  end
end
