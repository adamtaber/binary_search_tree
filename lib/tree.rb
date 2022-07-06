require_relative './node'
require_relative './merge_sort'

class Tree
  attr_accessor :array, :level_order_array, :inorder_array, :preorder_array, :postorder_array
  attr_reader :root

  def initialize(arry)
    @array = sort_array(arry)
    @root = build_tree(array)
    @level_order_array = []
    @inorder_array = []
    @preorder_array = []
    @postorder_array = []
    @count = 0
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
        puts "please try another number"
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
      return root
    elsif root.data < value
      find(value, root.right_child)
    elsif root.data > value
      find(value, root.left_child)
    end
  end

  def level_order(arr1=[self.root], arr2=[])
    if arr1.length == 0
      return
    else
    arr1.each do |x|
      @level_order_array.push(x.data)
      arr2.push(x.left_child) if x.left_child != nil
      arr2.push(x.right_child) if x.right_child != nil
    end
    level_order(arr2)
    end
    @level_order_array
  end

  def preorder(root=self.root)
    if root == nil
      return
    else
      @preorder_array.push(root.data)
      preorder(root.left_child)
      preorder(root.right_child)
    end
    @preorder_array
  end

  def inorder(root=self.root)
    if root == nil
      return
    else
      inorder(root.left_child)
      @inorder_array.push(root.data)
      inorder(root.right_child)
    end
    @inorder_array
  end

  def postorder(root=self.root)
    if root == nil
      return
    else
      postorder(root.left_child)
      postorder(root.right_child)
      @postorder_array.push(root.data)
    end
    @postorder_array
  end

  def height(value, root=find(value), count_temp=0)
    if root == nil
      count_temp -= 1
      if count_temp > @count
        @count = count_temp
      end
      return
    else
      count_temp += 1
      height(value, root.left_child, count_temp)
      height(value, root.right_child, count_temp)
    end
    @count
  end

  def depth(value, root=self.root, count_temp=0)
    if root == nil
      @count = count_temp
      return
    elsif root.data == value
      @count = count_temp
      return
    else
      count_temp += 1
      depth(value, root.left_child, count_temp)
      depth(value, root.right_child, count_temp)
    end
    @count
  end

  def balanced?(root=self.root)
    if root == nil || root.left_child == nil || root.right_child == nil
      return
    elsif (height(root.left_child.data) - height(root.right_child.data)).abs > 1
      return false
    else
      balanced?(root.left_child)
      balanced?(root.right_child)
    end
    return true
  end

  def refresh_array(root=self.root, new_array=[])
    if root == nil
      return
    else
      new_array.push(root.data)
      refresh_array(root.left_child, new_array)
      refresh_array(root.right_child, new_array)
    end
    new_array
  end

  def rebalance(root=self.root)
    @array = refresh_array(root)
    sort_array(@array)
    @root = build_tree(@array)
  end

  def pretty_print(node=@root, prefix='', is_left=true)
    pretty_print(node.right_child, "#{prefix}#{is_left ? '|   ' : '    '}", false) if node.right_child
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left_child, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left_child
  end
end

test = Tree.new([1, 5, 8, 12, 18, 37, 50, 61, 71, 76, 77, 86, 93])
test.insert(102)
test.insert(103)
test.insert(104)
p test.balanced?
test.rebalance
p test.balanced?
p test.root
p test.level_order
p test.inorder
p test.preorder
p test.postorder
test.pretty_print