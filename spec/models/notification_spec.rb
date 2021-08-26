require 'rails_helper'

RSpec.describe Notification, type: :model do

  describe 'アソシエーションのテスト' do
    context 'roomモデルとの関係' do
      it 'N:1となっている' do
        expect(Notification.reflect_on_association(:room).macro).to eq :belongs_to
      end
    end

    context 'messageモデルとの関係' do
      it 'N:1となっている' do
        expect(Notification.reflect_on_association(:message).macro).to eq :belongs_to
      end
    end

    context 'spotモデルとの関係' do
      it 'N:1となっている' do
        expect(Notification.reflect_on_association(:spot).macro).to eq :belongs_to
      end
    end

    context 'commentモデルとの関係' do
      it 'N:1となっている' do
        expect(Notification.reflect_on_association(:comment).macro).to eq :belongs_to
      end
    end

    context 'visitor(通知機能)との関係' do
      it 'N:1となっている' do
        expect(Notification.reflect_on_association(:visitor).macro).to eq :belongs_to
      end
    end

    context 'visited(通知機能)との関係' do
      it 'N:1となっている' do
        expect(Notification.reflect_on_association(:visited).macro).to eq :belongs_to
      end
    end

  end
end