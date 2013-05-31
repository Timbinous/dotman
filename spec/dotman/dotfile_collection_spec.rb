require 'spec_helper'
describe Dotman::DotfileCollection do
  describe ".find_by_alias" do
    context "default folder doesnt exist" do
      it 'creates the default folder' do
        Dotman::DotfileCollection.find_by_alias('default')
      end
    end
  end
end
