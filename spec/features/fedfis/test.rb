
require 'capybara/rspec'

Capybara.register_driver :remote_selenium do |app|
  options = Selenium::WebDriver::Chrome::Options.new
  options.add_argument("--window-size=1400,1400")
  options.add_argument("--no-sandbox")
  options.add_argument("--disable-dev-shm-usage")

  Capybara::Selenium::Driver.new(
    app,
    browser: :chrome,
    url: "http://#{ENV["SELENIUM_HOST"]}:4444/wd/hub",
    options: options,
  )
end

Capybara.register_driver :remote_selenium_headless do |app|
  options = Selenium::WebDriver::Chrome::Options.new
  options.add_argument("--headless")
  options.add_argument("--window-size=1400,1400")
  options.add_argument("--no-sandbox")
  options.add_argument("--disable-dev-shm-usage")

  Capybara::Selenium::Driver.new(
    app,
    browser: :chrome,
    url: "http://#{ENV["SELENIUM_HOST"]}:4444/wd/hub",
    options: options,
  )
end

Capybara.register_driver :local_selenium do |app|
  options = Selenium::WebDriver::Chrome::Options.new
  options.add_argument("--window-size=1400,1400")

  Capybara::Selenium::Driver.new(app, browser: :chrome, options: options)
end

Capybara.register_driver :local_selenium_headless do |app|
  options = Selenium::WebDriver::Chrome::Options.new
  options.add_argument("--headless")
  options.add_argument("--window-size=1400,1400")
  options.add_argument("--disable-dev-shm-usage")

  Capybara::Selenium::Driver.new(app, browser: :chrome, options: options)
end

Capybara.default_driver = :local_selenium_headless
Capybara.default_max_wait_time = 100 # seconds

RSpec.describe 'fedfis test 1' do

  before :all do
    options = Selenium::WebDriver::Options.chrome(args: ['--headless=new'])
    @driver = Selenium::WebDriver.for :chrome, options: options
  end

  # it 'sanity' do
  #   visit 'http://localhost:3000'
  #   byebug
  # end

  it 'Fintech Digital Snapshot' do

    visit 'http://fedfis-fe.local'
    fill_in('username', with: 'piousbox')
    fill_in('password', with: 'test1234')
    click_on('Sign In')
    click_on('Fintech Digital Snapshot')

    n = 10
    total_time = 0

    # all('h6').each_with_index do |h6, idx|
    (1..n).each do |idx|
      begin_time = Time.now

      fintech_name = find(:xpath, "(//h6)[#{idx}]").text
      find(:xpath, "(//h6)[#{idx}]").click
      n_installs = find(".MuiGrid-item:nth-child(1) .MuiCardContent-root h5:nth-child(2)").text

      click_on('Go Back')

      time_delta = Time.now - begin_time
      total_time += time_delta
      puts "+++ Fintech Name: #{fintech_name}\t\tn_installs: #{n_installs}\t\ttime_delta: #{time_delta}"
    end

    puts "avg time: #{total_time/n}"
    # byebug
  end

end

