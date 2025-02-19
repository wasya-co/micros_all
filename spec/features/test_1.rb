
require 'capybara/rspec'
require "selenium-webdriver"
require 'spec_helper'
# require 'capybara_helper'

Capybara.default_max_wait_time = 10 # seconds

RSpec.describe 'scrape zerohedge frontpage' do

  before :all do

    SELENIUM_HOST = '127.0.0.1'
    Capybara.register_driver :remote_browser do |app|
      client = Selenium::WebDriver::Remote::Http::Default.new
      client.read_timeout = 200

      options = Selenium::WebDriver::Firefox::Options.new
      options.add_argument("--headless")
      options.add_argument("--window-size=1400,1400")
      options.add_argument("--no-sandbox")
      options.add_argument("--disable-dev-shm-usage")

      Capybara::Selenium::Driver.new(
        app,
        browser: :remote,
        url: "http://#{SELENIUM_HOST}:4444/wd/hub",
        options: options,
      )
    end

  end

  it 'sanity' do
    @headlines = []
    visit '/'

    all("div[class^='ContributorArticleFeatured_container__']").each do |item|
      puts! item, 'item'

      @headlines.push({
        title:    item.find('h2').text,
        link:     item.find('h2 a')['href'],
        author:   item.find("[class^='ContributorArticleFeatured_author__']").text,
        subtitle: item.find("[class^='ContributorArticleFeatured_text__']").text,
      })
    end

    all("div[class^='Article_stickyContainer__']").each do |item|
      @headlines.push({
        title: item.find('h2').text,
        link:     item.find('h2 a')['href'],
        subtitle: item.find("div[class^='Article_desktopLineClamp__']").text,
      })
    end

    all("div[class^='Article_nonStickyContainer__']").each do |item|
      @headlines.push({
        title: item.find('h2').text,
        link:     item.find('h2 a')['href'],
        subtitle: item.find("div[class^='Article_desktopLineClamp__']").text,
      })
    end

    @headlines.each do |headline|
      puts "+++ +++ #{headline[:title]}"
      puts headline[:link]
      puts headline[:author] if headline[:author]
      puts headline[:subtitle]
      puts ''
    end

    sleep 10 # seconds
  end

end

