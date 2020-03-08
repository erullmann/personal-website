class ArticlesController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_article

  def new
    @article = Article.new
    render 'edit'
  end

  def edit
  end

  def create
    @article = Article.new(article_params)
    @article.admin = current_admin

    if @article.save
      redirect_to root_path
    else
      puts @article.errors.as_json
      respond_to do |format|
        format.html { render 'edit'}
      end
    end
  end

  def update
    if @article.update(article_params)
      render 'edit'
    else
      render 'edit'
    end
  end

  def destroy
    @article.update(removed_at: Time.now)
    redirect_to root_path
  end

  private

  def article_params
    params.require(:article).permit(:body, :publish_date, :emoji, :title, :location, :source)
  end

  def set_article
    @article = Article.where(removed_at: nil).find_by_id(params[:id])
  end
end
