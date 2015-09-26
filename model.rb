require 'data_mapper'
require 'dm-validations'

DataMapper.setup(:default, 'sqlite:///users/moacir/Projects/observation-counter/db.db')

class Book
  include DataMapper::Resource

  property :id, Serial
  property :isbn, String
  property :author, String
  property :title, String
  property :year, Integer
  property :cover, Text
  property :link, Text
  property :first_page, Integer
  property :last_page, Integer

  has n, :observations

  validates_presence_of :isbn
end

class Observation
  include DataMapper::Resource

  property :id, Serial
  property :count, Integer
  property :page, Integer

  belongs_to :book

  validates_presence_of :book_id
  validates_presence_of :page
  validates_presence_of :count
end

# DataMapper.finalize # sets up the models for first time use.
DataMapper.auto_upgrade!
