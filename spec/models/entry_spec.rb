require 'rails_helper'

RSpec.describe Entry, type: :model do

  describe 'アソシエーションのテスト' do
    context 'userモデルとの関係' do
      it 'N:1となっている' do
        expect(Entry.reflect_on_association(:user).macro).to eq :belongs_to
      end
    end

    context 'roomモデルとの関係' do
      it 'N:1となっている' do
        expect(Entry.reflect_on_association(:room).macro).to eq :belongs_to
      end
    end
  end

end