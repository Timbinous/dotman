require 'spec_helper'
describe Dotman::AfterClone do
  let (:git_dotfile_repo_path)    { "git@github.com:Timbinous/dotfiles.git" }
      let(:dotman_after_clone) { }
  before :each do
    Dotman::Git.clone_repository(git_dotfile_repo_path, 'tim')
  end

  describe ".run" do
    context "when .dotman.after_clone file exists" do
      it "executes the script" do
        Dotman::Git.clone_repository(git_dotfile_repo_path, 'tim')
        FileUtils.touch(File.join(timbinous_dotfiles, '.dotman.after_clone'))
        Dotman::AfterClone.should_receive(:system).with(File.join(timbinous_dotfiles, '.dotman.after_clone'))
        Dotman::AfterClone.run(timbinous_dotfiles)
      end
    end
  end
end
