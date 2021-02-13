require 'rails_helper'

RSpec.describe 'Comments', type: :request do
  let!(:user) { create(:user) }
  let!(:article) { create(:article, user: user) }
  let!(:comments) { create(:comment, article: article, user: user) }

  describe 'GET /comments' do
    context 'ログインしている場合' do
      before do
        sign_in user
      end

      # 500エラーが返ってきておりjsonで返ってきているからだめ？apiフォルダ要？
      it '200 Status' do
        get  article_comments_path(article_id: article.id)
        expect(response).to have_http_status(200)

        body = JSON.parse(response.body)
        expect(body.length).to eq 1
        expect(body[0]['content']).to eq comments.first.content
      end
    end
  end
end
