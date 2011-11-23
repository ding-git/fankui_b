module Abc
  
  def content(http_url)
    require 'open-uri'
    require 'json'
    require 'nokogiri'

    json_content = JSON.parse(Nokogiri::HTML(open(http_url),nil,'utf-8'))

    return json_content
  end
  
end


