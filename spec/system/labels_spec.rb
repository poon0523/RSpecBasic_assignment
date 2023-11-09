require 'rails_helper'
RSpec.describe 'ラベル管理機能', type: :system do
  let!(:user) { FactoryBot.create(:user) }
  let!(:label) { FactoryBot.create(:label, user_id: user.id, name: 'new_label') }

  describe '登録機能' do
    before do
        visit new_session_path
        fill_in "メールアドレス", with:user.email
        fill_in "パスワード", with:"testuser"
        click_button"ログイン"
        sleep 0.1
      end
 
    context 'ラベルを登録した場合' do
      it '登録したラベルが表示される' do
        visit new_label_path
        fill_in "ラベル", with:"new_label"
        click_button"登録する"
        expect(page).to have_content'ラベルを登録しました'
        expect(page).to have_content'new_label'
      end
    end
  end

  describe '一覧表示機能' do
    before do
        visit new_session_path
        fill_in "メールアドレス", with:user.email
        fill_in "パスワード", with:"testuser"
        click_button"ログイン"
        sleep 0.1
      end

    context '一覧画面に遷移した場合' do
      it '登録済みのラベル一覧が表示される' do
        visit labels_path
        expect(page).to have_content'ラベル一覧ページ'
        expect(page).to have_content'new_label'
      end
    end
  end
end