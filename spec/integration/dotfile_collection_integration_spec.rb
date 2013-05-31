require 'spec_helper'
describe Dotman::DotfileCollection do
  before :all do
    Dotman::Git.clone_repository('git@github.com:Timbinous/dotfiles.git', 'tim')
  end

  describe ".find_by_alias" do
    context "when dotfile collection is found" do
      let (:alias_name)                 { 'tim' }
      let (:dotfile_collection_name)    { 'Timbinous_dotfiles' }
      let! (:dotfile_configuration)     { Dotman::DotfileCollection.new_configuration(dotfile_collection_name, alias_name) }
      it "returns the dotfile collection" do
        Dotman::DotfileCollection.find_by_alias(alias_name).should be_an_instance_of(Dotman::DotfileCollection)
      end
    end
  end
  after :all do
    FileUtils.rm_r("#{ENV['HOME']}/.dotman/dotfiles.yml")
    FileUtils.rm_rf("#{ENV['HOME']}/.dotman/Timbinous_dotfiles")
  end
end
