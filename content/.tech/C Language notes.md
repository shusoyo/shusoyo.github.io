+++
 title = "some c notes & code text" 
 date = "2022-10-20T21:40:48+08:00" 
 tags = ["C","alogrithmes"] 
 slug = "C_Language_notes"
 gitinfo = true
 align = false
+++



### zzulioj & zzuli examine
#### Output maximum prime factor
From the second C language experiment.      
This idea of this question is to find the factor of the input value, then determine whether it's a prime number. Loop from the maximum number until the prime factor found is directly output.
It is also possible to iterate from the smallest number, The time complexity will be lower.
``` c
#include <stdio.h>
#include <math.h>
int judge (int n);
int main () {
    int n, x;
    scanf("%d", &n);
    for (int i = 0; i < n; i++) {
        scanf("%d", &x);
        for (int j = 2; j <= x / 2; j++) {
            if (x % j == 0 && judge(j) == 1 && judge(x / j) == 1) {
                printf("%d\n", x / j);
                break;
            }
        }
    }
    return 0;
}
int judge(int n) {
    for (int k = 2; k < (int)sqrt(n); k++) {
        if (n % k == 0) {
            return 0;
        }
    }
    return 1;
}
```
      
#### guess the right apple
```c
#include <stdio.h>
int main () {
    int n, cnt1=0, cnt2=0 ,cnt3=0;
    int a[3] = {1,2,3}; // set a original array
    scanf("%d", &n);
    for (int i = 0; i < n; i++) {
        int x, y, c;
        scanf("%d %d %d", &x, &y, &c);
        // exchange
        int temp = a[x-1];
        a[x-1] = a[y - 1];
        a[y-1] = temp;
        // Three scenarios 
        if (a[c-1] == 1) {
            cnt1++;
        } 
        if (a[c-1] == 2) {
            cnt2++;
        }
        if (a[c-1] == 3) {
            cnt3++;
        }    
    }
    int max;
    max = cnt1 > cnt2 ? cnt1 : cnt2;
    max = cnt3 > max  ? cnt3 : max; // find the maximum number   
    printf("%d", max);
    return 0;
}    
```






### luogu
#### array
[P5594 【XR-4】模拟赛](https://www.luogu.com.cn/problem/P5594)


``` c
#include <bits/stdc++.h>
using namespace std; 
int n,m,k,a;  
int day[1010][1010]; 
int main() {   
    cin>>n>>m>>k;    
    for(int i=1; i<=n; i++)   //有n人，所以循环n次
        for(int j=1; j<=m; j++) //每人有m天有空，所以循环m天
            scanf("%d",&a),day[a][j]=1; //输入第i个人在第a天打了第j次卡，并做标记
    for(int i=1; i<=k; i++) {  //一共有k次输出，所以循环k次
        for(int j=1; j<=m; j++)  //从1~最大打卡天数枚举，看第i场共有几人打卡
            day[i][j]+=day[i][j-1];   //部分和一下，虽然显得有点多余
        printf("%d ",day[i][m]);  //输出部分和的总量，也就是第1~k天分别对应的模拟赛场次
    }
    return 0; 
} 
```
