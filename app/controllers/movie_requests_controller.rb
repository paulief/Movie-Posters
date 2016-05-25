class MovieRequestsController < ApplicationController
  before_action :set_movie_request, only: [:show]

  # GET /movie_requests/1
  def show
  end

  # GET /movie_requests/new
  def new
    @movie_request = MovieRequest.new
  end

  # POST /movie_requests
  def create
    # check if same request already made
    if movie = MovieRequest.find_by(movie_request_params)
      @movie_request = movie
    else
      @movie_request = MovieRequest.new(movie_request_params)
      get_poster(@movie_request)
    end

    if @movie_request.errors.empty? && @movie_request.save
      render 'show'
    else
      render 'new'
    end
  end

  private
    def set_movie_request
      @movie_request = MovieRequest.find(params[:id])
    end

    def movie_request_params
      params.require(:movie_request).permit(:title, :year)
    end

    def get_poster(movie_request)
      movie_response = HttpHelper.get(title: movie_request.title, year: movie_request.year)

      movie_request.errors.add :poster, 'could not be found' if error?(movie_response)
      @movie_request.poster = movie_response['poster']
    end

    # response body has an 'errorcode' attribute if error
    def error?(response)
      response.key?('errorcode')
    end
end
