require "test_helper"

class ProjectMailerTest < ActionMailer::TestCase
 test "project_created" do
  project = projects(:one)
  email = ProjectMailer.project_created(project).deliver_now

  assert_emails 1 # Check that one email was sent
    assert_equal ['radka@gmail.com'], email.to
    assert_equal 'Project Updated', email.subject
    assert_equal ['radka@gmail.com'], email.from
    assert_match 'Your project has been updated', email.body.to_s
 end
end
