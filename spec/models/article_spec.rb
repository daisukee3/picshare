require 'rails_helper'

RSpec.describe Article, type: :model do
  let!(:user) { create(:user) }

  context '内容の入力と写真が登録されている場合' do
    let!(:article) { build(:article, user: user) }

    it '記事を保存できる' do
      expect(article).to be_valid
    end
  end

  context '内容が0文字の場合' do
    let!(:article) { build(:article, content: Faker::Lorem.characters(number: 0), user: user) }

    before do
      article.save
    end

    it '記事を保存できない' do
      expect(article.errors.messages[:content][0]).to eq('を入力してください')
    end
  end
end
