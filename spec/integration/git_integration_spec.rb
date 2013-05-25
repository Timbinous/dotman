#look into fakefs more
#require 'fakefs/spec_helpers'
#
#
require 'spec_helper'
describe Git do
  before :all do
    Dotman.ensure_dotman_folder_exists
    FileUtils.rm_rf("#{ENV['HOME']}/.dotman/Timbinous_dotfiles")
  end

  context "cloning a new repo" do
    before :each do
    end
    it "clones to the $HOME/.dotman folder" do
      expect {
      Git.clone_repository("git@github.com:Timbinous/dotfiles.git") }.
      to change { File.directory?("#{ENV['HOME']}/.dotman/Timbinous_dotfiles") }.to true
    end
  end

end
