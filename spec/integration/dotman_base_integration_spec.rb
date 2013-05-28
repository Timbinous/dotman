require 'spec_helper'
describe Dotman::Base do
  context "when .dotman folder doesn't exist in the home directory" do
    before :all do
      FileUtils.rm_rf("#{ENV['HOME']}/.dotman")
    end

    it "creates a new folder" do
      File.directory?("#{ENV['HOME']}/.dotman").should == false
      Dotman::Base.ensure_dotman_folder_exists
      File.directory?("#{ENV['HOME']}/.dotman").should == true
    end

    after :each do
      FileUtils.rm_rf("#{ENV['HOME']}/.dotman")
    end

  end

end
