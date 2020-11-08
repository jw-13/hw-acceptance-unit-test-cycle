require 'rails_helper'

if RUBY_VERSION>='2.6.0'
  if Rails.version < '5'
    class ActionController::TestResponse < ActionDispatch::TestResponse
      def recycle!
        # hack to avoid MonitorMixin double-initialize error:
        @mon_mutex_owner_object_id = nil
        @mon_mutex = nil
        initialize
      end
    end
  else
    puts "Monkeypatch for ActionController::TestResponse no longer needed"
  end
end

RSpec.describe Movie, type: :model do
  
  before do
      @movie100 = Movie.create(:id => 100, :title => "movie100", :director => "blah director")
      @movie101 = Movie.create(:id => 101, :title => "movie101", :director => "blah director")
      @movie102 = Movie.create(:id => 102, :title => "movie102")
  end
  
  describe "find with director (class method)" do
     it "finds similar movies" do
       @movies = Movie.find_with_director("blah director")
       assert_includes(@movies, @movie100)
       assert_includes(@movies, @movie101)
     end
    it "movie without similar movies" do
       movies = Movie.find_with_director("blah director")
       assert (not movies.include? @movie102)
     end
   end
end