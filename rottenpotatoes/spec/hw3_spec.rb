require 'rails_helper'

RSpec.describe MoviesController, type: :controller do


    describe 'same director movies' do
        before :each do
            Movie.create!(:title => "Star Wars", :rating => "PG", :release_date => "1977-05-25", :director => "George Lucas")
            Movie.create!(:title => "Blade Runner ", :rating => "PG", :release_date => "1982-06-25", :director => "Ridley Scott")
            Movie.create!(:title => "Alien", :rating => "R", :release_date => "1979-05-25", :director => "")
            Movie.create!(:title => "THX-1138", :rating => "R", :release_date => "1971-03-11", :director => "George Lucas")
        end
        
        describe "GET 'show'" do
            it "should be successful" do
                mov = Movie.find_by_title("Alien")
                get :show, {:id => mov}
                response.should be_success
            end
    
            it "should find the right user" do
                mov = Movie.find_by_title("Alien")
                get :show, {:id => mov}
                assigns(:movie).should == mov
            end
        end

        it 'checks director for  Star Wars' do
            mov = Movie.find_by_title("Star Wars")
            get :search_director, {:id => mov}
            movi = Movie.where(director: "George Lucas")
            assigns(:movies).should == movi
        end

        it 'renders to same director movies template' do
            mov = Movie.find_by_title("THX-1138")
            get :search_director, {:id => mov}
            response.should render_template("search_director")
        end
        
        # it 'redirects to the index when a director is not present' do
        #     mov = Movie.find_by_title("Alien")
        #     get :search_director, {:id => mov}
        #     expect(flash[:notice]).to eq("\'#{mov.title}\' has no director info")
        #     expect(response).to redirect_to(root_url)
        # end
    end

    
end