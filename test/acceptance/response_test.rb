require 'test_helper'

class ResponseTest <AcceptanceTest
  # [エラーケース] 一般ユーザでサインアップ -> サインアウト
  test "scenario-05 add Response No1 --error" do
    visit_root
    ensure_browser_size
    
    save_screenshot "scenario-05-01.png" 
      
      fill_in "user_user_id", with: "p8971228"
      fill_in "user_password", with: "password"
      save_screenshot "scenario-05-02.png" 

      click_button "サインイン"
      save_screenshot "scenario-05-03.png" 

      # 適切な画面に遷移したかを確認
      assert_equal new_response_path, current_path
	  
	  select "ない", from: "response_response_items_attributes_0_selection_item"
      save_screenshot "scenario-05-04.png" 
	  
      click_button "登録する"
      save_screenshot "scenario-05-05.png" 

      sign_out

	end

	# [正常ケース] 一般ユーザでサインアップ -> サインアウト
	test "scenario-06 add Response No2" do
    visit_root
    ensure_browser_size
    
    save_screenshot "scenario-06-01.png" 
      
      fill_in "user_user_id", with: "p8971228"
      fill_in "user_password", with: "password"
      save_screenshot "scenario-06-02.png" 

      click_button "サインイン"
      save_screenshot "scenario-06-03.png" 

      # 適切な画面に遷移したかを確認
      assert_equal new_response_path, current_path
	  
	  select "ない", from: "response_response_items_attributes_0_selection_item"
	  select "あまり感じてない", from: "response_response_items_attributes_1_selection_item"
	  select "ほぼ明確になっている", from: "response_response_items_attributes_2_selection_item"
	  select "よく変わる", from: "response_response_items_attributes_3_selection_item"
	  select "ほぼ足りている", from: "response_response_items_attributes_4_selection_item"
	  select "いる", from: "response_response_items_attributes_5_selection_item"
	  select "ややよい", from: "response_response_items_attributes_6_selection_item"
	  
      save_screenshot "scenario-06-04.png" 
      click_button "登録する"
      save_screenshot "scenario-06-05.png" 
	  
      # 適切な画面に遷移したかを確認
      assert_equal "/", current_path
      save_screenshot "scenario-06-06.png" 

      sign_out

	end
	
end
