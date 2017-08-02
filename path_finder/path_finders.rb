def dijkstra(src_node, dest_node)
    closed_nodes = Hash.new
    # This should be a priority queue, I guess I will do this again in Python
    queue = {
        src_node => { cost: 0 }
    }
    until queue.empty?
        # If this was a queue, then I dont even need to do delete
        current_node, data = queue.min_by { |node, data| data[:cost] }
        if current_node == src_node
            return current_node
        closed_nodes[current_node] = data
        queue.delete(current_node)
        # Compute cost
        path_to_node_cost = data[:cost]
        current_node.neighbors.each do |neighbor_node|
            next if closed_nodes.has_key(neighbor_node)
            extended_path_cost = path_to_node_cost + neighbor_node.cost
            next if queue.has_key?(neighbor_node) && queue[neighbor_node][:cost] <= extended_path_cost
            # How to fast index into a queue? If it exists, then modify its priority value, if not
            # then insert it into the queue
            neighbor_node.set_from_node(current_node)
            queue[neighbor_node] = { cost: extended_path_cost }
        end
    end
end

def a_star(src_node, dest_node)
    closed_nodes = Hash.new
    # This should be a priority queue, I guess I will do this again in Python
    queue = {
        src_node => { cost: 0 }
    }
    until queue.empty?
        # If this was a queue, then I dont even need to do delete
        current_node, data = queue.min_by { |node, data| data[:cost] }
        if current_node == src_node
            return current_node
        closed_nodes[current_node] = data
        queue.delete(current_node)
        # Compute cost
        path_to_node_cost = data[:cost]
        current_node.neighbors.each do |neighbor_node|
            next if closed_nodes.has_key(neighbor_node)
            extended_path_cost = path_to_node_cost + neighbor_node.cost + neighbor_node.manhattan_distance(dest_node)
            next if queue.has_key?(neighbor_node) && queue[neighbor_node][:cost] <= extended_path_cost
            # How to fast index into a queue? If it exists, then modify its priority value, if not
            # then insert it into the queue
            neighbor_node.set_from_node(current_node)
            queue[neighbor_node] = { cost: extended_path_cost }
        end
    end
end
