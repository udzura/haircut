require File.expand_path(File.dirname(__FILE__) + '/../spec_helper.rb')

describe "Access Model" do
  let(:access) { Access.new }
  it 'can be created' do
    access.should_not be_nil
  end
end
