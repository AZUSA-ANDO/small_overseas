require 'rails_helper'

RSpec.describe User, type: :model do

  describe 'アソシエーションのテスト' do
    context 'spotモデルとの関係' do
      it '1:Nとなっている' do
        expect(User.reflect_on_association(:spots).macro).to eq :has_many
      end
    end

    context 'favoriteモデルとの関係' do
      it '1:Nとなっている' do
        expect(User.reflect_on_association(:favorites).macro).to eq :has_many
      end
    end

    context 'commentモデルとの関係' do
      it '1:Nとなっている' do
        expect(User.reflect_on_association(:comments).macro).to eq :has_many
      end
    end

    context 'messageモデルとの関係' do
      it '1:Nとなっている' do
        expect(User.reflect_on_association(:messages).macro).to eq :has_many
      end
    end

    context 'entryモデルとの関係' do
      it '1:Nとなっている' do
        expect(User.reflect_on_association(:entries).macro).to eq :has_many
      end
    end

    context 'followerとの関係' do
      it '1:Nとなっている' do
        expect(User.reflect_on_association(:follower).macro).to eq :has_many
      end
    end

    context 'followedとの関係' do
      it '1:Nとなっている' do
        expect(User.reflect_on_association(:followed).macro).to eq :has_many
      end
    end


    context 'following_userとの関係' do
      it '1:Nとなっている' do
        expect(User.reflect_on_association(:following_user).macro).to eq :has_many
      end
    end


    context 'follower_userとの関係' do
      it '1:Nとなっている' do
        expect(User.reflect_on_association(:follower_user).macro).to eq :has_many
      end
    end


     context 'active_notifications(通知)との関係' do
      it '1:Nとなっている' do
        expect(User.reflect_on_association(:active_notifications).macro).to eq :has_many
      end
    end


    context 'passive_notifications（通知）との関係' do
      it '1:Nとなっている' do
        expect(User.reflect_on_association(:passive_notifications).macro).to eq :has_many
      end
    end


  end

end