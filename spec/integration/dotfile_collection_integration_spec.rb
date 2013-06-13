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
        File.directory?(File.join(Dotman::Base.dotman_folder, 'Timbinous_dotfiles')).should be_true
      end
    end
  end

  describe ".delete" do
    before :each do
      Dotman::Git.clone_repository('git@github.com:Timbinous/dotfiles.git', 'tim')
    end

    context "when dotfile exists" do
      it "deletes the dotfile folder" do
        Dotman::DotfileCollection.delete('tim')
        File.directory?(File.join(Dotman::Base.dotman_folder, 'Timbinous_dotfiles')).should be_false
      end

      it "removes the alias from the yaml file" do
        Dotman::DotfileCollection.delete('tim')
        YAML::load_file(Dotman::DOTFILES_PATH).should_not include('tim')
      end

      context "when dotfile doesn't exist" do
        it "warns you that the alias was not found to delete" do
          Dotman::Notification.should_receive(:dotfile_collection_not_found).with('bob')
          Dotman::DotfileCollection.delete('bob')
        end
      end

    end
  end
end
