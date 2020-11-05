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

RSpec.describe MoviesController do
  
  before do
      @movie100 = Movie.create(:id => 100, :title => "movie100", :director => "blah director")
      @movie101 = Movie.create(:id => 101, :title => "movie101", :director => "blah director")
      @movie102 = Movie.create(:id => 102, :title => "movie102")
    end
  
  describe "GET search_directors" do
     it "renders the search_directors template" do
       get :search_directors, :id => 1
      expect(response).to render_template("search_directors")
     end
    it "search_directors happy path" do
       get :search_directors, :id => 100
      expect(response).to render_template("search_directors")
     end
   end
end
