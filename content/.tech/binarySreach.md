+++
 title = "Binary Search details" 
 date = "2023-02-23T21:40:48+08:00" 
 tags = ["alogrithms"] 
 slug = "binarySreach"
 gitinfo = true
 align = false
 katex = true
+++

### binary Search persucode

```
L = -1 , R = N
WHILE L + 1 != R
    M = (L + R) / 2
    IF ISBLUE(M)
        L = M
    ELSE
        R = M
RETURN L OR R
```

### simply example

for flows sorted element

$$ \begin{bmatrix} 1&5&6&8&11&21 \end{bmatrix} $$

we can use binary search and coding to find key element

``` c++ 
int l = -1, r = N;
while (l + 1 != r) {
    m = l + (r - l) / 2;
    if (isBlue(m)) {
        l = m;
    } else {
        r = m
    }
} 
// l is the index of key elememt
```

and the judge function is flow

``` c++
bool isBlue(int m) {
    if (a[m] <= key) return true;
    else return false;
}
```

