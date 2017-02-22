require 'test_helper'

class CompetitionMailerTest < ActionMailer::TestCase
  test "update_competition" do
    mail = CompetitionMailer.update_competition
    assert_equal "Update competition", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
