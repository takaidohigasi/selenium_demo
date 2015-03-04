#!/usr/bin/env ruby
# encoding: utf-8

require 'selenium-webdriver'

# @see http://www.seleniumhq.org/
# @see https://code.google.com/p/selenium/wiki/RubyBindings

# :firefox, :firefox(need to intall), :ie(need to install), :safari
BROWSER  = :chrome
USERNAME = 'taka-h'
FINAL_LEVEL = 9

# @param [Fixnum] level level
# @param [Selenium::WebDriver::Driver] driver
def accomplish_mission_for_the_level(level, driver)
  puts "trying to accomplish level %d challenge..." % level

  # (1) wait until js is loaded
  wait = Selenium::WebDriver::Wait.new(timeout: 600)
  wait.until { driver.find_element(class: 'ace_text-input') }

  # sorry...
  sleep 10

  # (2) clear text (it seems this doesn't work on chrome, safari.)
  puts 'clearing text...'
  3.times { |_| driver.find_element(class: 'ace_text-input').clear }
  driver.find_element(class: 'ace_text-input').clear

  file_to_load = "answer_code/level%02d.txt" % level

  # (3) input answer which is prepared as text in advance.

  # it seems firefox doen't send key (, # without Shift + Key
  # @see https://code.google.com/p/selenium/issues/detail?id=6411
  code = File.read(file_to_load, :encoding => Encoding::UTF_8)
  # input code as oneliner (so don't use # in the code)
  driver.find_element(class: 'ace_text-input').send_keys(code.gsub(/\n/, ';'))
  driver.find_element(class: 'ace_text-input').send_keys(:return)

  # click run code button
  driver.find_element(class: 'run-code').click

  # (code execution)
  puts 'waiting for code execution to finish...'

  return if level == FINAL_LEVEL

  # click next level button
  wait.until { driver.find_element(class: 'content') }
  # wait element not visible
  # @see http://qiita.com/okitan/items/f3bbe4a21cf08f7aefed
  wait.until { driver.find_element(class: 'content').find_element(:tag_name, 'a').displayed? }
  driver.find_element(class: 'content').find_element(:tag_name, 'a').click

  # click skip login button (may appear after 1st stage only)
  driver.find_element(class: 'skip-login').click if level == 1 && driver.find_element(class: 'skip-login')
end

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

  (1..FINAL_LEVEL).each { |level| accomplish_mission_for_the_level(level, driver) }

  sleep 60
  driver.save_screenshot('success-evidence.png')
rescue => ex
  p ex, ex.backtrace
  # this sometimes also does't work well
  driver.save_screenshot('evidence.png')
ensure
  # quit
  driver.quit
end
