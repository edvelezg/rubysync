#!/usr/bin/env ruby

file = ARGV[0]

rel_folder = "www.daniel-lemire.com"

curdir = `pwd`
arr = curdir.chomp!.split('/')

narr = []
hit = false
arr.each_index do |i|
  if hit
    narr << arr[i]
  end
  if arr[i] == "#{rel_folder}"
    hit = true
    narr << arr[i]
  end
end

rel_path = narr.join('/')
puts rel_path
puts `scp #{file} edvelez@master.licef.ca:#{rel_path}`
puts `ssh edvelez@master.licef.ca 'cd #{rel_path}; ./#{file}'`