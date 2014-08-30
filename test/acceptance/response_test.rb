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
      fill_in "response_response_items_attributes_0_comment", with: "クレームなどは特にありません"
	  select "あまり感じてない", from: "response_response_items_attributes_1_selection_item"
      fill_in "response_response_items_attributes_1_comment", with: "負担は感じていません"
	  select "ほぼ明確になっている", from: "response_response_items_attributes_2_selection_item"
      fill_in "response_response_items_attributes_2_comment", with: "\nほぼ明確かも"
	  select "よく変わる", from: "response_response_items_attributes_3_selection_item"
      fill_in "response_response_items_attributes_3_comment", with: "仕方がないと思える範囲内です"
	  select "ほぼ足りている", from: "response_response_items_attributes_4_selection_item"
      fill_in "response_response_items_attributes_4_comment", with: "足りているとは言い切れませんが、これも許容範囲内です"
	  select "いる", from: "response_response_items_attributes_5_selection_item"
      fill_in "response_response_items_attributes_5_comment", with: "コンプライアンス的にどうかなと"
	  select "ややよい", from: "response_response_items_attributes_6_selection_item"
      fill_in "response_response_items_attributes_6_comment", with: "特に問題ありません"
      fill_in "response_comment", with: "週一回状況確認に来てくれている。。\nもう少し話を聞いてくれるとありがたい"
	  
	  
      save_screenshot "scenario-06-04.png" 
      click_button "登録する"
      save_screenshot "scenario-06-05.png" 
	  
      # 適切な画面に遷移したかを確認
      assert_equal "/", current_path
      save_screenshot "scenario-06-06.png" 

      click_link "回答結果一覧"
      save_screenshot "scenario-06-07.png" 

      page.all(:link,"表示")[1].click
      save_screenshot "scenario-06-08.png" 
	  
	  click_link "戻る"

      page.all(:link,"編集")[1].click
      save_screenshot "scenario-06-09.png" 

	  select "よい", from: "response_response_items_attributes_6_selection_item"
      save_screenshot "scenario-06-10.png" 
      click_button "更新する"
      save_screenshot "scenario-06-11.png" 

      sign_out

	end
	
end
