require 'capybara/rspec'
require 'selenium-webdriver'
require 'capybara/poltergeist'

Capybara.javascript_driver = :poltergeist
Capybara.register_driver :firefox do |app|
  # poltergeist (headless)
  #Capybara::Poltergeist::Driver.new(app)

  # selenium
  Capybara::Selenium::Driver.new(app)
end

Capybara.default_driver = :firefox
Capybara.app_host       = 'http://www.google.co.jp'

RSpec.configure do |config|
  config.include Capybara::DSL
end

describe "google" do
  before do
    # ここにはSelenium Webdriverのコードは一切書かれておらず中間層で吸収されている
    visit '/'
  end
  context "トップページ" do
    # sample of OK test
    it { expect(page).to have_content('Google') }
    # sample of NG test
    it { expect(page).to have_content('Yahoo') }
  end
end


