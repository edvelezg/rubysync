#!/usr/bin/env ruby

curdir = `pwd`.chomp
rel_folder = nil

if File.exists?("#{curdir}/.mirror_root")
  # puts ".mirror_root exists"
  rel_folder = File.read("#{curdir}/.mirror_root").chomp.to_s
else
  # Find the part of the current directory in the remote server.
  # puts ".mirror_root doesn't exist"
  tofind = curdir.chomp.split('/')
  tofind.delete_at(0)
  rel_folder = `ssh edvelez@master.licef.ca './findMirrorDir.sh #{tofind.join(" ")}'`.chomp

  if rel_folder.length < 1
    puts "No mirror folder found on server for #{curdir}"
    exit
  else
    # puts "writing .mirror_root"
    File.open('.mirror_root', "w") { |file| file.puts "#{rel_folder}" }
  end
end

arr = curdir.split('/')
puts rel_folder
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
# puts rel_path
puts `rsync -avz --exclude '.svn' --exclude '.DS_Store' edvelez@master.licef.ca:#{rel_path}/* #{curdir}`
# puts `scp #{file} edvelez@master.licef.ca:#{rel_path}`
# rsync -avz --exclude '.svn' --exclude '.DS_Store'  /Users/Naix/www.daniel-lemire.com/EdStuff/thesis/* UNBSJ@138.119.39.145:www.daniel-lemire.com/EdStuff/thesis

