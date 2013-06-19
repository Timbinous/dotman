require 'spec_helper'
describe Dotman::Base do

  describe ".ensure_dotman_folder_exists" do
    context "when `$HOME/dotman/` does not exist" do
      it "creates the dotman directory" do
        File.stub(:directory?).and_return(false)
        FileUtils.should_receive(:mkdir).with("#{ENV['HOME']}/.dotman")
        Dotman::Base.ensure_dotman_folder_exists
      end
    end

    context "when $HOME/dotman/ exists" do
      it "does nothing" do
        File.stub(:directory?).and_return(true)
        FileUtils.should_not_receive(:mkdir)
        Dotman::Base.ensure_dotman_folder_exists
      end
    end
  end

  describe ".ensure_default_folder_exists" do
    context "when `$HOME/default/` does not exist" do
      it "creates the dotman directory" do
        File.stub(:directory?).and_return(false)
        FileUtils.should_receive(:mkdir_p).with("#{ENV['HOME']}/.dotman/default")
        Dotman::Base.ensure_default_folder_exists
      end
    end

    context "when $HOME/default/ exists" do
      it "does nothing" do
        File.stub(:directory?).and_return(true)
        FileUtils.should_not_receive(:mkdir)
        Dotman::Base.ensure_default_folder_exists
      end
    end
  end

  describe ".ensure_current_dotman_file_exists" do
    context "when current dotman file does not exist" do
      it "creates the file" do
        File.stub(:exist?).and_return(false)
        File.should_receive(:open)
        Dotman::Base.ensure_current_dotman_file_exists
      end
    end

    context "when current dotman file exists" do
      it "does nothing" do
        File.stub(:exist?).and_return(true)
        File.should_not_receive(:open)
        Dotman::Base.ensure_current_dotman_file_exists
      end
    end
  end
end
