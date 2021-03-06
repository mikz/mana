require File.expand_path File.join('client/test/test_helper')

require_all 'app'

class HelloTest < Test::Unit::TestCase
  include Capybara

  Capybara.run_server = false
  Capybara.default_driver = :webkit
  Capybara.app_host = 'http://localhost:3000'

  def setup
    if fork
      sleep 5
    else
      exec "bundle exec thin start -R ./config.ru"
    end
  end

  def test_hello
    visit '/games/some'
    assert_equal "hello world", page.body
  end

end
