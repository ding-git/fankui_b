# coding: UTF-8
def autoconf
  begin
    require 'rubygems'
    require 'open-uri'
    gem "nokogiri", ">=1.4.4"
  rescue Exception => e
    puts "no (Gem not found: #{e})"
    exit 1
  end
  
  puts "loading"
  starttime = Time.now
end

def jingdong

  require "nokogiri"


  baidu_doc = Nokogiri::HTML(open("http://www.aptx.cn"),nil,'utf-8')
  baidu_matchd = baidu_doc.xpath('//p/a')
  
  puts baidu_matchd.to_s.gsub(/[^\p{han}]+/,",")

  # baidu_matchd = baidu_doc.css("li a")
  # 
  # baidu_matchd.each do|s|
  #   p s.to_s.gsub('</a>','')
  # end
  

end

def time
  
end



autoconf

jingdong
