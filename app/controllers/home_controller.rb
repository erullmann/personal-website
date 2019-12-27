class HomeController < ApplicationController
  def index
    @articles = Article.published.offset(offset_param).limit(limit_param)
  end

  def about
  end

  def resume
  end
end
