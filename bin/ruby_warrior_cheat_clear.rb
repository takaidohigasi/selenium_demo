#!/usr/bin/env ruby
# encoding: utf-8

require 'selenium-webdriver'
# @see http://www.seleniumhq.org/
# @see https://code.google.com/p/selenium/wiki/RubyBindings

# :firefox, :chrome(need to intall), :ie(need to install), :safari
# https://code.google.com/p/selenium/wiki/ChromeDriver
BROWSER  = :chrome
USERNAME = 'taka-h'
FINAL_LEVEL = 9

# initialize browser
driver = Selenium::WebDriver.for(BROWSER)

begin
  # move to the page
  driver.navigate.to('https://www.bloc.io/ruby-warrior#/')

  # press button to move next page
  driver.find_element(:class, 'button').click

  # http://stackoverflow.com/questions/17808521/how-to-avoid-compound-class-name-error-in-page-object
  # we can't directly access class name with space
  driver.find_element(:class, 'new-warrior').find_element(:tag_name, 'a').click

  # fill in the username and create user
  driver.find_element(:class, 'name').find_element(:tag_name, 'input').clear
  driver.find_element(:class, 'name').find_element(:tag_name, 'input').send_keys(USERNAME)
  driver.find_element(:id, 'create-warrior').click

  wait = Selenium::WebDriver::Wait.new(timeout: 15)
  wait.until { driver.find_element(class: 'ace_text-input') }
  user_id = driver.current_url.split('/')[5]

  # cheat
  driver.navigate.to("https://www.bloc.io/ruby-warrior#/warriors/#{user_id}/levels/#{FINAL_LEVEL}")

  wait.until { driver.find_element(class: 'ace_text-input') }

  # sorry...
  sleep 10

  # (2) clear text
  puts 'clearing text...'
  3.times { |_| driver.find_element(class: 'ace_text-input').clear }
  driver.find_element(class: 'ace_text-input').clear
  code = File.read("answer_code/level%02d.rb" % FINAL_LEVEL, :encoding => Encoding::UTF_8)
  # input code as oneliner (so don't use # in the code)
  driver.find_element(class: 'ace_text-input').send_keys(code.gsub(/\n/, ';'))
  driver.find_element(class: 'ace_text-input').send_keys(:return)

  # click run code button
  driver.find_element(class: 'run-code').click
  puts 'waiting for code execution to finish...'
  sleep 180

  driver.save_screenshot('success-evidence.png')
rescue => ex
  p ex, ex.backtrace
  # this sometimes also does't work well
  driver.save_screenshot('evidence.png')
ensure
  quit
  #driver.quit
end
