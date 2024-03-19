class Node
    attr_accessor :value, :left_child, :right_child

    def initialize(value)
        @value = value
        @left_child = nil
        @right_child = nil
    end
end

class Tree
    attr_reader :root

    def initialize(arr)
        sorted_unique_arr = arr.uniq.sort
        @root = build_tree(sorted_unique_arr, 0, sorted_unique_arr.length-1)
    end 

    def insert(value)
        
    end

    def delete(value)

    end

    def pretty_print(node = @root, prefix = '', is_left = true)
        pretty_print(node.right_child, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right_child
        puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.value}"
        pretty_print(node.left_child, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left_child
    end

    private
    def build_tree(arr, start_idx, end_idx)
        #The build_tree method should return the level-0 root node
        return nil if start_idx > end_idx

        mid_idx = (start_idx + end_idx) / 2
        node = Node.new(arr[mid_idx])

        node.left_child = build_tree(arr, start_idx, mid_idx - 1)
        node.right_child = build_tree(arr, mid_idx + 1, end_idx)

        node
    end
end

mTree = Tree.new([1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324])
mTree.pretty_print

