require_relative '../model'

RSpec.describe Book do
  it { should have_property :isbn }
  it { should have_property :title }
  it { should have_property :author }
  it { should have_property :cover }
  it { should have_property :first_page }
  it { should have_property :last_page }
  it { should validate_presence_of :isbn }
  it { should have_many :observations }
end

RSpec.describe Observation do
  it { should belong_to :book }
  it { should have_property :page }
  it { should have_property :count }
  it { should validate_presence_of :book_id }
  it { should validate_presence_of :page }
  it { should validate_presence_of :count }
end
