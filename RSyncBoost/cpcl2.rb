#!/usr/bin/env ruby
require "#{File.dirname(__FILE__)}/main"

def build_rsync_cmd
  curdir       = `pwd -P`.chomp
  home         = `echo $HOME`.chomp
  abs_path_arr = curdir.split('/')
  abs_path_arr.shift

  main = Main.new(curdir, home)
  return false unless main.find_root_dir(abs_path_arr)

  puts "remote starting directory is: #{main.srvrnfo.prefix}"

  rel_path_arr = []
  hit = false
  abs_path_arr.each_index do |i|
    if hit
      rel_path_arr << abs_path_arr[i]
    end
    if abs_path_arr[i] == "#{main.srvrnfo.root}"
      hit = true
      rel_path_arr << abs_path_arr[i]
      puts "found #{abs_path_arr[i]}"
    end
  end

  rel_path = rel_path_arr.join('/')
  puts `rsync -avz --exclude '.svn' --exclude '.DS_Store' edvelez@master.licef.ca:#{main.srvrnfo.prefix}/#{rel_path}/* #{curdir}`
  return true
end

if build_rsync_cmd
  puts "Completed Successfully"
else
  $stderr.puts "Failed"
end

# puts "copied to edvelez@master.licef.ca:#{rel_path}"
# puts `scp #{file} edvelez@master.licef.ca:#{rel_path}`
