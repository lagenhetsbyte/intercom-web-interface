require_relative './test_helper.rb'

class AppTest < MiniTest::Unit::TestCase
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  def flash
    last_request.env['x-rack.flash'] || last_request.env['rack.session']['flash']
  end

  def test_start_page
    get '/'
    assert last_response.ok?
    assert_includes last_response.body, 'Intercom Web Interface'
  end

  def test_successful_post
    stub_request(:post, "https://api.intercom.io/tags").to_return(status: 200)
    post '/customers/tags', {emails: 'john@example.com', tag_name: 'testing'}
    assert_equal last_response.header['Location'], 'http://example.org/'
    assert flash[:notice], 'No flash notice is set'
  end

  def test_failed_post
    stub_request(:post, "https://api.intercom.io/tags").to_return(status: 500)
    post '/customers/tags', {emails: 'secret@example.com', tag_name: 'testing'}
    refute last_response.ok?
    assert flash[:error], 'No flash error is set'
  end
end
