require 'spec_helper'
describe Dotman do
  context "dotman folder doesn't exist on the folder" do
    before :all do
      FileUtils.rm_rf("#{ENV['HOME']}/.dotman")
    end

    it "creates a new folder" do
      File.directory?("#{ENV['HOME']}/.dotman").should == false
      Dotman.ensure_dotman_folder_exists
      File.directory?("#{ENV['HOME']}/.dotman").should == true
    end

    after :each do
      FileUtils.rm_rf("#{ENV['HOME']}/.dotman")
    end

  end

end
