require 'spec_helper'
describe AfterClone do
  let (:git_dotfile_repo_path)    { "git@github.com:Timbinous/dotfiles.git" }
  before :each do
    Dotman::Git.clone_repository(git_dotfile_repo_path, 'tim')
  end

  describe ".run" do
    context "when .dotman.after_clone file exists" do
      let(:dotman_after_clone) { FileUtils.touch(File.join(timbinous_dotfiles, '.dotman.after_clone'))}
      it "executes the script" do
      end
    end
  end
end
