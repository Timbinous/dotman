require 'spec_helper'
describe Dotman::DotfileCollection do
  before :each do
    Dotman::Base.ensure_dotman_folder_exists
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
        Dotman::Notification.display_all_aliases
      end
    end
  end

  describe ".change_alias" do
    context "when alias exists" do
      it "adds the alias to the desired new alias name" do
        Dotman::Base.ensure_current_dotman_file_exists
        Dotman::DotfileCollection.change_alias('tim', 'frank')
        YAML::load_file("#{ENV['HOME']}/.dotman/dotfiles.yml").should include('frank')
      end

      it 'removes the old alias from the yaml file' do
        Dotman::Base.ensure_current_dotman_file_exists
        Dotman::DotfileCollection.change_alias('tim', 'frank')
        YAML::load_file("#{ENV['HOME']}/.dotman/dotfiles.yml").should_not include('tim')
      end

      context "current user is set to changing alias" do
        it 'sets the current alias to the new name' do
          File.open(Dotman::Base.current_dotman, 'w') { |f| f.write('tim') }
          Dotman::User.current_user_alias.should == 'tim'
          Dotman::DotfileCollection.change_alias('tim', 'frank')
          Dotman::User.current_user_alias.should == 'frank'
        end
      end

      context "current user is not set to changing alias" do
        it 'does not set the current alias to the new name' do
          File.open(Dotman::Base.current_dotman, 'w') { |f| f.write('default') }
          Dotman::User.current_user_alias.should == 'default'
          Dotman::DotfileCollection.change_alias('tim', 'frank')
          Dotman::User.current_user_alias.should == 'default'
        end
      end
    end
  end
end
