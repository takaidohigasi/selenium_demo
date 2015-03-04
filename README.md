# selenium_demo

Selenium Web Driverの使い方のデモを行う為のレポジトリです

# Requirement

- ruby
 - rubygems
 - bundler

※ chromeブラウザで動かすChrome Driverを使う場合は別途インストールが必要
https://code.google.com/p/selenium/wiki/ChromeDriver

# Setup

```
# clone code
$ git clone https://github.com/takaidohigasi/selenium_demo.git
$ cd selenium_demo

# install libraries
$ bundle install --path=vendor/bundle
```

# Sample

```
# level 1 〜 level 9をクリアする
$ bundle exec ruby bin/ruby_warrior_demo.rb

# チートしてlevel 9をクリアする
$ bundle exec ruby bin/ruby_warrior_cheat_clear.rb

# capybaraのサンプル
$ bundle exec rspec spec/capybara_sample_spec.rb
```
