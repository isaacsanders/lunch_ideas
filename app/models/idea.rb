require 'data_mapper'
require 'dm-timestamps'

class Idea
  include DataMapper::Resource

  property :id, Serial
  property :name, String
  property :cuisine, String
  property :popularity, Integer
  property :updated_on, Date
end

