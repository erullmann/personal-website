class HomeController < ApplicationController
  def index
    @articles = paginate Article.published
  end

  def about
  end

  def resume
  end
end
