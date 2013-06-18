require 'spec_helper'
describe Dotman::Base do
  describe ".ensure_dotman_folder_exists" do
    before :all do
      FileUtils.rm_rf("#{ENV['HOME']}/.dotman")
    end

    context "when .dotman folder doesn't exist in the home directory" do

      it "creates a new folder" do
        File.directory?("#{ENV['HOME']}/.dotman").should == false
        Dotman::Base.ensure_dotman_folder_exists
        File.directory?("#{ENV['HOME']}/.dotman").should == true
      end
    end

    after :each do
      FileUtils.rm_rf("#{ENV['HOME']}/.dotman")
    end
  end
end
