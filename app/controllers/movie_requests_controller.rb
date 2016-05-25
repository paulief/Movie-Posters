class MovieRequestsController < ApplicationController
  before_action :set_movie_request, only: [:show]

  # GET /movie_requests/1
  # GET /movie_requests/1.json
  def show
  end

  # GET /movie_requests/new
  def new
    @movie_request = MovieRequest.new
  end

  # POST /movie_requests
  # POST /movie_requests.json
  def create
    @movie_request = MovieRequest.new(movie_request_params)
    movie_info = HttpHelper.get(title: movie_request_params[:title], year: movie_request_params[:year])

    @movie_request.poster = movie_info[:poster]

    respond_to do |format|
      if @movie_request.save
        format.html { redirect_to @movie_request, notice: 'Movie request was successfully created.' }
        format.json { render :show, status: :created, location: @movie_request }
      else
        format.html { render :new }
        format.json { render json: @movie_request.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_movie_request
      @movie_request = MovieRequest.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def movie_request_params
      params.require(:movie_request).permit(:title, :year, :poster)
    end
end
