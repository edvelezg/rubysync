#!/usr/bin/env ruby

puts `svn ci -m ""`
rel_folder = "www.daniel-lemire.com"

loc = `pwd`
arr = loc.chomp!.split('/')

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
puts `ssh edvelez@master.licef.ca 'cd #{rel_path}; svn update'`
