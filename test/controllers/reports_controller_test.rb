require 'test_helper'

class ReportsControllerTest < ActionDispatch::IntegrationTest
  test "should get output_journal" do
    get reports_output_journal_url
    assert_response :success
  end

  test "should get output_general_ledger" do
    get reports_output_general_ledger_url
    assert_response :success
  end

end
