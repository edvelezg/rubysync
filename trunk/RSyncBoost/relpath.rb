#!/usr/bin/env ruby

require "pathname"
require "yaml"
require "#{File.dirname(__FILE__)}/main"


cwd  = Pathname.pwd
home = Pathname.new(`echo $HOME`.chomp)

main    = Main.new(cwd.to_s, home.to_s)
prefix  = Pathname.new(main.srvrnfo.prefix)
cwd_arr = cwd.to_s.split("/")
idx     = cwd_arr.index(main.srvrnfo.root)
rt_path = Pathname.new(cwd_arr[0...idx].join("/"))

puts prefix.join(cwd.relative_path_from(rt_path))

# loc = File.dirname(__FILE__)
# rel_folder = `#{loc}/FindMirror/findMirrorDir.rb`.chomp
# 
# p rel_folder
# 
# # if rel_folder == ""
# #   exit
# # end
# # 
# # curdir = `pwd`
# # arr = curdir.chomp!.split('/')
# # arr.delete_at(0)
# # 
# # narr = []
# # hit = false
# # arr.each_index do |i|
# #   if hit
# #     narr << arr[i]
# #   end
# #   if arr[i] == "#{rel_folder}"
# #     hit = true
# #     narr << arr[i]
# #   end
# # end
# # 
# # rel_path = narr.join('/')
# # puts rel_path
