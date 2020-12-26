class ArticlesController < ApplicationController
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
    @article = Article.find(params:[:id])
    end

  private
  def article_params
    params.require(:article).permit(:title, :content)
  end
end