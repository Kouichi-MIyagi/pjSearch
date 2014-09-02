require 'test_helper'

class MentenanceMasterTest <AcceptanceTest
  #fixtures :users
  
	   # 管理者でサインアップ -> 回答結果一覧
  test "scenario-21 maintenance masters" do
    visit_root
    ensure_browser_size
    
    save_screenshot "scenario-21-01.png" 
      
      fill_in "user_user_id", with: "pjsadmin"
      fill_in "user_password", with: "password"
      save_screenshot "scenario-21-02.png" 

      click_button "サインイン"
      save_screenshot "scenario-21-03.png" 

      click_link "回答結果一覧"
      save_screenshot "scenario-21-04.png" 

      # 適切な画面に遷移したかを確認
      assert_equal responses_path, current_path
	  
      page.all(:link,"表示")[0].click
      save_screenshot "scenario-21-05.png" 

    sign_out

	end	

	   # 管理者でサインアップ -> メンテナンス設定
	   # 一般ユーザーでサインアップ -> 回答登録画面でエラー
	   
  test "scenario-22 maintenance masters" do
    visit_root
    ensure_browser_size
    
    save_screenshot "scenario-22-01.png" 
      
      fill_in "user_user_id", with: "pjsadmin"
      fill_in "user_password", with: "password"
      save_screenshot "scenario-22-02.png" 

      click_button "サインイン"
      save_screenshot "scenario-22-03.png" 

      click_link "メンテナンス設定"
      save_screenshot "scenario-22-04.png" 

      # 適切な画面に遷移したかを確認
      assert_equal statuses_path, current_path
	  
      page.all(:link,"Edit")[0].click
      save_screenshot "scenario-22-06.png" 

	  check "status[is_mentenance]"
      save_screenshot "scenario-22-07.png" 
      click_button "更新する"
      save_screenshot "scenario-22-08.png" 

      click_link "Back"
      save_screenshot "scenario-22-09.png" 
	  sign_out
      save_screenshot "scenario-22-10.png" 
	#一般ユーザーでログイン
	  fill_in "user_user_id", with: "p8971228"
      fill_in "user_password", with: "password"
      save_screenshot "scenario-22-20.png" 

      click_button "サインイン"
      save_screenshot "scenario-22-21.png" 

	  sign_out
      fill_in "user_user_id", with: "pjsadmin"
      fill_in "user_password", with: "password"
      save_screenshot "scenario-22-23.png" 

      click_button "サインイン"
      save_screenshot "scenario-22-24.png" 

      click_link "メンテナンス設定"
      save_screenshot "scenario-22-25.png" 

      # 適切な画面に遷移したかを確認
      assert_equal statuses_path, current_path
	  
      page.all(:link,"Edit")[0].click
      save_screenshot "scenario-22-26.png" 

	  uncheck "status[is_mentenance]"
      save_screenshot "scenario-22-27.png" 
      click_button "更新する"
      save_screenshot "scenario-22-28.png" 

      click_link "Back"
      save_screenshot "scenario-22-29.png" 
	  sign_out
      save_screenshot "scenario-22-30.png" 


	end	
	   # 管理者でサインアップ -> 管理部門トピックの登録変更
  test "scenario-23 add topic" do
    visit_root
    ensure_browser_size
    
    save_screenshot "scenario-23-01.png" 
      
      fill_in "user_user_id", with: "pjsadmin"
      fill_in "user_password", with: "password"
      save_screenshot "scenario-23-02.png" 

      click_button "サインイン"
      save_screenshot "scenario-23-03.png" 

      click_link "管理部門トピック作成"
      save_screenshot "scenario-23-04.png" 
      # 適切な画面に遷移したかを確認
      assert_equal topics_path, current_path
	  
	  click_link "トピック登録"
      # 適切な画面に遷移したかを確認
      save_screenshot "scenario-23-05.png" 
      assert_equal new_topic_path, current_path
	  
	  fill_in "topic_title", with: "今月の一言"
      fill_in "topic_contents", with: "びんぼうひまなし\n\n詠み人知らず？"
	  select  "2016", from: "topic_effective_to_1i" 
	  select  "9", from: "topic_effective_to_2i" 
	  select  "30", from: "topic_effective_to_3i" 

	  save_screenshot "scenario-23-06.png" 
      click_button "登録する"
	  
      save_screenshot "scenario-23-07.png" 
	  
	  visit root_path
      save_screenshot "scenario-23-08.png" 

      sign_out

	end	

	
end
