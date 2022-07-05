require_relative './node'
require_relative './merge_sort'

class Tree
  attr_accessor :array
  attr_reader :root

  def initialize(arry)
    @array = sort_array(arry)
    @root = build_tree(array)
  end

  def sort_array(arr=array)
    remove_duplicates(arr)
    self.array = MergeSort.new.merge_sort(arr)
  end

  def build_tree(arr=array)
    if arr.length < 1
      return
    else
      mid = (arr.length-1)/2
      root = Node.new(arr[mid])
      root.left_child = build_tree(arr[0...mid])
      root.right_child = build_tree(arr[(mid+1)..-1])
      root
    end
  end

  def remove_duplicates(arr)
    arr.each_index do |x|
      if arr.count(arr[x]) > 1
        arr.slice!(x)
      end
    end
  end

  def insert(value, root=self.root)
    if value < root.data && root.left_child == nil
      root.left_child = Node.new(value)
      root
    elsif value > root.data && root.right_child == nil
      root.right_child = Node.new(value)
      root
    else
      if root.data == value
        self.root
      elsif root.data < value
        root.right_child = insert(value, root.right_child)
        root
      elsif root.data > value
        root.left_child = insert(value, root.left_child)
        root
      end
    end
  end

  def delete(value, root=self.root)
    if root.data == value
      nil
    else
      if root.data < value
        root.right_child = delete(value, root.right_child)
        root
      elsif root.data > value
        root.left_child = delete(value, root.left_child)
        root
      end
    end
  end

  def find(value, root=self.root)
    if root.data == value
      p root
    elsif root.data < value
      find(value, root.right_child)
    elsif root.data > value
      find(value, root.left_child)
    end
  end
end

test = Tree.new([1, 1, 65, 2, 6, 3, 3, 3, 4])
test.find(4)


