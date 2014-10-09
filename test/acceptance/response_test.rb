require 'test_helper'

class ResponseTest <AcceptanceTest

  # [エラーケース] 一般ユーザでサインアップ -> 選択肢１項目のみ入力で登録
  test "scenario-31 add Response No1 " do
    visit_root
    
    save_screenshot "scenario-31-01.png" 
      
      fill_in "user_user_id", with: "p8971228"
      fill_in "user_password", with: "password"
      save_screenshot "scenario-31-02.png" 

      click_button "サインイン"
      save_screenshot "scenario-31-03.png" 

      # 適切な画面に遷移したかを確認
      assert_equal new_response_path, current_path
	  
	  select "ない", from: "response_response_items_attributes_0_selection_item"
      save_screenshot "scenario-31-04.png" 
	  
      click_button "登録する"
      save_screenshot "scenario-31-05.png" 

      sign_out

	end

	# [正常ケース] 一般ユーザでサインアップ -> 全て入力し登録-> 一覧画面がら選択し修正登録
	test "scenario-32 add Response No2" do
    visit_root
    
    save_screenshot "scenario-32-01.png" 
      
      fill_in "user_user_id", with: "p8971228"
      fill_in "user_password", with: "password"
      save_screenshot "scenario-32-02.png" 

      click_button "サインイン"
      save_screenshot "scenario-32-03.png" 

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
	  
	  
      save_screenshot "scenario-32-04.png" 
      click_button "登録する"
      save_screenshot "scenario-32-05.png" 
	  
      # 適切な画面に遷移したかを確認
      assert_equal "/", current_path
      save_screenshot "scenario-32-06.png" 

      click_link "回答結果一覧"
      save_screenshot "scenario-32-07.png" 

	  sleep(5)
      page.all(:link,"表示")[1].click
      save_screenshot "scenario-32-08.png" 
	  
	  click_link "戻る"

	  sleep(5)
      page.all(:link,"編集")[1].click
      save_screenshot "scenario-32-09.png" 

	  select "よい", from: "response_response_items_attributes_6_selection_item"
      save_screenshot "scenario-32-10.png" 
      click_button "更新する"
      save_screenshot "scenario-32-11.png" 

      sign_out

	end

# [正常ケース] 回答依頼からの流れ

  test "scenario-33 add request_questionare" do
    visit_root
    
    save_screenshot "scenario-33-01.png" 
      
      fill_in "user_user_id", with: "pjsadmin"
      fill_in "user_password", with: "password"
      save_screenshot "scenario-33-02.png" 

      click_button "サインイン"
      save_screenshot "scenario-33-03.png" 

      click_link "回答依頼作成"
      save_screenshot "scenario-33-04.png" 
      # 適切な画面に遷移したかを確認
      assert_equal request_questionnaires_path, current_path
	  
	  click_link "回答依頼登録"
      # 適切な画面に遷移したかを確認
      save_screenshot "scenario-33-05.png" 
      assert_equal new_request_questionnaire_path, current_path
	  
	  fill_in "request_questionnaire_target_year", with: "2014"
	  fill_in "request_questionnaire_target_month", with: "3"
	  select  "常駐者", from: "request_questionnaire_resident" 

      save_screenshot "scenario-33-06.png" 
	  click_button "登録する"

      save_screenshot "scenario-33-07.png" 

	  visit root_path
      save_screenshot "scenario-33-08.png" 

    sign_out
      #一般ユーザーでログイン
      fill_in "user_user_id", with: "p8971228"
      fill_in "user_password", with: "password"
      save_screenshot "scenario-33-09.png" 

      click_button "サインイン"
      save_screenshot "scenario-33-10.png" 

      # 適切な画面に遷移したかを確認
      assert_equal new_response_path, current_path
	  
	  # 回答の登録
	  select "ある", from: "response_response_items_attributes_0_selection_item"
      fill_in "response_response_items_attributes_0_comment", with: "知り合いがだれもいないので心細い"
	  select "感じている", from: "response_response_items_attributes_1_selection_item"
      fill_in "response_response_items_attributes_1_comment", with: "仕事なので、仕方ないですね"
	  select "やや曖昧", from: "response_response_items_attributes_2_selection_item"
	  select "時々変わる", from: "response_response_items_attributes_3_selection_item"
	  select "ほぼ足りている", from: "response_response_items_attributes_4_selection_item"
	  select "たまにいる", from: "response_response_items_attributes_5_selection_item"
	  select "やや悪い", from: "response_response_items_attributes_6_selection_item"
      fill_in "response_comment", with: "たまには現場を見に来るべき。"
	  
	  
      save_screenshot "scenario-33-11.png" 
      click_button "登録する"
      save_screenshot "scenario-33-12.png" 
	  
      # 適切な画面に遷移したかを確認
      assert_equal "/", current_path
      save_screenshot "scenario-33-13.png" 

	  sign_out

	end	

end
