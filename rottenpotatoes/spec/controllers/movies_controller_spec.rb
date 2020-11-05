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
     it "happy path" do
       get :search_directors, :id => 100
      expect(response).to render_template("search_directors")
     end
    it "sad path" do
       get :search_directors, :id => 102
      expect(response).to render_template("search_directors")
     end
   end
  
  describe "GET show" do
    it "renders the template" do
      get :show, :id => 1
      expect(response).to render_template("show")
    end
  end
end
