class SrvrNfo
  attr_accessor :root, :prefix
  
  def initialize(args = {})
    @root   = args[:root]     || ""
    @prefix = args[:prefix]   || "."
  end
    
end

