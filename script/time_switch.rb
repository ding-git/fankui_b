a = 0
request_time = ARGV[0].to_i

loop do
  before = Time.now
  interval= request_time - (Time.now-before)
  sleep(interval) if interval>0
  puts Time.now
end