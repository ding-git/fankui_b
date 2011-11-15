filetype = "*." + ARGV.first.chomp()
path = "/Users/ding-zh/Downloads/"
descpath = "/Users/ding-zh/Desktop/"

Dir.mkdir("#{descpath}#{ARGV.first.chomp()}") if !Dir.exist?("#{descpath}#{ARGV.first.chomp()}")
  
Dir.chdir(path)
filenames = Dir.glob(filetype)

descpath_f = descpath + ARGV.first.chomp() + '/'
p descpath_f



puts "\n\n==============================="
puts "Excute : #{filetype} "
puts "FileCount : #{filenames.count}"
puts "===============================\n\n"

 
  filenames.each do | filename |
    # p "#{path}#{filename}"
    `mv "#{path}#{filename}" "#{descpath_f}"` if !File.exist?("#{descpath}#{ARGV.first.chomp()}/#{filename}")
    # 
  end