require 'rails_helper'

RSpec.describe Spot, type: :model do

  describe 'アソシエーションのテスト' do
    context 'userとの関係' do
      it 'N:1となっている' do
        expect(Spot.reflect_on_association(:user).macro).to eq :belongs_to
      end
    end

    context 'overseas_areaとの関係' do
      it 'N:1となっている' do
        expect(Spot.reflect_on_association(:overseas_area).macro).to eq :belongs_to
      end
    end


    context 'commentモデルとの関係' do
      it '1:Nとなっている' do
        expect(Spot.reflect_on_association(:comments).macro).to eq :has_many
      end
    end

    context 'favoriteモデルとの関係' do
      it '1:Nとなっている' do
        expect(Spot.reflect_on_association(:favorites).macro).to eq :has_many
      end
    end

    context 'spot_imageモデルとの関係' do
      it '1:Nとなっている' do
        expect(Spot.reflect_on_association(:spot_images).macro).to eq :has_many
      end
    end

    context 'notificationモデルとの関係' do
      it '1:Nとなっている' do
        expect(Spot.reflect_on_association(:notifications).macro).to eq :has_many
      end
    end


  end

end