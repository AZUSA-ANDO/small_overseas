require 'rails_helper'

RSpec.feature "ログイン前のテスト" do

   feature 'トップ画面のテスト' do
    background do
      visit root_path
    end
    context '表示内容の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq root_path
      end
      it 'ロゴが表示される' do
        expect(page).to have_link "", href: root_path
      end
      it 'LOGINアイコンが表示される' do
        expect(page).to have_content 'LOGIN'
      end
      it 'ABOUTアイコンが表示される' do
        expect(page).to have_content 'ABOUT'
      end
      it 'SIGN UPアイコンが表示される' do
        expect(page).to have_content 'SIGN UP'
      end
      it 'VIEWアイコンが表示される' do
        expect(page).to have_content 'VIEW'
      end
    end

    context 'リンク先の確認' do
      it 'LOGINを押下するとLOGINページへ推移する' do
        click_on 'LOGIN'
        eq log_in_path
      end
      it 'ABOUTを押下するとABOUTページへ推移する' do
        click_on 'ABOUT'
        eq about_path
      end
      it 'VIEWを押すと全投稿画面へ推移する' do
        click_on 'VIEW'
        eq spots_path
      end
    end
   end
  end

