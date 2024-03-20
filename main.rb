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
        # p @root
    end 

    def insert(value)
        @root = insert_recursive(@root, value)
    end

    def delete(value)
        @root = delete_recursive(@root, value)
    end

    def find(value)
        #return the node with the given value
        @root = find_recursive(@root, value)
    end

    def level_order(block)
        #traverse the tree in breadth-first level order and yield each node to the provided block
        #return an array of values if no block is given

    end

    def inorder
    end

    def preorder
    end

    def postorder
    end

    def height(node)
        
    end

    def depth(node)
        
    end

    def balanced?
        
    end

    def rebalance

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

    def insert_recursive(node, value)
        return Node.new(value) if node.nil?

        if value < node.value
            node.left_child = insert_recursive(node.left_child, value)
        elsif value > node.value
            node.right_child = insert_recursive(node.right_child, value)
        end
        node
    end

    def delete_recursive(node, value)
        return node if node.nil?

        if value < node.value
            node.left_child = delete_recursive(node.left_child, value)
        elsif value > node.value
            node.right_child = delete_recursive(node.right_child, value)
        else
            #Case 1: Node has no children or only one child
            if node.left_child.nil?
                return node.right_child
            elsif node.right_child.nil?
                return node.left_child
            end

            #Case 2: Node has 2 children
            successor_value = find_min_value(node.right_child)
            node.value = successor_value
            node.right_child = delete_recursive(node.right_child, successor_value)
        end
        node
    end

    def find_min_value(node)
        current = node
        current = current.left_child until current.left_child.nil?
        current.value
    end

    def find_recursive(node, value)
        return nil if node.nil?
        return node if node.value == value

        if value < node.value
            return find_recursive(node.left_child, value)
        elsif value > node.value
            return find_recursive(node.right_child, value)
        end
    end
        
end

# mTree = Tree.new([1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324])
# mTree.pretty_print

mTree = Tree.new(Array.new(15) { rand(1..100) })
mTree.pretty_print

mTree.insert(58)
mTree.insert(7)
mTree.pretty_print

mTree.delete(58)
mTree.pretty_print

p mTree.find(23)
p mTree.find(57)
mTree.balanced?

