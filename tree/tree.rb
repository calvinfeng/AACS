require_relative './tree_node.rb'

class Tree
    def initialize(root_val)
        @root = TreeNode.new(root_val)
    end

    def insert(val)
        new_tree_node = TreeNode.new(val)
        queue = [@root]
        until queue.empty?
            current_node = queue.shift
            unless current_node.full?
                current_node.append_child(new_tree_node)
                break
            else
                queue << current_node.left_child
                queue << current_node.right_child
            end
        end
    end

    def print_by_level(nodes=[@root])
        return if nodes.empty?
        next_level = []
        str = []
        nodes.each do |node|
            str << node.to_s
            next_level << node.left_child unless node.left_child.nil?
            next_level << node.right_child unless node.right_child.nil?
        end
        puts str.join(" ")
        print_by_level(next_level)
    end

    def level_order
        result = []
        queue = [@root]
        until queue.empty?
            current_node = queue.shift
            queue << current_node.left_child unless current_node.left_child.nil?
            queue << current_node.right_child unless current_node.right_child.nil?
            result << current_node.to_s
        end
        result
    end

    def pre_order
        traverse_pre_order(@root)
    end

    def in_order
        traverse_in_order(@root)
    end

    def post_order
        traverse_post_order(@root)
    end



    private
    def traverse_pre_order(node)
        return [] if node.nil?
        result = [node.to_s]
        result += traverse_pre_order(node.left_child)
        result +=  traverse_pre_order(node.right_child)
        result
    end

    def traverse_in_order(node)
        return [] if node.nil?
        result = traverse_in_order(node.left_child)
        result << node.to_s
        result += traverse_in_order(node.right_child)
        result
    end

    def traverse_post_order(node)
        return [] if node.nil?
        result = traverse_post_order(node.left_child)
        result += traverse_post_order(node.right_child)
        result << node.to_s
        result
    end
end

my_tree = Tree.new('A')

("B".."G").each do |letter|
    my_tree.insert(letter)
end

my_tree.print_by_level

puts my_tree.pre_order.join
puts my_tree.in_order.join
puts my_tree.post_order.join
puts my_tree.level_order.join
