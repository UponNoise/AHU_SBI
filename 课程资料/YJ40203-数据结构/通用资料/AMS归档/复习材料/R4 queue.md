|      |      |      |      |      |
| ---- | ---- | ---- | ---- | ---- |

**CSE 214 – Recitation 4: Queues \[Spring 2023\]**

**1. \[5 minutes\] Consider the following statements:**

F i\. The stack data structure follows the FIFO (First In First Out) principle.  ==STACK====FIFO==

 ==LIFO== ==(Last-In-First-Out)====structure==

F ii\. The queue data structure follows the LIFO (Last In First Out) principle.

F iii\. The enqueue operation inserts an element onto the front of the queue.

F iv\. The dequeue operation removes an element from the rear of the queue.

T v\. In a priority queue, using the peek operation will return the highest priority element.

F vi\. One implementation of the queue data structure is to check whether an arithmetic expression has balanced parenthesis. ==STACK==

**Which of the following is correct?**

A. (i) and (iv) are true

B. (ii) and (iii) are true

C. (i), (ii), (iii) and (iv) are true

D. (v) is true

E. (i), (ii), (iii), (iv) and (v) are true

F. None of above

**2. \[2 minutes\] A normal queue, implemented using a circular array, gets full when?**

A. rear == CAPACITY ==FALSE==

B. rear == CAPACITY – 1 ==REAR是最后一个元素==

C. (rear + 1) % CAPACITY   ==True==

D. B and C

E. None of above

**3. \[2 minutes\] A normal queue, implemented using a circular array, is empty when?**

1.  front == −1 && rear == −1  ==构造方法中的设置方法==

2.  rear == front ==有可能是有一个元素或者空==

3.  front = 0 && rear = 0==有一个元素在0==

4.  A and B

5.  None of above

**4. \[5 minutes\] Consider a priority queue implemented using a sorted array. What is the worst case time complexity for the following operations?**

==两种处理方式 1是insert的时候不管，enqueue简单dequeue是很复杂的 2是把优先级排好序，dequeue非常的简单是o1但是enqueue需要找同优先级数据然后先挪位置再加入o(n)==

1)  Enqueue O(n)

2)  Peek O(1)

3)  Dequeue O(1)

**5. \[5 minutes\] What is the worst-case complexity of the following:**

==Tail进去head出去==

|  |  |  |
|----|----|----|
|  | **Enqueue** | **Dequeue** |
| **Circular Array** | O(1) | O(1) |
| **Singly linked list with head reference and head as the front**（在head地方出）？？？ | O(N)(要先找为节点) | O(1) |
| **Singly linked list with head and tail references with the head as the front** | O(1) | O(1) |
| **Doubly linked list with head and tail references with the head or tail as the front** | O(1) | O(1) |

**6. \[15 minutes\] Write a method that removes and return the nth element in an Int Queue. Assume you have access to the basic queue methods, such as enqueue, dequeue, size, etc.**

```JAVA
public int remove (IntQueue q, int n) {
    Intqueue q2=new Intqueue();
    if(n<=o||n>q.size()){
        throw nwe IllegalarguementExcrption();
       
    }
    int a=0;
    
    while(!q.isEmpty){
        if(a!=n){
            q2.enqueue(q.dequeue)
        }else{
            int answer=q.dequeue
        }
        
    }
    while(!q2.isEmpty){
        q.enqueue(q2.dequeue)
    }
    return answer;
    

// fill in code here

}
```

**7. \[5 minutes\] Given a Queue implemented using a circular array with a capacity of 5**

**and a sequence of operations:**

front = -1

rear = -1

1)  enqueue(3)

2)  enqueue(4)

3)  enqueue(6)

4)  dequeue()

5)  enqueue(8)

6)  enqueue(7)

7)  enqueue(5)

8)  dequeue()

9)  dequeue()

10) enqueue(2)

11) enqueue(10)

What does the Queue look like after the above 11 operations?

5 2 10(REAR ) 8(FRONT) 7



**What would happen if we try an extra operation “enqueue(9)” ?**

8\. \[10 minutes\] Write the following method to reverse a queue using recursion(递归）. Assume you have access to the following operations

1)  enqueue(x) : Add an item x to rear of queue.

2)  dequeue() : Remove an item from front of queue.

3)  is Empty() : Checks if a queue is empty or not. ==（选择最简单的情况做停止条件）==

```JAVA
public void reverseQueue(Queue<Integer> q) {
    Stack<Integer> stack = new Stack<>();
    
    // 将队列中的元素全部转移到栈中
    while (!q.isEmpty()) {
        stack.push(q.dequeue());
    }
    
    // 将栈中的元素全部转移回队列中
    while (!stack.isEmpty()) {
        q.enqueue(stack.pop());
    }
}

public Queue<T> reverseQueue(Queue<T> q) {
   if (q.isEmpty()) {
        return;
    }
    T current=q.dequeue();
    q=reverseQueue(q)
    q.enqueue(current);   
    return q
   
}

```

