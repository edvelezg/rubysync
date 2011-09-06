class SrvrNfo
  attr_accessor :root, :prefix, :server
    
  def self.create
    args = {}
    print "Root (where do you start your directory structure? ex: dir1): "
    args[:root]     = gets.chomp.strip
    
    print "Prefix (where in the server is the mirror folder? ex: /ibrixfs1/Data): "
    args[:prefix]   = gets.chomp.strip
    
    print "Server (where is the remote location? ex: edvelez@eduardo-gutarra.webs.com)"
    args[:server]   = gets.chomp.strip
    
    return args
  end
  
  def initialize(args = {})
    @root   = args[:root]     || ""
    @prefix = args[:prefix]   || ""
    @server = args[:server]   || ""
  end
end

