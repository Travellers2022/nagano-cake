class Admin::GenresController < ApplicationController
    def index
       @genre = Genre.new
       @genres = Genre.all
    end
    
    def create
       @gerne = Genre.new(genre.params)
        
    end
    
    def edit
    end
    
    def update
    end

end
