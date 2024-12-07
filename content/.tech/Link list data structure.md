+++
 title = "Link list data structure" 
 date = "2022-10-24T21:05:48+08:00" 
 tags = ["C","data_struct"] 
 slug = "basic_data_struct_linklist"
 align = false
 katex = true
+++
## Introduction of Link list
#### list as a abstract data type     
list is a common data struct , it can store a given number of elements of a given data-type , write or modify element of a position , and read element at a posion. In smoe programing language , array is a data structure , it can give us same implementation  of  list, but array need set size in advance and can't change  the fixed size under normal circumstances.
```
int a[1] = {1,2,};  // a array named 'a', size of 2*int, a[0] = 1, a[1] = 2 
```

c language provide some function in `<stdlib.h>`  to change the size of array.
```
malloc:
void* malloc (size_t size);

realloc:
void* realoc (void* per, size_t size);

calloc:
void* calloc (size_t num, size_t size);
```
Even so , the function don't look so smart.

Now , we need a dynamic list whose can grow according to my needs. So the feature of the list is following:
1. Its size is zero when it is empty.
2. Insert, remove, count some elements at any position 
3. Read/modify element at aposition
4. Specity data-type when build this list.        

The above function can also be implemented using an array but it's complicated because the arrays are contiguous in memory and logic. 

#### Link list

Link list is incontiguous in memory, so we need an intermediary link these dispersed elements. In normal case, the memory block occupied by a node in the link list not only stores this data element, but also stores a pointer to the next elements.  
```c
This is an example code to implement a link list use c language.
struct node {
	int data;
	int* next;
} 
```
![link_list](https://tva1.sinaimg.cn/large/a010f416ly1h7hco2uabqj20jz05b0tn.jpg)
$$\because T \propto n \quad \therefore O(n)$$
When inserting an element in a link list data structure, only need point the pointer of the predecessor element of the insert element to the inserted element, and then point the node pointer of the inserted element to the succeeding element.

#### Link List vs Array
##### 1. Cost of accesing an element
###### Array
**Constant Time Complexity:** $O(1)$                       
array elements are continous in memory, and every elements are same data-type 
means of every elements' size is constant, so memory manger can find them easily.
###### Link list
**Time Complexity:** $O(n)$

##### 2. Memory requirements
###### Array
Fixed size.
###### Link list
Grow up with user's need, but will produce extra memory for pointer variables.
##### 3. Cost of inserting an element
###### Array
When the array is not full :         
Insert an element at the end of the array, the time compl-exity is  $O(1)$ .     
Insert an element at the head of the array, the time complexity is $O(n)$ .      
Insert an element between head and end of the array, the time complexity is $O(n)$ . 

When the array is full, computer need request a new memory space, then copy the elements of the original array to the new array while inserting the new  element.       



###### Link list

Insert an element at the end of the link list, the time compl-exity is  $O(n)$ .   
Insert an element at the head of the link list, the time complexity is $O(1)$ .            
Insert an element between head and end of the link list, the time complexity is $O(n)$ .    

##### 4. Ease of use
**Array > Link list**

