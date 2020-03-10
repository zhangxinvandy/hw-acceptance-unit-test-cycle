require 'rails_helper'
require 'movie'
#class Movie 
describe Movie do
  describe '.find_similar_movies' do
       
    context 'director exists' do
      before :each do
            Movie.create( title: 'Catch me if you can', director: 'Steven Spielberg') 
            Movie.create( title: 'Seven', director: 'David Fincher') 
            Movie.create( title: "Schindler's List", director: 'Steven Spielberg') 
            Movie.create( title: "Stop")
            @movies = Movie.all
            @movie1 = @movies.where(title: 'Catch me if you can').take
            @movie2 = @movies.where(title: 'Seven').take
            @movie3 = @movies.where(title: "Schindler's List").take
            @movie4 = @movies.where(title: 'Stop').take
        end
      it 'finds similar movies correctly' do
        expect(Movie.samedirector(@movie1.director).pluck(:title)).to eql(["Catch me if you can","Schindler's List"])
        expect(Movie.samedirector(@movie1.director).pluck(:title)).to_not include(["Seven"])
        expect(Movie.samedirector(@movie2.director).pluck(:title)).to eql(["Seven"])
      end
    end
  end

  describe '.all_ratings' do
    it 'returns all ratings' do
      expect(Movie.all_ratings).to match(%w(G PG PG-13 NC-17 R))
    end
  end
end
#end