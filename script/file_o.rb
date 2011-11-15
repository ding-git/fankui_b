
File.open('bbb','a') do |file|
  for i in 1..3
    file.write("ID:#{i}. Time:#{Time.now}. baidu.size: #{`curl www.baidu.com`.size}\n")
  end
end


# target = File.open('test.txt','w')
# 
# target.write('xxx')