**Recitation 3: Stacks (Spring 2023 TA Version)**

\[10 minutes\] Write the following push(), pop(), peek() methods to implement a stack using a doubly linked list (head is top of the stack)

> ```java
> `public class intNode {`
> 
> `private int number;`
> 
> `private intNode next;`
> 
> `private intNode prev;`
> 
> `public intNode(int number) {`
> 
> `this.number = number;`
> 
> `next = null;`
> 
> `prev = null;`
> 
> `}`
> 
> `}`
> 
> `public class intStack {`
> 
> `private intNode top;`
> 
> `public intStack() {`
> 
> `top = null;`
> 
> `}`
> 
> `public void push(int number) {`
>     intNode newNode = new intNode(number);
>         if (top == null) {
>             top = newNode;
>         } else {
>             newNode.next = top;
>             top.prev = newNode;
>             top = newNode;
>         }
> 
> 
> 
> `}`
> 
> `public int pop() {`
>     if (top == null) {
>             throw new RuntimeException("Stack is empty");
>         }
>         int value = top.getnext();
>         top = top.getnext();
>         if (top != null) {
>             top.prev = null; 
>         }
>         return value;
> 
> `}`
> 
> `public int peek() {`
>      if (top == null) {
>             throw new RuntimeException("Stack is empty");
>         }
>         int value = top.getnext();
>         return value;
> 
> 
> `}`
> 
> `}`
> ```
>
> 

\[5 minutes\] Write the order of complexity in Big-O for the following operations

Searching for a value in a stack.  $O(N)$ 

Reversing an array using a stack.$O(2N)$ ----$O(N)$ 

```JAVA
for(i=0;i<d.length;i++){
    s.push(d[i])
}
```

Evaluating a postfix expression using a stack.$O(N)$ 

Adding an element to a stack.$O(1)$$ push$

Retrieving the bottom-most value in a stack.$O(N)$ 

Removing a single element from a stack.$O(1)$$ pop$

==出现小数注意关注整型浮点型==

\[5 minutes\] Evaluate the following postfix expression:

> 5 3 8 \* 9 15 \* 5 / + +
>
> 5+ ((3* 8) +((9*15) /5))             56

\[5 minutes\] Evaluate the following prefix expression:

> \+ - \* 8 3 / 6 3 4       26

\[5 minutes\] Convert the following prefix expression to postfix:

> / \* A - B C \* / D E F ==与传统的思考方式有所不同====一般是先算前面那个括号==
>
> (A *(B- C))/ ((D/ E) *F )
>
> A B C -*D E/ F */
>
> 

\[5 minutes\] Write a method to push a node to the bottom of a stack.

==用两个堆栈就可以很好的解决==

```JAVA
public void insertBottom(Node node){
    Stack s2 =new Stack();
    while(!s.isEmpty){
        s2.push(s.pop());
    }
    s.push(node);
    while(!s2.isEmpty){
        s.push(s2.pop());
    }
}
```



\[15 minutes\] Write a method that evaluates a postfix expression using a stack and returns the result. Assume a valid postfix string is given and assume you have a stack with the following methods: .push(), .pop(), .peek():

```JAVA
public static int evaluatePostfix(String str) {
    intStack s = new intStack(); // 实例化自定义的栈

    for (int i = 0; i < str.length(); i++) {
        char c = str.charAt(i);

        if (c == ' ') {
            continue; // 补充：跳过空格，否则会抛出异常
        }

        if (Character.isDigit(c)) {
            // 利用 ASCII 码差值，将字符数字（如 '5'）转换为整数（5）
            s.push(character.getNumericalValue(c)); 
        } else {
            // 遇到运算符，弹出栈顶的两个元素
            int val2 = s.pop(); // 先弹出的是右操作数
            int val1 = s.pop(); // 后弹出的是左操作数

            switch (c) {
                case '+': 
                    s.push(val1 + val2); 
                    break;
                case '-': 
                    s.push(val1 - val2); 
                    break;
                case '*': 
                    s.push(val1 * val2); 
                    break;
                case '/': 
                    s.push(val1 / val2); 
                    break;
            } // end of switch
        }
    }
    return s.pop(); // 循环结束后，栈底剩下的唯一元素就是最终结果
}
```

