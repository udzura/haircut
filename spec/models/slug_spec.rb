require File.expand_path(File.dirname(__FILE__) + '/../spec_helper.rb')

describe "Slug Model" do
  let(:slug) { Slug.new }
  it 'can be created' do
    slug.should_not be_nil
  end
end
