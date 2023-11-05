require 'rails_helper'

RSpec.describe 'ユーザ管理機能', type: :system do
  let!(:user) { FactoryBot.create(:user) }
  let!(:admin) { FactoryBot.create(:user, :admin) }
  let!(:task_user) { FactoryBot.create(:task, user_id: user.id) } 
  let!(:others) { FactoryBot.create(:user, name: "others_user") }
  let(:task_others) { FactoryBot.create(:task, user_id: others.id) }


  describe '登録機能' do
    context 'ユーザを登録した場合' do
      it 'タスク一覧画面に遷移する' do
        visit new_user_path
        fill_in"名前", with: "systemtest_user"
        fill_in"メールアドレス",with: "systemtest_user@gmail.com"
        fill_in"パスワード",with: "systemtestuser"
        fill_in"パスワード（確認）",with: "systemtestuser"
        click_button"登録する"
        expect(page).to have_content'アカウントを登録しました'
      end
    end
    

    context 'ログインせずにタスク一覧画面に遷移した場合' do
      it 'ログイン画面に遷移し、「ログインしてください」というメッセージが表示される' do
        visit tasks_path
        expect(page).to have_content'ログインページ'
        expect(page).to have_content'ログインしてください'
      end
    end
  end

  describe 'ログイン機能' do
    before do
      visit new_session_path
      fill_in "メールアドレス", with:user.email
      fill_in "パスワード", with:"testuser"
      click_button"ログイン"
      sleep 0.1
    end

    context '登録済みのユーザでログインした場合' do
      it 'タスク一覧画面に遷移し、「ログインしました」というメッセージが表示される' do
        expect(page).to have_content'タスク一覧'
        expect(page).to have_content'ログインしました'
      end

      it '自分の詳細画面にアクセスできる' do
        visit task_path(task_user.id)
        expect(page).to have_content'タスク詳細ページ'
      end

      it '他人の詳細画面にアクセスすると、タスク一覧画面に遷移する' do
        visit task_path(task_others.id)
        expect(page).to have_content'タスク一覧ページ'
      end

      it 'ログアウトするとログイン画面に遷移し、「ログアウトしました」というメッセージが表示される' do
        click_link "ログアウト"
        expect(page).to have_content'ログアウトしました'
      end
    end
  end

  describe '管理者機能' do
    context '管理者がログインした場合' do
      before do
        visit new_session_path
        fill_in "メールアドレス", with:admin.email
        fill_in "パスワード", with:"admintestuser"
        click_button"ログイン"
        sleep 0.1
      end
  
      it 'ユーザ一覧画面にアクセスできる' do
        visit admin_users_path
        expect(page).to have_content'ユーザ一覧ページ'
      end

      it '管理者を登録できる' do
        visit new_admin_user_path
        fill_in"名前", with: "systemtest_admin"
        fill_in"メールアドレス",with: "systemtest_admin@gmail.com"
        fill_in"パスワード",with: "systemtestadmin"
        fill_in"パスワード（確認）",with: "systemtestadmin"
        check"管理者権限"
        click_button"登録する"
        expect(page).to have_content'ユーザを登録しました'
      end

      it 'ユーザ詳細画面にアクセスできる' do
        visit admin_user_path(user)
        expect(page).to have_content'ユーザ詳細ページ'
      end

      it 'ユーザ編集画面から、自分以外のユーザを編集できる' do
        visit edit_admin_user_path(user)
        expect(page).to have_content'ユーザ編集ページ'
        fill_in"名前", with: "systemtest_admin_edit"
        fill_in"パスワード",with: "systemtestadmin"
        fill_in"パスワード（確認）",with: "systemtestadmin"
        click_button"更新する"
        expect(page).to have_content'ユーザを更新しました'
        expect(page).to have_content'systemtest_admin_edit'
      end

      it 'ユーザを削除できる' do
        visit admin_users_path
        destroy = User.find_by(name: 'others_user')
        click_link '削除', href: admin_user_path(destroy)
        expect(page.accept_confirm).to eq '本当に削除してもよろしいですか？'
        expect(page).to have_content 'ユーザを削除しました'
      end
    end
    context '一般ユーザがユーザ一覧画面にアクセスした場合' do
      before do
        visit new_session_path
        fill_in "メールアドレス", with:user.email
        fill_in "パスワード", with:"testuser"
        click_button"ログイン"
        sleep 0.1
        visit admin_users_path
      end
  
      it 'タスク一覧画面に遷移し、「管理者以外アクセスできません」というエラーメッセージが表示される' do
        expect(page).to have_content'タスク一覧ページ'
        expect(page).to have_content'管理者以外アクセスできません'
      end
    end
  end
end