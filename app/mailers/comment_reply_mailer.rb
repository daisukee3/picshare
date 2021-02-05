class CommentReplyMailer < ApplicationMailer
  def send_reply(user, article)
    @user = user
    @article = article
    mail to: user.email, subject: '【お知らせ】コメントに返信がありました'
  end
end