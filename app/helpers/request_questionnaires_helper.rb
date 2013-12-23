module RequestQuestionnairesHelper

  # 回答一覧のためのパスを生成する  
  def list_responses_path(request_questionnaire)
    return '/responses/index/' + request_questionnaire.id.to_s
  end

end
