require 'rails_helper'

RSpec.describe Comment, type: :model do
  let!(:user) { create(:user) }
  let!(:spot) { create(:spot) }
  let!(:comment) { create(:comment) }

  describe 'コメントのバリデーション・テスト' do
    it "101文字以上の場合、コメント投稿に失敗する" do
      opinion = Comment.new(opinion: Faker::Lorem.characters(number: 101))
      expect(opinion).not_to be_valid
    end
    it "空欄場合、コメント投稿に失敗する" do
      opinion = Comment.new(opinion: Faker::Lorem.characters(number: 0))
      expect(opinion).not_to be_valid
    end
  end


   describe 'アソシエーションのテスト' do
    context 'userモデルとの関係' do
      it 'N:1となっている' do
        expect(Comment.reflect_on_association(:user).macro).to eq :belongs_to
      end
    end

    context 'spotモデルとの関係' do
      it 'N:1となっている' do
        expect(Comment.reflect_on_association(:spot).macro).to eq :belongs_to
      end
    end

   context 'notificationモデルとの関係' do
      it '1:Nとなっている' do
        expect(Comment.reflect_on_association(:notifications).macro).to eq :has_many
      end
    end
   end


end
