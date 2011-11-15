file = File.open('../log/development.log')

print "This file size #{file.size / 1024 / 1024} Megabytes\n" if file

file.close

print "Would you this file to Zero?(Y/N)"

input = STDIN.gets.chomp()

if input == 'y' || input == 'Y'

`echo > ../log/development.log`

p 'Good job!'

else 

p 'Goodbye'

end  