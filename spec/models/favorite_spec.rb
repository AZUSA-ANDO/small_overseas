require 'rails_helper'

RSpec.describe Favorite, type: :model do

  describe 'アソシエーションのテスト' do
    context 'userモデルとの関係' do
      it 'N:1となっている' do
        expect(Favorite.reflect_on_association(:user).macro).to eq :belongs_to
      end
    end

    context 'spotモデルとの関係' do
      it 'N:1となっている' do
        expect(Favorite.reflect_on_association(:spot).macro).to eq :belongs_to
      end
    end
  end

end