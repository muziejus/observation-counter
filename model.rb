require 'data_mapper'
require 'dm-validations'
require './stat'

# DATABASE_URL is set by running: heroku config:set DATABASE_URL="<as in web client>"
DataMapper.setup(:default, ENV['DATABASE_URL'] || "sqlite://#{Dir.pwd}/db.db")

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

  def total_pages
    self.last_page - self.first_page
  end

  def count_array
    if self.observations.length == 0
      [0, 0]
    else
      self.observations.map{ |observation| observation[:count] }
    end
  end

  def count_per_page
    if self.count_array == [0, 0]
      "Sample pending"
    else
      "#{self.count_array.mean} ± #{self.count_confidence_interval}"
    end
  end

  def count_confidence_interval
    (2.093*(self.count_array.standard_deviation/Math.sqrt(20))).round(3)
  end

  def totals
    if self.count_confidence_interval == 0
      interval = 1
    else
      interval = self.count_confidence_interval * self.total_pages
    end
    { pages: self.total_pages, counts: self.total_pages * self.count_array.mean, interval: interval }
  end


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
