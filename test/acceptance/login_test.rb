require 'test_helper'

class LoginTest <AcceptanceTest
  #fixtures :users
  
   # [正常系] 管理者でサインアップ -> サインアウト
  test "scenario-01 sign up with admin" do
    visit_root
    ensure_browser_size
    
    save_screenshot "scenario-01-01.png" 
      
      fill_in "user_user_id", with: "pjsadmin"
      fill_in "user_password", with: "password"
      save_screenshot "scenario-01-02.png" 

      click_button "サインイン"
      save_screenshot "scenario-01-03.png" 

      # 適切な画面に遷移したかを確認
      assert_equal '/', current_path

    sign_out

	end	
	
	# [正常系] 一般ユーザでサインアップ -> サインアウト
  test "scenario-02 sign up with user" do
    visit_root
    ensure_browser_size
    
    save_screenshot "scenario-02-01.png" 
      
      fill_in "user_user_id", with: "p8971228"
      fill_in "user_password", with: "password"
      save_screenshot "scenario-02-02.png" 

      click_button "サインイン"
      save_screenshot "scenario-02-03.png" 

      # 適切な画面に遷移したかを確認(依頼がない状態)
      assert_equal new_response_path, current_path

    sign_out

	end

  # [異常系] ユーザーIDとパスワード不整合
  test "scenario-03 try to sign up without password" do
    visit_root
    ensure_browser_size
    
      save_screenshot "scenario-03-01.png" 

      fill_in "user_user_id", with: "pjsadmin"
      save_screenshot "scenario-03-02.png" 

      click_button "サインイン"
      save_screenshot "scenario-03-03.png" 

      # 画面遷移せず（ログインしてしまったりせず）サインアップ画面に留まっていることを確認
      assert_equal user_session_path, current_path
  end

	
end
