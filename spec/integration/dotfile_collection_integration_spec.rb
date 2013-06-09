require 'spec_helper'
describe Dotman::DotfileCollection do
  before :each do
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

  describe ".all_aliases" do
    context "when an alias exists in the collection" do
      it "lists the alias" do
        Dotman::DotfileCollection.all_aliases.should include('tim')
      end
    end
  end

  describe ".show_all_aliases" do
    context "when aliases exist in the collection" do
      it "shows all the aliases" do
        STDOUT.should_receive(:puts).with("default\ntim")
        Dotman::DotfileCollection.show_all_aliases
      end
    end
  end
end
