require 'rails_helper'

RSpec.feature '新規会員登録のテスト' do
  let!(:user) { FactoryBot.build(:user) }

  feature '新規会員登録成功のテスト' do
    background do
      visit new_user_registration_path
      fill_in 'user[name]', with: user.name
      fill_in 'user[email]', with: user.email
      fill_in 'user[password]', with: user.password
      fill_in 'user[password_confirmation]', with: user.password_confirmation
    end
    it '新規会員登録成功のテスト' do
      expect { click_button 'Sign up' }.to change(User.all, :count).by(1)
    end
    it '新規会員登録後、welcomeメッセージが表示される' do
      click_on 'Sign up'
      expect(page).to have_content 'Welcome'
    end
  end


  feature '新規会員登録失敗のテスト' do
    background do
      visit new_user_registration_path
      fill_in 'user[name]', with: user.name
      fill_in 'user[email]', with: user.email
      fill_in 'user[password]', with: user.password
    end
    it '新規会員登録に失敗する' do
      expect { click_button 'Sign up' }.to change(User.all, :count).by(0)
    end
    it 'バリデーションエラーが表示される' do
      click_on 'Sign up'
      expect(page).to have_content 'error'
    end
  end

end