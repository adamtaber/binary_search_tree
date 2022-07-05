class MergeSort
  def merge_sort(arr)
    if arr.length == 1
      arr
    else
      a = merge_sort(arr.slice!(0, arr.length/2))
      b = merge_sort(arr)
      if (a.length == 1) && (b.length == 1)
        a[0] <= b[0] ? [a[0]] + [b[0]] : [b[0]] + [a[0]]
      else
        a = a.flatten
        b = b.flatten
        temp = []
        merge(a, b, temp)
      end
    end
  end

  def merge(a, b, temp)
    if a.length == 0 && b.length == 0
      temp.flatten
    elsif a.length == 0
      temp << b
      temp.flatten
    elsif b.length == 0
      temp << a
      temp.flatten
    elsif a[0] <= b[0]
      temp << a[0]
      a.slice!(0)
      merge(a, b, temp)
    else
      temp << b[0]
      b.slice!(0)
      merge(a, b, temp)
    end
  end
end
