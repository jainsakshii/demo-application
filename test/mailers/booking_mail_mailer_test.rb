require "test_helper"

class BookingMailMailerTest < ActionMailer::TestCase
  test "create_mail_to_user" do
    mail = BookingMailMailer.create_mail_to_user
    assert_equal "Create mail to user", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
