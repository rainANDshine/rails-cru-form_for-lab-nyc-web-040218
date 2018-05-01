class SongsController < ApplicationController
  def index
    @songs = Song.all
  end

  def show
    @song = Song.find(params[:id])
    @genre = Genre.find(@song.genre_id)
    @artist = Artist.find(@song.artist_id)
  end

  def new
    @song = Song.new
  end

  def create
    song = Song.create(post_params(:name))
    artist = Artist.find_or_create_by(params[:song][:artist_id])
    genre = Genre.find_or_create_by(params[:song][:genre_id])
    artist.songs << song
    genre.songs << song
    redirect_to song
  end

  def edit
    @song = Song.find(params[:id])
  end

  def update
    song = Song.find(params[:id])
    song.update(post_params(:name, :artist_id, :genre_id))
    redirect_to song
  end

  private
  def post_params(*args)
    params.require(:song).permit(*args)
  end
end
