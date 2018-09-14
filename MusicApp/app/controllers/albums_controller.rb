class AlbumsController < ApplicationController

  def new
    @album = Album.new
    @bands = Band.all
    render :new
  end

  def create
    @album = Album.new(album_params)
    if @album.save!
      redirect_to album_url(@album)
    else
      flash.now[:errors] = @album.errors.full_messages
      render :new
    end
  end

  def edit
    @bands = Band.all
    @album = Album.find(params[:id])
    render :edit
  end

  def show
    @album = Album.find(params[:id])
    @band = Band.find_by(id: @album.band_id)
    render :show
  end

  def update
    @bands = Band.all
    @album = Album.find(params[:id])
    if @album.update(album_params)
      redirect_to album_url(@album)
    else
      flash.now[:errors] = @album.errors.full_messages
      render :edit
    end
  end

  def destroy
    @album = Album.find(params[:id])
    if @album.destroy
      redirect_to new_band_album_url
    else
      flash.now[:errors] = @album.errors.full_messages
      render :edit
    end
  end

  def album_params
    params.require(:album).permit(:title, :year, :band_id)
  end
end
