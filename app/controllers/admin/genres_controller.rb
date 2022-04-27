class Admin::GenresController < ApplicationController

  def new
    @genre = Genre.new
  end

  def create
    @genre = Genre.new(genre_params)
    @genre.save
    redirect_to admin_genres_path
  end

  def index
    @genre = Genre.new
  end

  def edit
  end


  private

  def genre_params
    # エラー
    params.require(:genre).permit(:name)
  end

end
