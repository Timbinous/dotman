require 'spec_helper'
describe Dotman::DotfileCollection do
  describe ".find_by_alias" do
    context "default folder doesnt exist" do
      it 'creates the default folder' do
        Dotman::DotfileCollection.find_by_alias('default')
      end
    end
  end

  describe ".all_dotfiles" do
    let (:dotfile_collection)      { Dotman::DotfileCollection.new(Hash.new) }

    before :each do
      Dir.stub(:entries).and_return(['some_nondot_file', '.gitignore', '.gitconfig', '.vimrc', '.bashrc', '.zshrc', '..', '.', '.git'])
    end

    context "when dotfiles exist for a location" do
      it "returns all the dotfiles" do
        dotfile_collection.all_dotfiles.should include('.vimrc', '.bashrc', '.zshrc')
      end

      it "should not contain . or .." do
        dotfile_collection.all_dotfiles.should_not include('..', '.')
      end

      it "does not contain non dotfiles" do
        dotfile_collection.all_dotfiles.should_not include('some_nondot_file')
      end

      it 'excludes .git' do
        dotfile_collection.all_dotfiles.should_not include('.git')
      end

      it 'includes .gitignore' do
        dotfile_collection.all_dotfiles.should include('.gitignore')
      end
    end
  end
end
