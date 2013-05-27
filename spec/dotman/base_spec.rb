require 'spec_helper'
describe Dotman::Base do
  let (:dotfiles_folder) { File.expand_path('../../data/dotfiles', __FILE__) }
  describe ".all_dotfiles" do
    context "when dotfiles exist for a location" do

      it "returns all the dotfiles" do
        Dotman::Base.all_dotfiles(dotfiles_folder).should include('.vimrc', '.bashrc', '.zshrc', '.bash_profile')
      end

      it "should not contain . or .." do
        Dotman::Base.all_dotfiles(dotfiles_folder).should_not include('..', '.')
      end

      it "does not contain non dotfiles" do
        Dotman::Base.all_dotfiles(dotfiles_folder).should_not include('some_nondot_file')
      end

    end
  end

  describe ".move_home_files_to_default" do
    context "when having dotfiles in project" do
      it "moves the files" do
        Dotman::Base.move_home_files_to_default(dotfiles_folder)
        Dir.entries(Dotman::Base.default_folder).should include('.vimrc', '.bashrc', '.zshrc')
      end
    end
  end

end
