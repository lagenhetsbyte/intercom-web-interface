require_relative './test_helper.rb'

class AppTest < MiniTest::Unit::TestCase
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  def test_start_page
    get '/'
    assert last_response.ok?
    assert_includes last_response.body, 'Intercom Web Interface'
  end
end
