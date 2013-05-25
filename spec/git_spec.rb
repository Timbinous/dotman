require 'spec_helper'
describe Git do
  describe ".folder_name" do
    it "returns the folder name of the git repo" do
      Git.folder_name('git@github.com:Timbinous/dotfiles.git').should == "Timbinous_dotfiles"
    end
  end

end
