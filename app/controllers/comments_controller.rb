class CommentsController < ApplicationController

  def show
    article = Article.find(params[:article_id])
    @comments = article.comments
  end

  def new
    article = Article.find(params[:article_id])
    @comment = article.comments.build
  end

  def create
    article = Article.find(params[:article_id])
    @comment = article.comments.build(comment_params)
    if @comment.save
      redirect_to articles_path(article), notice: 'コメントを追加'
    else
      flash.now[:error] = 'コメントを追加できませんでした'
      render :new
    end
  end

  private
  def comment_params
    params.require(:comment).permit(:content)
  end
end