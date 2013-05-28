require 'spec_helper'
describe Dotman::Base do
  let (:dotfiles_folder) { File.expand_path('../../data/dotfiles', __FILE__) }
  let!(:dotfiles)        {FileUtils.touch "#{dotfiles_folder}/.vimrc"; FileUtils.touch "#{dotfiles_folder}/.bashrc"; FileUtils.touch "#{dotfiles_folder}/.zshrc" }

  describe ".ensure_dotman_folder_exists" do
    context "when `$HOME.dotman/` does not exist" do
      it "creates the dotman directory" do
        File.stub(:directory?).and_return(false)
        FileUtils.should_receive(:mkdir).with("#{ENV['HOME']}/.dotman")
        Dotman::Base.ensure_dotman_folder_exists
      end
    end

    context "when $HOME.dotman/ exists" do
      it "does nothing" do
        File.stub(:directory?).and_return(true)
        FileUtils.should_not_receive(:mkdir)
        Dotman::Base.ensure_dotman_folder_exists
      end
    end
  end

  describe ".all_dotfiles" do
    context "when dotfiles exist for a location" do

      it "returns all the dotfiles" do
        Dotman::Base.all_dotfiles(dotfiles_folder).should include('.vimrc', '.bashrc', '.zshrc')
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
