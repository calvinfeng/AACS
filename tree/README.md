# Tree
## Data structure
Tree is composed of nodes and edges. These nodes and edges cannot form cycles, otherwise they do not form a tree. Every node must have only one parent. Everything can trace back to one origin or *root*.

Tree is a special type of graph.

Examples of real life application of tree
* Indexing and fast lookup in a database
* Simulate states to automate decision making
* Model networking effect, such as social network, disease infections, population growth and etc...
* Your browser is a giant tree
* Any hierarchal filesystem

## Binary Tree
Nodes of a binary tree can at most have up to 2 children, hence the name *binary*. There are many applications for a binary tree:

https://stackoverflow.com/questions/2130416/what-are-the-applications-of-binary-trees

Here's a rough sketch

```
            A
          /    \
         B      C
        / \    / \
       D   E  F   G
```

## Tree Traversal
We are going to talk about four ways of traversing a tree
* Depth-first
    * Pre-order
    * In-order
    * Post-order
* Breadth-first
    * Level-order

### Pre-order
If you need to inspect and explore roots before any leaves, use pre-order traversal.
``` ruby
def traverse_pre_order(node)
    return [] if node.nil?
    result = [node.to_s]
    result += traverse_pre_order(node.left_child)
    result +=  traverse_pre_order(node.right_child)
    result
end
```

The expected output is `ABDECFG`, in case you can't follow the logic, imagine it as a divide and conquer problem.

```
A[left_sub_tree][right_sub_tree]
AB[left][right][right_sub_tree]
ABDE[right_sub_tree]
ABDEC[left][right]
ABDECFG
```

### In-order
If your tree have an inherit sequencing structure to it, for example, binary search tree, then use in-order traversal to visit them *in-order*.
``` ruby
def traverse_in_order(node)
    return [] if node.nil?
    result = traverse_in_order(node.left_child)
    result << node.to_s
    result += traverse_in_order(node.right_child)
    result
end
```

Using the similar logic, we can imagine that it goes as follows

```
[left_sub_tree]A[right_sub_tree]
[left]B[right]A[right_sub_tree]
DBEA[right_sub_tree]
DBEA[left]C[right]
DBEAFCG
```

### Post-order
If you need to explore all the leaves before any nodes, use post-order traversal to get to your leaves in the quickest time.
``` ruby
def traverse_post_order(node)
    return [] if node.nil?
    result = traverse_post_order(node.left_child)
    result += traverse_post_order(node.right_child)
    result << node.to_s
    result
end
```

Just like above

```
[left_sub_tree][right_sub_tree]A
[left][right]B[right_sub_tree]A
DEB[right_sub_tree]A
DEB[left][right]CA
DEBFGCA
```

### Level order
In order to talk about level order, we need to introduce the concept of queue. A queue is like a line, first come first serve. In the more technical term, it's first in first out *FIFO*. There are many variations of queue but we will keep it simple. We will implement a queue using an array.

``` ruby
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
```

This is also known as breadth first traversal (BFS)

http://www.algomation.com/algorithm/tree-traversal-preorder-inorder-postorder-breadth-first

## PolyNodeTree
Tree is a powerful data structure that enables us to solve many interesting and practical problems. Mapping and routing
depend heavily on tree structures, which is something we will cover when we talk about maze solver and path finding
algorithms. For a simple demo, we can use tree to map out all the possible end states of a Tic Tac Toe game

[Tic Tac Toe](./tic_tac_toe)
