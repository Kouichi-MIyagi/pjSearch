require 'test_helper'

class NewTest <AcceptanceTest


  # 管理者でサインアップ -> upload user_states
  test "scenario-27 show user_states" do
    require 'csv'

    visit_root
    
    save_screenshot "scenario-27-01.png" 
      
      fill_in "user_user_id", with: "pjsadmin"
      fill_in "user_password", with: "password"
      save_screenshot "scenario-27-02.png" 

      click_button "サインイン"
      save_screenshot "scenario-27-03.png" 

      click_link "月別ユーザー情報"
      save_screenshot "scenario-27-04.png" 
      # 適切な画面に遷移したかを確認
      assert_equal user_states_path, current_path
	  
#      file_path = Rails.root + "test/acceptance/upload.csv"
#      file_path = "test/acceptance/upload.csv"
     file_path = "#{Rails.root}/test/acceptance/upload.csv"
      
      puts file_path
      attach_file('upload_file', file_path)
      
      click_button "アップロード"
      sleep(2)
      page.driver.browser.switch_to.alert.accept

      sleep(15)
	  
      click_link "Back"
      
      # 適切な画面に遷移したかを確認
      assert_equal user_states_path, current_path
      save_screenshot "scenario-27-05.png" 
      
      visit root_path
      save_screenshot "scenario-27-06.png" 

      sign_out

	end	

end
