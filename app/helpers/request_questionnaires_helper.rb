module RequestQuestionnairesHelper

  # ‰ñ“šˆê——‚Ì‚½‚ß‚ÌƒpƒX‚ğ¶¬‚·‚é  
  def list_responses_path(request_questionnaire)
    return '/responses/index/' + request_questionnaire.id.to_s
  end

end
