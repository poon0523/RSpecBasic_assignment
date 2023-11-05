require 'rails_helper'

RSpec.describe 'タスク管理機能', type: :system do
  # 各画面での操作の前に一般ユーザーでログインしておく
  

  describe '登録機能' do
    context 'タスクを登録した場合' do
      # let!でuserインスタンスを作成することでbefore doの処理の前にインスタンスを作成
      let!(:user) { FactoryBot.create(:user) }
      # 各テストで必要なtaskも事前に作成。事前作成が必要でないもののみletで定義
      let!(:task) { FactoryBot.build(:task, user_id: user.id) }
      let!(:first_task) { FactoryBot.create(:task, user_id: user.id, title: 'first_task', created_at: '2025-02-18') }
      let!(:second_task) { FactoryBot.create(:task, user_id: user.id, title: 'second_task', created_at: '2025-02-17') }
      let!(:third_task) { FactoryBot.create(:task, user_id: user.id, title: 'third_task', created_at: '2025-02-16') }
      let(:add_later) { FactoryBot.create(:task, user_id: user.id, title: 'add_task', created_at: '2025-02-19') }
      # デフォルトでbefore doを使った場合、it構文の直前に処理が実行されるようになっており、describe、contextには適用されない
      # そのためbeforeのフック[:all]を使い、describeもしくはcontext実行の直前にbeforeが実行されるようにする
      before do
        visit new_session_path
        fill_in "メールアドレス", with:user.email
        fill_in "パスワード", with:"testuser"
        click_button"ログイン"
      end

      it '登録したタスクが表示される' do
        click_link"タスクを登録する" 
        fill_in"タイトル", with: task.title
        fill_in"内容",with: task.content
        fill_in"終了期限",with: task.deadline_on
        select task.priority, from:'優先度'
        select task.status, from:'ステータス'
        click_button"登録する"
        expect(page).to have_content'タスクを登録しました'
      end
    end
  end

  describe '一覧表示機能' do
    context '一覧画面に遷移した場合' do

       # let!でuserインスタンスを作成することでbefore doの処理の前にインスタンスを作成
      let!(:user) { FactoryBot.create(:user) }
      # 各テストで必要なtaskも事前に作成。事前作成が必要でないもののみletで定義
      let!(:task) { FactoryBot.build(:task, user_id: user.id) }
      let!(:first_task) { FactoryBot.create(:task, user_id: user.id, title: 'first_task', created_at: '2025-02-18') }
      let!(:second_task) { FactoryBot.create(:task, user_id: user.id, title: 'second_task', created_at: '2025-02-17') }
      let!(:third_task) { FactoryBot.create(:task, user_id: user.id, title: 'third_task', created_at: '2025-02-16') }
      let(:add_later) { FactoryBot.create(:task, user_id: user.id, title: 'add_task', created_at: '2025-02-19') }
      # デフォルトでbefore doを使った場合、it構文の直前に処理が実行されるようになっており、describe、contextには適用されない
      # そのためbeforeのフック[:all]を使い、describeもしくはcontext実行の直前にbeforeが実行されるようにする
      before do
        visit new_session_path
        fill_in "メールアドレス", with:user.email
        fill_in "パスワード", with:"testuser"
        click_button"ログイン"
      end

      it '作成済みのタスク一覧が作成日時の降順で表示される' do
        task_list = all('tbody tr')
        expect(task_list[0]).to have_text("first_task")
        expect(task_list[1]).to have_text("second_task")
        expect(task_list[2]).to have_text("third_task")
      end
    end

    context '新たにタスクを作成した場合' do
      # let!でuserインスタンスを作成することでbefore doの処理の前にインスタンスを作成
      let!(:user) { FactoryBot.create(:user) }
      # 各テストで必要なtaskも事前に作成。事前作成が必要でないもののみletで定義
      # デフォルトでbefore doを使った場合、it構文の直前に処理が実行されるようになっており、describe、contextには適用されない
      # そのためbeforeのフック[:all]を使い、describeもしくはcontext実行の直前にbeforeが実行されるようにする
      before do
        visit new_session_path
        fill_in "メールアドレス", with:user.email
        fill_in "パスワード", with:"testuser"
        click_button"ログイン"
      end

      let!(:task) { FactoryBot.build(:task, user_id: user.id) }
      let!(:first_task) { FactoryBot.create(:task, user_id: user.id, title: 'first_task', created_at: '2025-02-18') }
      let!(:second_task) { FactoryBot.create(:task, user_id: user.id, title: 'second_task', created_at: '2025-02-17') }
      let!(:third_task) { FactoryBot.create(:task, user_id: user.id, title: 'third_task', created_at: '2025-02-16') }
      let(:add_later) { FactoryBot.create(:task, user_id: user.id, title: 'add_task', created_at: '2025-02-19') }


      it '新しいタスクが一番上に表示される' do
        add_task = add_later.title
        task_list = all('tbody tr')
        expect(task_list[0]).to  have_text("add_task")
      end
    end
  end

  describe '詳細表示機能' do
    context '任意のタスク詳細画面に遷移した場合' do  
      # let!でuserインスタンスを作成することでbefore doの処理の前にインスタンスを作成
      let!(:user) { FactoryBot.create(:user) }
      # 各テストで必要なtaskも事前に作成。事前作成が必要でないもののみletで定義
      # デフォルトでbefore doを使った場合、it構文の直前に処理が実行されるようになっており、describe、contextには適用されない
      # そのためbeforeのフック[:all]を使い、describeもしくはcontext実行の直前にbeforeが実行されるようにする
      before do
        visit new_session_path
        fill_in "メールアドレス", with:user.email
        fill_in "パスワード", with:"testuser"
        click_button"ログイン"
      end

      let!(:task) { FactoryBot.create(:task, user_id: user.id) }
      let!(:first_task) { FactoryBot.create(:task, user_id: user.id, title: 'first_task', created_at: '2025-02-18') }
      let!(:second_task) { FactoryBot.create(:task, user_id: user.id, title: 'second_task', created_at: '2025-02-17') }
      let!(:third_task) { FactoryBot.create(:task, user_id: user.id, title: 'third_task', created_at: '2025-02-16') }
      let(:add_later) { FactoryBot.create(:task, user_id: user.id, title: 'add_task', created_at: '2025-02-19') }


      it 'そのタスクの内容が表示される' do
        visit task_path(task.id)
        expect(page).to have_content task.title
        expect(page).to have_content task.content
       end
    end
  end

  describe 'ソート機能' do   
    context '「終了期限」というリンクをクリックした場合' do  

      # let!でuserインスタンスを作成することでbefore doの処理の前にインスタンスを作成
      let!(:user) { FactoryBot.create(:user) }
      # 各テストで必要なtaskも事前に作成。事前作成が必要でないもののみletで定義
      # デフォルトでbefore doを使った場合、it構文の直前に処理が実行されるようになっており、describe、contextには適用されない
      # そのためbeforeのフック[:all]を使い、describeもしくはcontext実行の直前にbeforeが実行されるようにする
      let!(:first_task) { FactoryBot.create(:task, user_id: user.id, title: 'first_task', deadline_on: '2025-02-18') }
      let!(:second_task) { FactoryBot.create(:task, user_id: user.id, title: 'second_task', deadline_on: '2025-02-17') }
      let!(:third_task) { FactoryBot.create(:task, user_id: user.id, title: 'third_task', deadline_on: '2025-02-16') }
      let(:add_later) { FactoryBot.create(:task, user_id: user.id, title: 'add_task', deadline_on: '2025-02-19') }

      before do
        visit new_session_path
        fill_in "メールアドレス", with:user.email
        fill_in "パスワード", with:"testuser"
        click_button"ログイン"
      end


      it "終了期限昇順に並び替えられたタスク一覧が表示される" do
        # allメソッドを使って複数のテストデータの並び順を確認する
        click_link('終了期限')
        task_list = all('tbody tr')
        expect(task_list[0]).to have_text("third_task")
        expect(task_list[1]).to have_text("second_task")
        expect(task_list[2]).to have_text("first_task")
      rescue Selenium::WebDriver::Error::StaleElementReferenceError
        sleep 1
        retry
      end
    end

    context '「優先度」というリンクをクリックした場合' do
      # let!でuserインスタンスを作成することでbefore doの処理の前にインスタンスを作成
      let!(:user) { FactoryBot.create(:user) }
      # 各テストで必要なtaskも事前に作成。事前作成が必要でないもののみletで定義
      # デフォルトでbefore doを使った場合、it構文の直前に処理が実行されるようになっており、describe、contextには適用されない
      # そのためbeforeのフック[:all]を使い、describeもしくはcontext実行の直前にbeforeが実行されるようにする
      let!(:first_task) { FactoryBot.create(:task, user_id: user.id, title: 'first_task', priority: 1) }
      let!(:second_task) { FactoryBot.create(:task, user_id: user.id, title: 'second_task', priority: 2) }
      let!(:third_task) { FactoryBot.create(:task, user_id: user.id, title: 'third_task', priority: 0) }
      let(:add_later) { FactoryBot.create(:task, user_id: user.id, title: 'add_task', deadline_on: '2025-02-19') }

      before do
        visit new_session_path
        fill_in "メールアドレス", with:user.email
        fill_in "パスワード", with:"testuser"
        click_button"ログイン"
      end

      it "優先度の高い順に並び替えられたタスク一覧が表示される" do
        # allメソッドを使って複数のテストデータの並び順を確認する
        click_link('優先度')
        task_list = all('tbody tr')
        expect(task_list[0]).to have_text("second_task")
        expect(task_list[1]).to have_text("first_task")
        expect(task_list[2]).to have_text("third_task")
      rescue Selenium::WebDriver::Error::StaleElementReferenceError
        sleep 1
        retry
      end
    end
  end

  describe '検索機能' do
    context 'タイトルであいまい検索をした場合' do
            # let!でuserインスタンスを作成することでbefore doの処理の前にインスタンスを作成
      let!(:user) { FactoryBot.create(:user) }
      # 各テストで必要なtaskも事前に作成。事前作成が必要でないもののみletで定義
      # デフォルトでbefore doを使った場合、it構文の直前に処理が実行されるようになっており、describe、contextには適用されない
      # そのためbeforeのフック[:all]を使い、describeもしくはcontext実行の直前にbeforeが実行されるようにする
      let!(:first_task) { FactoryBot.create(:task, user_id: user.id, title: 'first_task', priority: 1) }
      let!(:second_task) { FactoryBot.create(:task, user_id: user.id, title: 'second_task', priority: 2) }
      let!(:third_task) { FactoryBot.create(:task, user_id: user.id, title: 'third_task', priority: 0) }
      let(:add_later) { FactoryBot.create(:task, user_id: user.id, title: 'add_task', deadline_on: '2025-02-19') }

      before do
        visit new_session_path
        fill_in "メールアドレス", with:user.email
        fill_in "パスワード", with:"testuser"
        click_button"ログイン"
      end

      it "検索ワードを含むタスクのみ表示される" do
        # toとnot_toのマッチャを使って表示されるものとされないものの両方を確認する
        fill_in 'search[title]', with: 'first'
        click_button"検索"
        task_list = all('tbody tr')
        expect(task_list[0]).to have_content'first_task'
        expect(task_list[0]).to have_no_content'second_task'
        expect(task_list[0]).to have_no_content'third_task'
      end
    end

    context 'ステータスで検索した場合' do
      # let!でuserインスタンスを作成することでbefore doの処理の前にインスタンスを作成
      let!(:user) { FactoryBot.create(:user) }
      # 各テストで必要なtaskも事前に作成。事前作成が必要でないもののみletで定義
      # デフォルトでbefore doを使った場合、it構文の直前に処理が実行されるようになっており、describe、contextには適用されない
      # そのためbeforeのフック[:all]を使い、describeもしくはcontext実行の直前にbeforeが実行されるようにする
      let!(:first_task) { FactoryBot.create(:task, user_id: user.id, title: 'first_task', status: 1) }
      let!(:second_task) { FactoryBot.create(:task, user_id: user.id, title: 'second_task', status: 2) }
      let!(:third_task) { FactoryBot.create(:task, user_id: user.id, title: 'third_task', status: 0) }
      let(:add_later) { FactoryBot.create(:task, user_id: user.id, title: 'add_task', deadline_on: '2025-02-19') }

      before do
        visit new_session_path
        fill_in "メールアドレス", with:user.email
        fill_in "パスワード", with:"testuser"
        click_button"ログイン"
      end

      it "検索したステータスに一致するタスクのみ表示される" do
        # toとnot_toのマッチャを使って表示されるものとされないものの両方を確認する
        select '未着手', from: 'search[status]'
        click_button"検索"
        task_list = all('tbody tr')
        expect(task_list[0]).to have_content("未着手")
        expect(task_list[0]).not_to have_content("着手中")
        expect(task_list[0]).not_to have_content("完了")
      end
    end

    context 'タイトルとステータスで検索した場合' do
      # let!でuserインスタンスを作成することでbefore doの処理の前にインスタンスを作成
      let!(:user) { FactoryBot.create(:user) }
      # 各テストで必要なtaskも事前に作成。事前作成が必要でないもののみletで定義
      # デフォルトでbefore doを使った場合、it構文の直前に処理が実行されるようになっており、describe、contextには適用されない
      # そのためbeforeのフック[:all]を使い、describeもしくはcontext実行の直前にbeforeが実行されるようにする
      let!(:first_task) { FactoryBot.create(:task, user_id: user.id, title: 'first_task', status: 0) }
      let!(:second_task) { FactoryBot.create(:task, user_id: user.id, title: 'second_task', status: 2) }
      let!(:third_task) { FactoryBot.create(:task, user_id: user.id, title: 'third_task', status: 1) }
      let(:add_later) { FactoryBot.create(:task, user_id: user.id, title: 'add_task', deadline_on: '2025-02-19') }

      before do
        visit new_session_path
        fill_in "メールアドレス", with:user.email
        fill_in "パスワード", with:"testuser"
        click_button"ログイン"
      end

      
      it "検索ワードをタイトルに含み、かつステータスに一致するタスクのみ表示される" do
        # toとnot_toのマッチャを使って表示されるものとされないものの両方を確認する
        select '未着手', from: 'search[status]'
        fill_in 'search[title]', with: 'first'
        click_button"検索"
        task_list = all('tbody tr')
        expect(task_list[0]).to have_content("未着手").and have_content'first_task'
        expect(task_list[0]).to have_no_content("着手中").and have_no_content'second_task'
        expect(task_list[0]).to have_no_content("完了").and have_no_content'third_task'
      end
    end
  end

  describe '検索機能' do

    let!(:user) { FactoryBot.create(:user) }
    let!(:task_search) { FactoryBot.create(:task, user_id: user.id, title: 'search_task', status: 0) }
    let!(:label_search) { FactoryBot.create(:label, name: 'search_label') }
    let!(:labelling_search) { FactoryBot.create(:labelling, task_id: task_search.id, label_id: label_search.id) }

    let!(:not_task_search) { FactoryBot.create(:task, user_id: user.id, title: 'not_search_task', status: 0) }
    let!(:not_label_search) { FactoryBot.create(:label, name: 'not_search_label') }
    let!(:not_labelling_search) { FactoryBot.create(:labelling, task_id: not_task_search.id, label_id: not_label_search.id) }
    

    before do
      visit new_session_path
      fill_in "メールアドレス", with:user.email
      fill_in "パスワード", with:"testuser"
      click_button"ログイン"
    end

    context 'ラベルで検索をした場合' do
      it "そのラベルの付いたタスクがすべて表示される" do
        # toとnot_toのマッチャを使って表示されるものとされないものの両方を確認する
        select 'search_label', from: 'search[label]'
        click_button"検索"
        task_list = all('tbody tr')
        expect(task_list[0]).to have_content("search_task")
        expect(task_list[0]).to have_no_content("not_search_task")
      end
    end
  end

end