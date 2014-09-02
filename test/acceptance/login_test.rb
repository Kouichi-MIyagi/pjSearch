require 'test_helper'

class LoginTest <AcceptanceTest
  #fixtures :users
  
   # [正常系] 管理者でサインアップ -> サインアウト
  test "scenario-11 sign up with admin" do
    visit_root
    
    save_screenshot "scenario-11-01.png" 
      
      fill_in "user_user_id", with: "pjsadmin"
      fill_in "user_password", with: "password"
      save_screenshot "scenario-11-02.png" 

      click_button "サインイン"
      save_screenshot "scenario-11-03.png" 

      # 適切な画面に遷移したかを確認
      assert_equal '/', current_path

    sign_out

	end	
	
	# [正常系] 一般ユーザでサインアップ -> サインアウト
  test "scenario-12 sign up with user" do
    visit_root
    
    save_screenshot "scenario-12-01.png" 
      
      fill_in "user_user_id", with: "p8971228"
      fill_in "user_password", with: "password"
      save_screenshot "scenario-12-02.png" 

      click_button "サインイン"
      save_screenshot "scenario-12-03.png" 

      # 適切な画面に遷移したかを確認
      assert_equal new_response_path, current_path

    sign_out

	end

  # [異常系] ユーザーIDとパスワード不整合
  test "scenario-13 try to sign up without password" do
    visit_root
    
      save_screenshot "scenario-13-01.png" 

      fill_in "user_user_id", with: "pjsadmin"
	  fill_in "user_password", with: "admin"

      save_screenshot "scenario-13-02.png" 

      click_button "サインイン"
      save_screenshot "scenario-13-03.png" 

      # 画面遷移せず（ログインしてしまったりせず）サインアップ画面に留まっていることを確認
      assert_equal user_session_path, current_path
  end

	
end
