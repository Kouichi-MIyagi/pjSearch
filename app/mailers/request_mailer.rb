class RequestMailer < ActionMailer::Base
  default from: ENV['MAIL_SENDER']
  
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.request_mailer.sendRequestMail.subject
  #
  def sendRequestMail(request_questionnaire, destination)
  

    @mail_banner  = request_questionnaire.mail_banner
    @mail_content = request_questionnaire.mail_content
    @mail_trailer = request_questionnaire.mail_trailer
    
    mail to: "Tamura_Tetsuya@ogis-ri.co.jp", subject: request_questionnaire.mail_tilte ,  bcc: destination

    return self    
  end

end
