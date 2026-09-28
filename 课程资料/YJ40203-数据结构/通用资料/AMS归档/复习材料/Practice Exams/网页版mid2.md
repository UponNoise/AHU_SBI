1. Complete the following method that reverses the elements of an integer queue recursively. By reversing the queue, we mean that the first element becomes the last, the 2nd element becomes the 2nd-to-last element, … and the last element becomes the first element. You may assume the IntQueue class has the standard methods isEmpty, enqueue and dequeue.

 public static void reverse(IntQueue Q) {

   int temp;

   if _____________________________________  // stopping case

​     return;

   else {    // recursive case: must be exactly 3 statements

​     ____________________________________;





​     ____________________________________;

​     ____________________________________;

   }

}    

 

2. Consider the following recursive method on an integer array data with n integers:

​     public static int mystery(int[] data, int n) {
   int sum;
​    if (n <= 0) return 0;
​    else { 
​    if (data[n-1] % 2 == 0)
​            sum = mystery(data, n-1) + 1;
​    else
​      sum = mystery(data, n-1);
​        return sum;
   }
  }

(a)  What is the final return value of this method if it called with the following parameters initially: data = {2, 2, 3, 3, 3, 4, 4, 4, 4}, n = 9?

(b)  Assuming an int is 2 bytes and a memory reference (address) is 4 bytes, how many bytes are required for an activation record for this method?

**USE THE FOLLOWING BINARY SEARCH TREE FOR QUESTIONS 3 AND 4:**

```
                            M
                          /   \
                        J       Q
                      /        /  \
                     E        N    X
                      \           /
                       H         T
                      /           \
                     G             U        
```

3. 

​     (a) Write the inorder traversal of the binary tree above.  
​     (b) Write the preorder traversal of the binary tree above.      
​     (c) Write the postorder traversal of the binary tree above.     
​     (d) For any binary search tree with *n* letter nodes, what is the maximum number of nodes that have to be searched to find any letter?

4. 

  (a) What is the depth of the binary tree above?
  (b) What is the maximum number of nodes that can be inserted to the binary tree above without increasing its depth?           
  (c)  Draw the binary search tree after the node containing M is removed

5. This tree is a 2-3-4 tree:

```
            [34   56   78]
               /    |    |    \
          [12 23] [45]  [67]  [89]
```

  (a) Show the 2-3-4 tree after the integer 84 is inserted into the 2-3-4 tree.
  (b)  Convert the original 2-3-4 tree into an equivalent red-black tree. Label red nodes with the letter R and black nodes with the letter B.

6. A heap is stored using an array as follows:

| INDEX    | 0    | 1    | 2    | 3    | 4    | 5    | 6    |
| -------- | ---- | ---- | ---- | ---- | ---- | ---- | ---- |
| CONTENTS | 83   | 45   | 62   | 29   | 14   | 38   | 11   |

(a) Show the contents of the array after the value 37 is inserted into the heap.

(b) Show the contents of the array after the remove operation is performed on the original heap.

7. An array is sorted in non-increasing order and contains 64 data values.

​    (a) If sequential search is used, what is the maximum number of comparisons that is needed to search for a target in this array?
​    (b) If binary search is used, what is the maximum number of comparisons that is needed to search for a target in this array?
​    (c) TRUE OR FALSE: If the target occurs more than once in the array, binary search will find the target with the lowest index. (Explain.)
​    (d) If the target is in position 0 of the array, which search technique would find the data faster? Why?

8. A hash table is created to store integer keys using a hash function h(k) = k mod 13. The current state of the hash table is shown below. All keys were inserted without any collisions.

| INDEX         | 0    | 1    | 2    | 3    | 4    | 5    | 6    | 7    | 8    | 9    | 10   | 11   | 12   |
| ------------- | ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- |
| KEY           |      | 14   |      | 29   |      | 83   | 45   |      |      |      | 62   | 11   | 38   |
| HAS_BEEN_USED | F    | T    | F    | T    | F    | T    | T    | F    | F    | F    | T    | T    | T    |

​     (a)  At what position will the key 23 be stored in the hash table using h(k) above if linear probing is used to resolve collisions?
​     (b)  At what position will the key 23 be stored in the original hash table if double hashing is used to resolve collisions, 
​        assuming h1(k) = h(k) and h2(k) = 1 + (k mod 11) ? 
​     (c)  What is the load factor of the original table? 
​     (d)  Assuming linear probing is used and no removals have occurred, what is the approximate average number of 
​        table elements examined in a successful search of the original hash table? *(Express your answer as a simplified fraction.)* 

9. A hash table is defined using an array of 100 IntNode references, so that collisions can be handled by using chaining, as follows:

  public class Table {
   private int manyItems;
   private IntNode[] keys; 

public Table() {
   keys = new IntNode[100];
   manyItems = 0;
}

   private int hash(int key) {
     return key % 100;

}

   // other Table methods

}

Write Java code for the following Table methods below. You may assume that IntNode is a class that defines a singly-linked integer node with the methods getData, setData, getLink, setLink, and a default constructor.

 (a)  public void put(int key) 
    Inserts the key into the appropriate “chain” of the hash table. You may assume that the key is not a duplicate.

 (b)  public boolean containsKey(int key)
    Returns true if the key is in the hash table, or false otherwise.

10. Let the class BTNode represent a node of a binary tree that stores an integer, defined as follows:

   public class BTNode {

   private int data;

   private BTNode left, right;

   // BTNode methods

   }

​       Write Java code for the following recursive BTNode methods.

​       (a)        public void inorder()
​              Prints the contents of the binary tree rooted at this node using an inorder traversal.

​      (b)        public int count()
​              Returns the number of leaves in the binary tree rooted at this node.