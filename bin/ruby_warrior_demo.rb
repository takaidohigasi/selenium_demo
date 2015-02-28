#!/usr/bin/env ruby
# encoding: utf-8

require 'selenium-webdriver'
# @see http://www.seleniumhq.org/
# @see https://code.google.com/p/selenium/wiki/RubyBindings

# initialize browser
driver = Selenium::WebDriver.for(:firefox)

# move to the page
driver.navigate.to('https://www.bloc.io/ruby-warrior#/')

# press button to move next page
driver.find_element(:class, 'button').click
driver.find_element(:class, 'button').click

# fill in the username and create user
driver.find_element(:class, 'name').find_element(:tag_name, 'input').clear
driver.find_element(:class, 'name').find_element(:tag_name, 'input').send_keys('taka-h')
driver.find_element(:id, 'create-warrior').click

# wait for a specific element to show up
sleep 5

wait = Selenium::WebDriver::Wait.new(timeout: 5)
wait.until { driver.find_element(class: 'editor') }

# clear text
driver.find_element(class: 'ace_text-input').clear

# input answer
code = File.read("answer_code/level01.txt", :encoding => Encoding::UTF_8).gsub(/\n/, ';')
driver.find_element(class: 'ace_text-input').send_keys(code)
sleep 20

# quit
driver.quit
