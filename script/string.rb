# coding: UTF-8
t = Time.now

a = "经济实力大幅提升。经济保持平稳快速发展，物价基本稳定。社会主义新农村建设扎实推进，区域发展协调性增强。创新型国家建设进展良好，自主创新能力较大提高。" 
b = "经济实力大幅提升。经济保持平稳快速发展，物价基本稳定。社会主义新农村建设扎实推进，区域发展协调性增强。创新型国家建"

duibi_a = a.scan(/.../)
duibi_b = b.scan(/.../)

count = 0

for i in 0..9999
duibi_a.each do |duibi|
  puts "#{count} #{duibi == duibi_b[count]}"
  count += 1
end
end

puts Time.now - t