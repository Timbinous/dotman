require 'spec_helper'
describe Dotman do
  describe "::ensure_dotman_folder_exists" do
    context "$HOME.dotman/ does not exist" do
      it "creates the dotman directory" do
        File.stub(:directory?).and_return(true)
        FileUtils.should_receive(:mkdir).with("$HOME/.dotman")
        Dotman.ensure_dotman_folder_exists
      end
    end

    context "$HOME.dotman/ already exists" do
      it "does nothing" do
        File.stub(:directory?).and_return(false)
        FileUtils.should_not_receive(:mkdir).with("$HOME/.dotman")
        Dotman.ensure_dotman_folder_exists
      end
    end
  end
end
