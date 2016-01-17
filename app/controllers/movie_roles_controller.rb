class MovieRolesController < ApplicationController
  before_action :set_movie
  before_action :set_movie_role, only: [:show, :edit, :update, :destroy]

  # GET /movie/:movie_id/roles
  # GET /movie/:movie_id/roles.json
  def index
    @movie_roles=@movie.roles
    fresh_when(@movie)
  end

  # GET /movie/:movie/roles/1
  # GET /movie/:movie/roles/1.json
  def show
  end

  # GET /movie/:movie/roles/new
  def new
    @movie_role = @movie.roles.build
  end

  # GET /movie_roles/1/edit
  def edit
  end

  # POST /movie/:movie_id/roles
  # POST /movie/:movie_id/roles.json
  def create
    last_modified=request.env["HTTP_IF_UNMODIFIED_SINCE"]
    fresh_when(@movie)   if last_modified  #get header values if condition supplied
    Rails.logger.debug("if_unmodified_since=#{last_modified}, current=#{response.last_modified}")

    if !last_modified || 
       (DateTime.strptime(last_modified,"%a, %d %b %Y %T %z") >= response.last_modified)

      @movie_role = @movie.roles.build(movie_role_params)
      respond_to do |format|
        if @movie_role.save
          fresh_when(@movie)
          format.html { redirect_to @movie, notice: 'Movie role was successfully created.' }
          format.json { render :"movies/show", status: :ok, location: @movie }
        else
          format.html { render :new }
          format.json { render json: @movie_role.errors, status: :unprocessable_entity }
        end
      end
    else
      render nothing: true, status: :conflict
    end
  end

  # PATCH/PUT /movie_roles/1
  # PATCH/PUT /movie_roles/1.json
  def update
    respond_to do |format|
      if @movie_role.update(movie_role_params)
        fresh_when(@movie)
        format.html { redirect_to @movie, notice: 'Movie role was successfully updated.' }
        format.json { render :show, status: :ok, location: @movie }
      else
        format.html { render :edit }
        format.json { render json: @movie_role.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /movie_roles/1
  # DELETE /movie_roles/1.json
  def destroy
    @movie_role.destroy
    respond_to do |format|
      format.html { redirect_to movie_roles_url, notice: 'Movie role was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_movie_role
      @movie_role = @movie.roles.find_by(:id=>params[:id])
    end
    def set_movie
      @movie = Movie.find(params[:movie_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def movie_role_params
      params.require(:movie_role).permit(:character, :actor_id)
    end
end
