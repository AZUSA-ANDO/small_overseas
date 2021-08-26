require 'rails_helper'

RSpec.feature 'ログイン後のテスト' do
  let!(:user) { create(:user) }

  background do
    visit new_user_session_path
    fill_in 'user[email]', with: user.email
    fill_in 'user[password]', with: user.password
    click_on 'Log in'
  end

feature 'ユーザー詳細画面のテスト（マイページ）' do
    background do
      visit user_path(user)
    end
    it 'ユーザー名が表示される' do
      expect(page).to have_content user.name
    end
    it '自己紹介欄が表示される' do
      expect(page).to have_content 'introduction'
    end
    it 'フォロー数が表示される' do
      expect(page).to have_content user.follower.count
    end
    it 'フォロワー数が表示される' do
      expect(page).to have_content user.followed.count
    end
    it 'フォローボタンが表示されない' do
      expect(page).to_not have_button 'follow'
    end
    it 'ユーザー編集ボタンが表示される' do
      expect(page).to have_link nil, href: edit_user_path(user)
    end
    it 'ユーザー編集ボタンを押下し、ユーザー編集画面に遷移する' do
      find('.fa-user-edit').click
      eq edit_user_path(user)
    end
    it '通知ボタンが表示される' do
      expect(page).to have_link nil, href: notifications_path
    end
    it '通知ボタンを押下し、通知画面に遷移する' do
      find('.fa-flag-checkered').click
      eq notifications_path
    end
    it 'プラスボタンを押下し、新規投稿画面に遷移する' do
      find('.fa-plus-square').click
      eq new_spot_path
    end
end

feature 'ユーザー情報編集画面のテスト' do
    background do
      visit edit_user_path(user)
    end
    it '名前が空欄の場合、更新されない' do
      fill_in 'user[name]', with: ''
      click_on 'update'
      expect(page).to have_content 'too short'
    end
    it 'emailが空欄の場合、更新されない' do
      fill_in 'user[email]', with: ''
      click_on 'update'
      expect(page).to have_content 'be blank'
    end

    it '退会はこちらを押下すると、退会確認画面へ推移する' do
      click_on 'こちら'
      eq quit_check_users_path
    end
end



feature 'ハンバーガーメニューのテスト' do
  it '正常にログアウトされる' do
    click_on 'LOGOUT'
    eq root_path
  end
  it 'アバウトページへ遷移する' do
    click_on 'ABOUT'
    eq about_path
  end
  it '全ての投稿ページへ推移する' do
    click_on 'ALL SPOT'
    eq spots_path
  end
end

end