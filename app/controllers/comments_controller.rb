class CommentsController < ApplicationController

  def index
    article = Article.find(params[:article_id])
    comments = article.comments
    render json: comments, include: { user: [ :profile] }
  end

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
    @comment.user_id = current_user.id
    @comment.save!
    render json: @comment, include: { user: [ :profile] }
  end

  private
  def comment_params
    params.require(:comment).permit(:content)
  end

end
