require 'rails_helper'

RSpec.describe Relationship, type: :model do

  describe 'アソシエーションのテスト' do
    context 'followerとの関係' do
      it 'N:1となっている' do
        expect(Relationship.reflect_on_association(:follower).macro).to eq :belongs_to
      end
    end

    context 'followedとの関係' do
      it 'N:1となっている' do
        expect(Relationship.reflect_on_association(:followed).macro).to eq :belongs_to
      end
    end
  end

end