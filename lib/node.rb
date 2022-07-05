class Node
  attr_accessor :data, :left_child, :right_child

  def initialize(data=nil)
    @data = data
    @left_child = nil
    @right_child = nil
  end
end