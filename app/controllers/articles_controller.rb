class ArticlesController < ApplicationController
  before_action :set_article, only: [:show]
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]

  def index
    @articles = Article.all
  end

  def show
  end

  def new
    @article = current_user.articles.build
  end

  def create
    @article = current_user.articles.build(article_params)
    if @article.save
      redirect_to articles_path(@article), notice: '保存完了'
    else
      flash.now[:error] = '保存失敗'
      render :new
    end
  end

  def edit
    @article = current_user.articles.find(params[:id])
  end

  def update
    @article = current_user.articles.find(params[:id])
    if @article.update(article_params)
      redirect_to articles_path(@article), notice: '更新完了'
    else
      flash.now[:error] = '更新失敗'
      render :edit
    end
  end

  def destroy
    article = current_user.articles.find(params[:id])
    article.destroy!
    redirect_to root_path, notice: '削除成功'
  end

  private
  def article_params
    params.require(:article).permit(:title, :content, images: [])
  end

  def set_article
    @article = Article.find(params[:id])
  end
  
end