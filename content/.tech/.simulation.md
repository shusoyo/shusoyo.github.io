+++
 title = "几个高精度" 
 date = "2023-01-20T21:40:48+08:00" 
 tags = ["C","alogrithmes"] 
 slug = "simulations"
 gitinfo = true
 align = false
+++

### 高精度加法

``` cpp
#include <bits/stdc++.h>
using namespace std;

int main() {
    ios::sync_with_stdio(false);
    string a1, b1;
    int a[505] = {0}, b[505] = {0}, c[600] = {0};
    cin >> a1 >> b1;
    // convert char into single digit and put it into a array reversely
    for (int i = 1; i <= a1.length(); i++)
        a[i] = a1[a1.length() - i] - '0';
    for (int i = 1; i <= b1.length(); i++)
        b[i] = b1[b1.length() - i] - '0';
    // let maxlen equal to the bigger length
    // tlen equal to the sum length
    int maxlen = b1.length() > a1.length() ? b1.length() : a1.length(),
        tlen = b1.length() + a1.length();
    // plus the each single digit, don't care whether the sum is bigger 10, put
    // it into c array
    for (int i = 1; i <= maxlen; i++) {
        c[i] = b[i] + a[i];
    }
    // trave c array and find element that bigger than 10, and c[i] = mod it
    // with 10 c[i + 1] = c[i+1] + c[i] / 10
    for (int i = 1; i <= maxlen; i++) {
        if (c[i] > 9) {
            c[i + 1] += c[i] / 10;
            c[i] %= 10;
        }
    }
    // clean the 0
    while (c[tlen] == 0 && tlen > 1) {
        tlen--;
    }
    // print the tar number array
    for (int i = tlen; i > 0; i--) {
        cout << c[i];
    }
    return 0;
}
```

### 高精度乘法

``` cpp
#include <bits/stdc++.h>

using namespace std;
int num_a[10001] = {0}, num_b[10001] = {0}, c[10001] = {0};

string a, b;
int main() {
    cin >> a >> b;
    // convert char into digit and put a array reversely
    for (int i = 1; i <= a.length(); i++)
        num_a[i] = a[a.length() - i] - '0';
    for (int i = 1; i <= b.length(); i++)
        num_b[i] = b[b.length() - i] - '0';

    // double loop
    // i + j - 1 is 错位
    for (int i = 1; i <= b.length(); i++)
        for (int j = 1; j <= a.length(); j++)
            c[i + j - 1] += num_b[i] * num_a[j];
    // 这两个for循环是算法关键，模拟竖式运算

    // 进位
    for (int i = 1; i < b.length() + a.length(); i++)
        if (c[i] > 9) {
            c[i + 1] += c[i] / 10;
            c[i] %= 10;
        }

    int lenc = a.length() + b.length();
    while (c[lenc] == 0 && lenc > 1)
        lenc--;
    for (int i = lenc; i > 0; i--)
        cout << c[i];
    return 0;
}
```

### 高精度阶乘之和
高精度乘 + 高精度加法，简单的组合

``` cpp
#include <bits/stdc++.h>
using namespace std;

int a[100], b[101] = {0};

void mult(int x) {
    int cur = 0;
    for (int i = 1; i < 100; i++) {
        a[i] = a[i] * x + cur;
        cur = a[i] / 10;
        a[i] = a[i] % 10;
    }
}
void allplus() {
    int cur = 0;
    for (int i = 1; i < 100; i++) {
        b[i] = b[i] + a[i] + cur;
        cur = b[i] / 10;
        b[i] = b[i] % 10;
    }
    b[100] = cur;
}
int main() {
    int n;
    a[1] = 1, b[1] = 1;
    cin >> n;
    for (int i = 2; i <= n; i++) {
        for (int o = 2; o < 100; o++) {
            a[o] = 0;
        }
        a[1] = 1;
        for (int j = 1; j <= i; j++) {
            mult(j);
        }
        allplus();
    }
    int len = 100;
    while (b[len] == 0 && len > 1) {
        len--;
    }
    for (int i = len; i > 0; i--) {
        cout << b[i];
    }
}
```