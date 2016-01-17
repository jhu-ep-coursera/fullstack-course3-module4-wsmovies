class MoviesController < ApplicationController
  before_action :set_movie, only: [:show, :edit, :update, :destroy]

  # GET /movies
  # GET /movies.json
  def index
    Rails.logger.debug("index.params=#{params}")
    Rails.logger.debug("sliced.params=#{params.slice(*Movie.attribute_names)}")
    @movies = Movie.all(params.slice(*Movie.attribute_names))
  end

  # GET /movies/1
  # GET /movies/1.json
  def show
    Rails.logger.debug("movies#show")
    #add last_modified header and conditionally send 304 reponse
    fresh_when(@movie)
    Rails.logger.debug("response.etag=#{response.etag}")
  end

  # GET /movies/new
  def new
    @movie = Movie.new
  end

  # GET /movies/1/edit
  def edit
  end

  # POST /movies
  # POST /movies.json
  def create
    Rails.logger.debug("create.params=#{params}")
    Rails.logger.debug("create.movie_params=#{movie_params}")
    @movie = Movie.new(movie_params)

    respond_to do |format|
      if @movie.save
        fresh_when(@movie)
        format.html { redirect_to @movie, notice: 'Movie was successfully created.' }
        format.json { render :show, status: :created, location: @movie }
        format.v2json { render :show, status: :created, location: @movie }
      else
        format.html { render :new }
        format.json { render json: @movie.errors, status: :unprocessable_entity }
        format.v2json { render v2json: @movie.errors, status: :unprocessable_entity }
      end
    end

    rescue Mongo::Error::OperationFailure => e
      logger.info e
      respond_to do |format|
        format.html { render :new }
        format.json { render json: {msg:e.message}, status: :unprocessable_entity }
        format.v2json { render v2json: {msg:e.message}, status: :unprocessable_entity }
      end
  end

  # PATCH/PUT /movies/1
  # PATCH/PUT /movies/1.json
  def update
    respond_to do |format|
      if @movie.update(movie_params)
        fresh_when(@movie)
        format.html { redirect_to @movie, notice: 'Movie was successfully updated.' }
        format.json { render :show, status: :ok, location: @movie }
        format.v2json { render :show, status: :ok, location: @movie }
      else
        format.html { render :edit }
        format.json { render json: @movie.errors, status: :unprocessable_entity }
        format.v2json { render json: @movie.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /movies/1
  # DELETE /movies/1.json
  def destroy
    @movie.destroy
    respond_to do |format|
      format.html { redirect_to movies_url, notice: 'Movie was successfully destroyed.' }
      format.json { head :no_content }
      format.v2json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_movie
      @movie = Movie.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def movie_params
      params.require(:movie).permit(:id,:title)
    end
end
