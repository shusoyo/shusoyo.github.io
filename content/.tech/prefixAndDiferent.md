+++
 title = "prefix and diference" 
 date = "2023-01-29T21:40:48+08:00" 
 tags = ["alogrithmes"] 
 slug = "prefixdif"
 # gitinfo = true
 # align = true
 katex = true
+++

### 二维前缀和

给定一个3 x 4 的矩阵

$$ partion = \begin{Bmatrix} 1&5&6&8 \\\ 9&6&7&3 \\\ 5&3&2&4  \end{Bmatrix} $$

问：求 $ (1, 1) \rightarrow (2, 2) $ 的和以及 $ (0, 1) \rightarrow (1, 3) $ 的和

即求$ A(x_1, y_1) \rightarrow B(x_2, y_2) $ 的和( point A is the top left corner, B is the bottom right corner)


#### 法一：            
令 $ x_1 = xbegin, \\  x_2 = xend $             
对每一行数组求前缀和: $ sum_{[(x_1, y_1),(x_2, y_2)]} = \displaystyle\sum_{i=xbegin}^{xend} [i, y_2] $

#### 法二：
![](https://cdn.luogu.com.cn/upload/image_hosting/956hox3t.png)

已知蓝色部分为 $ partion_{(i, j)} $
$$ sum_{(i,j)} = sum_{(i - 1, j)} + sum_{(i, j - 1)} - sum_{(i - 1, j - 1)} + partion_{(i, j) } $$
$ 当 \ i = 0, j = 0\ 时：\\  sum_{[(i, j)]} = partion[0][0] $             
$ 当 \ i = 0, j \not = 0\ 时： \\ sum_{[(i, j)]} = partion[0][j] + sum_{[(0, j - 1)]} $               
$ 当 \ i \not = 0, j = 0\ 时： \\ sum_{[(i, j)]} = partion[i][0] + sum_{[(i - 1, 0)]} $

二维前缀和矩阵sum 如下
$$ sum =  \begin{Bmatrix} 1&6&12&20 \\\ 10&21&34&45 \\\ 15&29&44&59  \end{Bmatrix} $$

$ sum_{[(1, 1) \rightarrow (2, 2)]}$          
    $$  = sum_{[(0,0) \rightarrow (2, 2)]} - sum_{[(0, 0) \rightarrow (1 - 1, 2)]} - sum_{[(0, 0) \rightarrow (2, 1 - 1)]} + sum_{[(0, 0) \rightarrow (1 - 1, 1 - 1)]} $$
$ \ \ \ \  = 44 - 12 - 15 + 1 = 18 $

$ sum_{[(0, 1) \rightarrow (1, 3)]}$          
$ \ \ \ \  = sum_{[(0,0) \rightarrow (1, 3)]} - sum_{[(0, 0) \rightarrow (1, 1 - 1)]} $    
$ \ \ \ \  = 45 - 10 = 35 $ 

在oi比赛中，我们可以将二维前缀和矩阵包一行和一列0,可以减少代码量，方便计算:
$$ sum =  \begin{Bmatrix} 0&0&0&0&0 \\\ 0&1&6&12&20 \\\ 0&10&21&34&45 \\\ 0&15&29&44&59  \end{Bmatrix} $$

此时      
$ sum_{[(x_1, y_1) \rightarrow (x_2, y_2)]} $     
$ \ \ \ \ = sum_{[(0, 0) \rightarrow (x_2, y_2)]} - sum_{[(0, 0) \rightarrow (x_1 - 1, y_2)]} - sum_{[(0, 0) \rightarrow (x_2, y_1 - 1)]} + sum_{[(0, 0) \rightarrow (x_1 -1 , y_1 - 1)]} $

##### 示例代码
初始化样例数组 partion
``` cpp
  int partion[3][4] = {
      {1, 5, 6, 8},
      {9, 6, 7, 3},
      {5, 3, 2, 4},
  };
```

创建前缀和数组
``` cpp
  int sum[4][5] = {0}; // initalize prefix martix to 0
  sum[1][1] = partion[0][0];
  for (int i = 1; i < 4; i++) 
      for (int j = 1; j < 5; j++) 
          sum[i][j] = sum[i - 1][j] + sum[i][j - 1] - 
                      sum[i - 1][j - 1] + partion[i - 1][j - 1];    
```

Query
``` cpp
  int query, x1 = 2, y1 = 2, x2 = 3, y2 = 3;
  query =
      sum[x2][y2] + sum[x1 - 1][y1 - 1] - 
      sum[x1 - 1][y2] - sum[x2][y1 - 1] ;
  cout << query << endl;
```


### 二维差分

