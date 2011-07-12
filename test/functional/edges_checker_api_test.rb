require File.dirname(__FILE__) + '/../test_helper'
require 'edges_checker_controller'

class EdgesCheckerController; def rescue_action(e) raise e end; end

class EdgesCheckerControllerApiTest < Test::Unit::TestCase
  def setup
    @controller = EdgesCheckerController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end
end
