#coding: utf-8
require 'iconv'
puts Iconv.iconv("UTF-8", "GBK",`curl www.youku.com`)