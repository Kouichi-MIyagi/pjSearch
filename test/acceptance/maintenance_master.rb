require 'test_helper'

class LoginTest <AcceptanceTest
  #fixtures :users
  
   # 管理者でサインアップ -> データ件数確認
  test "scenario-20 maintenance masters" do
    visit_root
    ensure_browser_size
    
    save_screenshot "scenario-20-01.png" 
      
      fill_in "user_user_id", with: "pjsadmin"
      fill_in "user_password", with: "password"
      save_screenshot "scenario-20-02.png" 

      click_button "サインイン"
      save_screenshot "scenario-20-03.png" 

      click_link "データ件数確認"
      save_screenshot "scenario-20-04.png" 

      # 適切な画面に遷移したかを確認
      assert_equal db_counter_index_path, current_path

    sign_out

	end	

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
	
	  fill_in "user_user_id", with: "p8971228"
      fill_in "user_password", with: "password"
      save_screenshot "scenario-22-20.png" 

      click_button "サインイン"
      save_screenshot "scenario-22-21.png" 


	end	

end
