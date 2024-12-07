+++
 title = "a simple linear list" 
 date = "2022-10-21T17:40:48+08:00" 
 tags = ["C","alogrithmes"] 
 slug = "a_simple_linear_list"
 gitinfo = true
 align = false
+++
function signature：
1. list_push: push a element at the list tail
2. list_init: initalize a list
3. list_insert: insert a element at the index
4. list_print: print list
5. list_expand: expand this list (default size is 20)
6. list_delete_index: delete element of index

```` c
void list_push(struct List * list, T element);
_Bool list_init(struct List * list);
_Bool list_insert(struct List * list, T element, int index); 
void list_print(struct List * list);
void list_expand(struct List * list);
_Bool list_delete_index(struct List * list, int index);
// _Bool list_delete_value(struct List * list, int key);
````
code:

``` c
#include <stdio.h>
#include <stdlib.h>

typedef int T;
struct List {
    T * array;
    int capacity;    
    int length;
};

void list_push(struct List * list, T element);
_Bool list_init(struct List * list);
_Bool list_insert(struct List * list, T element, int index); 
void list_print(struct List * list);
void list_expand(struct List * list);
_Bool list_delete_index(struct List * list, int index);
// _Bool list_delete_value(struct List * list, int key);


int comp_func(const void * a, const void * b) {
    return (*(int*)a - *(int*)b);
}

_Bool list_init(struct List* list) {
    list -> array = malloc(sizeof(T) * 10);
    if (list -> array == NULL)  return 0;
    list -> capacity = 10;
    list -> length = 0;
    return 1;
}

void list_push(struct List * list, T element) {
    if (list -> length == list -> capacity)
        list_expand(list);
    list -> array[list -> length] = element;
    list -> length += 1;    
}

_Bool list_insert(struct List *list, T element, int index) {
    if (index < list -> length && index >= 0) {
        if (index > list -> capacity - 1)
            list_expand(list);
        for (int i = list -> length; i > index; i--) {
        list -> array[i] = list -> array[i - 1];
        }

        list -> array[index] = element; 
        list -> length += 1;   
        return 1;
    } else {
        printf("fail to insert element: %d, index out of bound\n",
                element);
        return 0;
    }
} 

void list_print(struct List * list) {
    for (int i = 0; i < list -> length; i++) {
        printf("%d ", list -> array[i]);
    }
}

void list_expand(struct List * list) {
    int expand_size = sizeof(T) * (list -> capacity + 20);
    list -> array = realloc(list -> array, expand_size);
    list -> capacity += 20;
}

_Bool list_delete_index(struct List * list, int index) {
    if (index > 0 && index < list -> length) {
        for (int i = index; i < list -> length - 1; i++) {
            list -> array[i + 1] = list -> array[i];
        }
        list -> length -= 1;
        
        return 1;        
    } else {
        printf("failed to delete in index: index out of bound\n");
        return 0;
    } 
}

// _Bool list_delete_value(struct List * list, int key) {
    // todo
    // qsort(list -> array, list -> length, sizeof(T), comp_func);

    // return 1;
// }


int main() {
    struct List list;
    if (list_init(&list)) {

        for (int i = 0; i < 20; i++) {
            list_push(&list, i * 10);
        }
        list_push(&list, 10);
        list_push(&list, 0);
        list_push(&list, 10);
        list_insert(&list, 777, 2);
        list_insert(&list, 999, 9);
        list_print(&list);

        printf("\n%d\n", list.array[10]);
    } else {
        printf("cant alloc enough memory space to init\n");
    }

    return 0;
}
```

no time to add comments ( :