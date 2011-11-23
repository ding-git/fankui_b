require 'find'

files = ARGV[0].chomp()

Find.find(files) do |path|
      #puts path if FileTest.directory?(path)
      if FileTest.file?(path)
        puts path if FileTest.size(path) >= 50000000
      end
end