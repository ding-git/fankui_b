# coding: UTF-8
gem 'mechanize'
require 'mechanize'

agent = Mechanize.new

agent.get("http://www.aptx.cn")

b = Array.new

agent.page.links.each do |a|
  b << a.href if a.href =~ /aptx.cn/
end

c = 0

b.each do |b|
  sencond_link = Mechanize.new
  sencond_link.get(b)
  puts sencond_link.page.title
  puts b if sencond_link.page.title =~ /提示信息/
end