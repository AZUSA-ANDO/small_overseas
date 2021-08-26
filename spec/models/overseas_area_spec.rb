require 'rails_helper'

RSpec.describe OverseasArea, type: :model do

  describe 'アソシエーションのテスト' do


    context 'spotモデルとの関係' do
      it '1:Nとなっている' do
        expect(OverseasArea.reflect_on_association(:spots).macro).to eq :has_many
      end
    end

  end

end