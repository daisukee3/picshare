class Apps::TimelinesController < Apps::ApplicationController

  def show

    # フォローしているidの情報を取得するためuser_idを指定
    user_ids = current_user.followings.pluck(:id)
    # @articles = Article.where(user_id: user_ids)下記に24時間以内の条件追加
    @articles = Article.where(user_id: user_ids, created_at: 24.hour.ago..Time.now).limit(5)

    article_like_count = @articles.joins(:likes).group(:article_id).count
    article_liked_ids = Hash[article_like_count.sort_by{ |_, v| v }.reverse].keys
    #Hash[article_like_count.sort_by{ |_, v| -v }].keysでも可能。
    @article_rankings= Article.find(article_liked_ids)

  end
end