#look into fakefs more
#require 'fakefs/spec_helpers'
#
#
require 'spec_helper'
describe Dotman::Git do

  before :each do
    Dotman::Base.ensure_dotman_folder_exists
    Dotman::Base.ensure_default_folder_exists
    Dotman::Base.ensure_current_dotman_file_exists
  end

  describe ".clone_repository" do
    let (:git_dotfile_repo_path)    { "git@github.com:Timbinous/dotfiles.git" }
    let (:git_folder_name)          { Dotman::Git.folder_name(git_dotfile_repo_path) }

    context "when the git location is specified" do
      context "when the git repository has not been cloned yet" do
        context "when alias was passed" do

          it "clones to the $HOME/.dotman folder" do
            expect {
            Dotman::Git.clone_repository(git_dotfile_repo_path, 'tim') }.
            to change { File.directory?("#{ENV['HOME']}/.dotman/Timbinous_dotfiles") }.to true
          end

          it "sets the yaml configuration relating to the alias" do
            Dotman::DotfileCollection.find_by_alias('tim').should_not be_false
          end
        end

        context "when no alias passed" do

          it "clones to the $HOME/.dotman folder" do
            expect {
            Dotman::Git.clone_repository(git_dotfile_repo_path) }.
            to change { File.directory?("#{ENV['HOME']}/.dotman/Timbinous_dotfiles") }.to true
          end

          it "sets the yaml configuration relating to the \"git user name\"_\"repo name\"" do
            Dotman::DotfileCollection.find_by_alias(git_folder_name).should_not be_false
          end
        end
      end

      context "when the git repository has already been cloned" do
        before :each do
          Dotman::Git.clone_repository(git_dotfile_repo_path, 'tim')
        end

        it "sends a notification that this repository has already been cloned"do
          Dotman::Notification.should_receive(:already_cloned)
          Dotman::Git.clone_repository(git_dotfile_repo_path, 'tim')
        end
      end
    end
    
    context "when the git location was not specified" do
      it "sends an error notification to the user" do
        Dotman::Notification.should_receive(:unspecified_git_path)
        Dotman::Git.clone_repository(nil)
      end
    end
  end

  describe ".folder_name" do
    context "when containing a dotfiles repository name in github" do
      it "returns the username_dotfiles as the folder name" do
        Dotman::Git.folder_name('git@github.com:Timbinous/dotfiles.git').should == "Timbinous_dotfiles"
      end
    end

    context "when containing a random repository name in github" do
      it "returns the username_randomrepository as the folder name" do
        Dotman::Git.folder_name('git@github.com:Timbinous/random.git').should == "Timbinous_random"
      end
    end
  end
end
