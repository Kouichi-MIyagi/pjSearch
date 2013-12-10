require 'test_helper'

class RequestMailerTest < ActionMailer::TestCase
  test "sendRequestMail" do
    mail = RequestMailer.sendRequestMail
    assert_equal "Sendrequestmail", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
