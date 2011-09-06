require "yaml"
require "pp"
require "#{File.dirname(__FILE__)}/SrvrNfo"

class Main
  attr_accessor :srvrnfo
  
  def self.create_mirror_root
    options = SrvrNfo.create
    File.open("mirror_root.yaml", "w") { |file| YAML.dump(options, file) }
  end

  def initialize(curdir, home)
    find_mirror_root(curdir, home)
  end
  
  def find_mirror_root(curdir, home)
    options = {}
    if file_usable?("#{home}/mirror_root.yaml")
      options = File.open("#{home}/mirror_root.yaml") { |file| YAML.load(file) }; puts "loading mirror_root.yaml in #{home}"
    elsif file_usable?("mirror_root.yaml")
      options = File.open("#{home}/mirror_root.yaml") { |file| YAML.load(file) }; puts "loading mirror_root.yaml in #{home}"
    else
      $stderr.puts "Create or modify a mirror_root.yaml file.\n"
      exit!
    end
    @srvrnfo = SrvrNfo.new(options)
  end  

  def file_usable?(filepath)
    return false unless filepath
    return false unless File.exists?(filepath)
    return false unless File.readable?(filepath)
    return false unless File.writable?(filepath)
    return true
  end

  def find_root_dir(abs_path_arr)
    unless abs_path_arr.include?(srvrnfo.root)
      $stderr.puts "the root {#{srvrnfo.root}} is not found in your current path."

      if system("scp FindMirror/findMirrorDir.sh edvelez@master.licef.ca:findMirrorDir.sh") 
        rel_folder = `ssh edvelez@master.licef.ca './findMirrorDir.sh #{srvrnfo.prefix} #{abs_path_arr.join(" ")}'`.chomp
      else
        puts "could not copy FindMirror/findMirrorDir.sh to edvelez@master.licef.ca:findMirrorDir.sh"
      end

      if rel_folder.length > 0
        $stderr.puts "Possible alternative root: {#{rel_folder}}"
      else
        $stderr.puts "could not find mirror folders for: #{abs_path_arr.join(" | ")}"
      end
      return false
    end
    return true
  end
end


# srvrnfo = find_mirror_root(curdir, home)


