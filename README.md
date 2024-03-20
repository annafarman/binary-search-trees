# binary-search-trees
## The Odin Project - Ruby Course: Project: Binary Search Trees

### My Personal Notes

```.uniq``` remove duplicate

```.sort``` sort arrays

```Height``` is defined as the number of edges in longest path from a given node to a leaf node.

```Depth``` is defined as the number of edges in path from a given node to the tree’s root node.

```A balanced tree is one where the difference between heights of left subtree and right subtree of every node is not more than 1.```

### Delete Recursive Method

1. Find Successor:
    
    - To delete a node with two children, we need to find the successor node, which is the node with the SMALLEST VALUE in the RIGHT SUBTREE of the node to be deleted. We can do this by finding the leftmost node in the right subtree.

2. Replace Node's Value:
    - Once the successor node's value is found, we replace the value of the node to be deleted with the successor's value. This ensures that the binary search tree property is maintained.

3. Delete Successor Node:
    - After replacing the node's value, we need to delete the successor node from its original position in the tree. We do this by recursively calling the ```delete_recursive``` method to remove the successor node from its new location in the right subtree.

### Level Order Method

In breadth-first level traversal, we visit all the nodes at each level of the tree from left --> right before moving to the next level.

1. Start with the root node & add the root node to the queue

2. While queue is NOT empty:
    - Dequeue a node from the front of the queue
    - Yield the node to the provided block (if given), or add its value to an array (if no block is given)
    - Enqueue the left and right child nodes (if they exist)


