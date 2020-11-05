class Movie < ActiveRecord::Base
  def self.with_director(name)
    Movie.where(director: name)
  end
end
