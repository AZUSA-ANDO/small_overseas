require 'rails_helper'

RSpec.feature '管理者側のテスト' do
  let!(:admin) { create(:admin) }
  let!(:user) { create(:user) }
  let!(:overseas_area) { create(:overseas_area) }
  background do
    visit new_admin_session_path
    fill_in 'admin[email]', with: admin.email
    fill_in 'admin[password]', with: admin.password
    click_on 'LOG IN'
  end

  feature 'ユーザー画面のテスト' do
    background do
      visit admin_users_path
    end
    it 'ユーザーのステータスが正常に表示される' do
      expect(page).to have_content 'status'
    end
    it 'ユーザー名が表示,ユーザー名をクリックすると詳細ページに遷移する' do
      click_on user.name
      eq admin_user_path(user)
    end
    it 'ユーザーのemailが正常に表示される' do
      expect(page).to have_content user.email
    end
  end


  feature 'ヘッダーのテスト' do
    background do
      visit admin_users_path
    end
    it 'overseas_areaページに遷移する' do
      click_on 'Overseas Area'
      eq admin_overseas_areas_path
    end

    it 'user詳細ページに遷移する' do
      click_on 'User'
      eq admin_users_path
    end

    it '正常にログアウトされる' do
    click_on 'Sign out'
    eq new_admin_session_path
  end
  end


  feature 'overseas_area画面のテスト' do
    background do
      visit admin_overseas_areas_path
    end
    it 'Editボタンを押下し、編集ページに遷移する' do
      click_on 'Edit'
      eq edit_admin_overseas_area_path(overseas_area)
    end

    it 'Addボタンを押下すると、現在のページに表示される' do
      click_on 'Add'
      eq admin_overseas_areas_path
    end
  end

end
