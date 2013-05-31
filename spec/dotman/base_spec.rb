require 'spec_helper'
describe Dotman::Base do

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
end
