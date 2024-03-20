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
        @root = insert_recursive(@root, value)
        # p @root
        # @root
    end

    def delete(value)
        @root = delete_recursive(@root, value)
        # p @root
        # @root
    end

    def find(value)
        #return the node with the given value
        find_recursive(@root, value)
    end

    def level_order_iteration(&block)
        # puts "Inside level order iteration." #debugging statement
        return [] if @root.nil?
        result = []
        queue = [@root]
        # p queue

        while !queue.empty?
            node = queue.shift
            # puts "Processing node: #{node.value}" #debugging statement
            block_given? ? yield(node) : result << node.value

            queue << node.left_child if node.left_child
            queue << node.right_child if node.right_child
        end
        result
    end

    def level_order_recursion(&block)
        # puts "Inside level recursion." #debugging statement
        return [] if @root.nil?
        result = []
        queue = [@root]
        # p queue

        level_order_recursive(queue, result, &block)
        result
    end

    def inorder_traversal(node = @root, &block)
        return [] if node.nil?
        result = []
        result += inorder_traversal(node.left_child, &block)
        block_given? ? yield(node) : result << node.value
        result += inorder_traversal(node.right_child, &block)
        result
    end


    def preorder_traversal(node = @root, &block)
        return [] if node.nil?
        result = []
        block_given? ? yield(node) : result << node.value
        result += inorder_traversal(node.left_child, &block)
        result += inorder_traversal(node.right_child, &block)
        result
    end

    def postorder_traversal(node = @root, &block)
        return [] if node.nil?
        result = []
        result += inorder_traversal(node.left_child, &block)
        result += inorder_traversal(node.right_child, &block)
        block_given? ? yield(node) : result << node.value
        result
    end

    def height(node = @root)
        return -1 if node.nil?

        left_height = height(node.left_child)
        right_height = height(node.right_child)

        [left_height, right_height].max + 1
    end

    def depth(node)
        return 0 if node.nil? || node == @root

        1+ depth(find_parent_recursive(@root, node))
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

    def level_order_recursive(queue, result, &block)
        return if queue.empty?
        node = queue.shift
        # puts "Processing node: #{node.value}" #debugging statement
        block_given? ? yield(node) : result << node.value

        queue << node.left_child if node.left_child
        queue << node.right_child if node.right_child

        level_order_recursive(queue, result, &block)
    end

    def find_parent_recursive(root, node)
        return nil if root.nil?
        return root if root.left_child == node || root.right_child == node

        left_parent = find_parent_recursive(root.left_child, node)
        right_parent = find_parent_recursive(root.right_child, node)

        left_parent.nil? ? right_parent : left_parent
    end
end

mTree = Tree.new([1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324])
mTree.pretty_print

# mTree = Tree.new(Array.new(15) { rand(1..100) })
# mTree.pretty_print

mTree.insert(58)
mTree.insert(7)
mTree.insert(88)
mTree.pretty_print

# mTree.delete(58)
# mTree.pretty_print

# p "Find 23: #{mTree.find(23)}"
# p "Find 57: #{mTree.find(57)}"

# p "Iteration: #{mTree.level_order_iteration}"
# mTree.level_order_iteration{|node| puts node.value}

# p "Recursion: #{mTree.level_order_recursion}"
# mTree.level_order_recursion{|node| puts node.value}


# p "In-order traversal: #{mTree.inorder_traversal}"
# mTree.inorder_traversal{|node| puts node.value}

# p "Pre-order traversal: #{mTree.preorder_traversal}"
# mTree.preorder_traversal{|node| puts node.value}

# p "Post-order traversal: #{mTree.postorder_traversal}"
# mTree.postorder_traversal{|node| puts node.value}

p "Height is #{mTree.height}."
p "The depth of value 67: #{mTree.depth(mTree.find(67))}."
p "The depth of value 23: #{mTree.depth(mTree.find(23))}."

mTree.balanced?
