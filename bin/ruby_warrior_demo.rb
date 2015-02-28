require 'selenium-webdriver'

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

# quit
driver.quit
