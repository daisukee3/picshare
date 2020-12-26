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
    @article = Article.find(params[:id])
  end

  def update
    @article = Article.find(params:[:id])
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
end