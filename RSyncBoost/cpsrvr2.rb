#!/usr/bin/env ruby
require "yaml"
require "pp"
 
class SrvrNfo
  attr_accessor :root, :prefix
  def initialize(root, prefix)
    @root   = root
    @prefix = prefix
  end  
end

home = `echo $HOME`.chomp
if File.exists?("#{home}/mirror_root.yaml")
  puts "from Home Dir"
  srvrnfo = File.open("#{home}/mirror_root.yaml") { |file| YAML.load(file) }
elsif File.exists?("mirror_root.yaml")
  puts "from Local Dir"
  srvrnfo = File.open("mirror_root.yaml") { |file| YAML.load(file) }
end

# unless File.exists?("mirror_root.yaml")
#   $stderr.puts "Please create mirror_root.yaml"
#   $stderr.puts "Define it as:"
#   exit
# end



curdir = `pwd`.chomp
arr = curdir.split('/')
arr.shift

narr = []
hit = false
arr.each_index do |i|
  if hit
    narr << arr[i]
  end
  if arr[i] == "#{srvrnfo.root}"
    hit = true
    narr << arr[i]
    puts "found #{arr[i]}"
  end
end

rel_path = narr.join('/')
# puts "copied to edvelez@master.licef.ca:#{rel_path}"
# puts `scp #{file} edvelez@master.licef.ca:#{rel_path}`
puts `rsync -avz --exclude '.svn' --exclude '.DS_Store' #{curdir}/* edvelez@master.licef.ca:#{srvrnfo.prefix}/#{rel_path}`