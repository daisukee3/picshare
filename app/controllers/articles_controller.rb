class ArticlesController < ApplicationController
  before_action :set_article, only: [:edit, :update]
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]

  def index
    @articles = Article.all
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)
    if @article.save
      redirect to articles_path(@article), notice: '保存完了'
    else
      flash.now[:error] = '保存失敗'
      render :new
    end
  end

  def edit
  end

  def update
    if @article.update(article_params)
      redirect to articles_path(@article), notice: '更新完了'
    else
      flash.now[:error] = '更新失敗'
      render :edit
    end
  end

  def destroy
    article = Article.find(params:[:id])
    article.destroy!
    redirect_to root_path, notice: '削除成功'
  end

  private
  def article_params
    params.require(:article).permit(:title, :content)
  end

  def set_article
      @article = Article.find(params[:id])
  end
end