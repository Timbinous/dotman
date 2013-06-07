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

  context "cloning a new repo" do

    let (:git_dotfile_repo_path)    { "git@github.com:Timbinous/dotfiles.git" }
    let (:git_folder_name)          { Dotman::Git.folder_name(git_dotfile_repo_path) }

    context "when no alias passed" do

      it "clones to the $HOME/.dotman folder" do
        expect {
        Dotman::Git.clone_repository(git_dotfile_repo_path) }.
        to change { File.directory?("#{ENV['HOME']}/.dotman/Timbinous_dotfiles") }.to true
      end

      it "sets the yaml configuration" do
        Dotman::DotfileCollection.find_by_alias(git_folder_name).should_not be_false
      end

    end

    context "when alias was passed" do

      it "clones to the $HOME/.dotman folder" do
        expect {
        Dotman::Git.clone_repository(git_dotfile_repo_path, 'tim') }.
        to change { File.directory?("#{ENV['HOME']}/.dotman/Timbinous_dotfiles") }.to true
      end

      it "sets the yaml configuration" do
        Dotman::DotfileCollection.find_by_alias('tim').should_not be_false
      end

    end
  end
  

end
