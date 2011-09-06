#!/usr/bin/env ruby

# scripts dir
loc = File.dirname(__FILE__)

# current dir
tofind = `pwd`.chomp.split('/')
tofind.delete_at(0)
tofind.each { |e| p e }
# puts `scp #{loc}/findMirrorDir.sh edvelez@master.licef.ca:`
# puts `ssh edvelez@master.licef.ca `


# puts `ssh edvelez@master.licef.ca './findMirrorDir.sh #{tofind.join(" ")}'`