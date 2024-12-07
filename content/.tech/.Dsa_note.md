+++
 title = "applacations of stack" 
 date = "2022-12-19T10:40:48+08:00" 
 tags = ["alogrithmes", "datastructures"] 
 slug = "dsanotes"
 # gitinfo = true
 align = false
+++
1. Page-visited history in web browser
2. Undo sequence in a text editor
3. Chain of method calls in the c++ runtime system
4. Infix to posfix conversion
5. Postfix expression evaluation
![image.png](https://tva1.sinaimg.cn/large/a010f416ly1h98y22taixj21fp130atv.jpg)
![image.png](https://tva1.sinaimg.cn/large/a010f416ly1h98y34frdkj21fp0jtqdf.jpg)
![image.png](https://tva1.sinaimg.cn/large/a010f416ly1h98y9m8xnyj21mb135kgb.jpg)
![image.png](https://tva1.sinaimg.cn/large/a010f416ly1h98yfsbhk9j21mb135nl5.jpg)

without parentheses:              
read statements and push the operator into stack, then compare the next element and the top element in the stack, pop the bigger operator if the next operator is smaller or equal to the top, and push the next element.

with parentheses:                
push operator or left parenthese into stack, it continues the without parentheses law when don't meet parenthese, else pop all operator which in the pair of parenthese.

6. parentheses matching algorithms:
![image.png](https://tva1.sinaimg.cn/large/a010f416ly1h98xmxggl5j21f9121e2l.jpg)
7. HTML tag matching
8. Maze solution finding