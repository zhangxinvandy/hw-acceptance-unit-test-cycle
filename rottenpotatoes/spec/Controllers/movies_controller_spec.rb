require 'rails_helper'

RSpec.describe MoviesController, type: :controller do

    context "Similar Movies" do
          before :each do
            Movie.create(title: 'Star Wars', rating: 'PG', director: 'George Lucas', release_date: Date.new(1977,5,25))
            Movie.create(title: 'Blade Runner', rating: 'PG', release_date: Date.new(1982,6,25))
            Movie.create(title: 'THX-1138', rating: 'R', director: 'George Lucas', release_date: Date.new(1971,3,11))
    
            @movies = Movie.all
          end
    
          it "Should be redirect to the home page with an error when can't find similar movies" do
            movie = @movies.where(title: 'Blade Runner').take
            get :similar, id: movie.id , controller: "movies"
            expect(response).to redirect_to movies_path
            expect(flash[:notice]).to eq("'#{movie.title}' has no director info")
          end
          it 'should call Movie.similar_movies' do
            expect(Movie).to receive(:samedirector).with("George Lucas")
            get :similar, {id: 1}
          end
          it 'should assign similar movies if director exists' do
            movies = ['Star Wars', 'THX-1138']
            Movie.stub(:samedirector).with('George Lucas').and_return(movies)
            get :similar, { id: 1 }
            expect(assigns(:movies)).to eq(movies)
          end
    end

  describe 'GET index' do
    # let!(:movie) {FactoryGirl.create(:movie)}
  
    it 'should render the index template' do
      get :index
      expect(response).to render_template('index')
    end
  
    it 'should assign instance variable for title header' do
      get :index, { sort: 'title'}
      expect(assigns(:title_header)).to eql('hilite')
    end
  
    it 'should assign instance variable for release_date header' do
      get :index, { sort: 'release_date'}
      expect(assigns(:date_header)).to eql('hilite')
    end
  end
  
  describe 'GET new' do
    # let!(:movie) { Movie.new }
  
    it 'should render the new template' do
      get :new
      expect(response).to render_template('new')
    end
  end
  
  describe 'POST #create' do
    it 'creates a new movie' do
      expect {post :create, movie: {title: 'THX-1138', rating: 'R', director: 'George Lucas', release_date: Date.new(1971,3,11)}
      }.to change { Movie.count }.by(1)
    end
  
    it 'redirects to the movie index page' do
      post :create, movie: {title: 'THX-1138', rating: 'R', director: 'George Lucas', release_date: Date.new(1971,3,11)}
      expect(response).to redirect_to(movies_url)
    end
  end
  
  describe 'GET #show' do
    let(:movie1) { Movie.create(title: 'THX-1138', rating: 'R', director: 'George Lucas', release_date: Date.new(1971,3,11))}
    before(:each) do
      # Movie.create(title: 'THX-1138', rating: 'R', director: 'George Lucas', release_date: Date.new(1971,3,11))
      get :show, id: movie1.id
    end
  
    it 'should find the movie' do
      expect(movie1.title).to eql('THX-1138')
    end
  
    it 'should render the show template' do
      expect(response).to render_template('show')
    end
  end
  
  describe 'GET #edit' do
    let(:movie1) { Movie.create(title: 'THX-1138', rating: 'R', director: 'George Lucas', release_date: Date.new(1971,3,11))}
    before do
      # Movie.create(title: 'THX-1138', rating: 'R', director: 'George Lucas', release_date: Date.new(1971,3,11))
      get :edit, id: 1
    end
  end
  
  describe 'PUT #update' do
    let(:movie1) { Movie.create(title: 'THX-1138', rating: 'R', director: 'George Lucas', release_date: Date.new(1971,3,11))}
    before(:each) do
      put :update, id: movie1.id, movie: {title: 'Star Wars', rating: 'PG', director: 'George Lucas', release_date: Date.new(1977,5,25)}
    end
  
    it 'updates an existing movie' do
      movie1.reload
      expect(movie1.title).to eql('Star Wars')
    end
  
    it 'redirects to the movie page' do
      expect(response).to redirect_to(movie_path(movie1))
    end
  end
  
  describe 'DELETE #destroy' do
    let(:movie1) { Movie.create(title: 'THX-1138', rating: 'R', director: 'George Lucas', release_date: Date.new(1971,3,11))}
    let(:movie2) { Movie.create(title: 'Star Wars', rating: 'PG', director: 'George Lucas', release_date: Date.new(1977,5,25))}
  
    it 'redirects to movies#index after destroy' do
      delete :destroy, id: movie1.id
      expect(response).to redirect_to(movies_path)
    end
end
end