class MoviesController < ApplicationController
  def index
    # # --------
    # # Implementation with multiple filters (example only, doesn't work with the current app)
    # # --------

    # @movies = Movie.all

    # # Price filter
    # @movies = @movies.where('price >= ?', params[:min_price]) if params[:min_price].present?
    # @movies = @movies.where('price <= ?', params[:max_price]) if params[:max_price].present?

    # # Size filter
    # @movies = @movies.where(size: params[:size]) if params[:size].present?

    # # Location filter
    # @movies = @movies.near(params[:location]) if params[:location].present?

    # # Content filter with PG Search
    # @movies = @movies.global_search(params[:q])

    @movies =
      if params[:q].present?
        # PG Search Implementation
        Movie.global_search(params[:q])

        # # SQL Implementation
        # sql_query = <<~SQL
        #   movies.title @@ :q OR
        #   movies.synopsis @@ :q OR
        #   directors.first_name @@ :q OR
        #   directors.last_name @@ :q
        # SQL
        # Movie.joins(:director).where(sql_query, q: "%#{params[:q]}%")
      else
        Movie.all
      end
  end
end
