# == Schema Information
#
# Table name: articles
#
#  id         :bigint           not null, primary key
#  content    :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_articles_on_user_id  (user_id)
#
class Article < ApplicationRecord
  belongs_to :user

  has_many :comments,dependent: :destroy

  def display_created_at
    I18n.l(self.created_at, format: :default)
  end
end
