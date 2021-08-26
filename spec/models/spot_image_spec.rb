require 'rails_helper'

RSpec.describe SpotImage, type: :model do

  describe 'アソシエーションのテスト' do
    context 'spotとの関係' do
      it 'N:1となっている' do
        expect(SpotImage.reflect_on_association(:spot).macro).to eq :belongs_to
      end
    end
 end
end