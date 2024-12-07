+++
 title = "backpacks modle" 
 date = "2023-03-20T21:05:48+08:00" 
 tags = ["algorithms"] 
 slug = "backpacks_dynamicPrograming"
 align = false
 katex = true
+++
### backpack module of dynamic programing 

#### zero-one backpacks

naive algorithms
``` 
-- state transtion equation
f[i][j] = max(f[i - 1][j], f[i - 1][j - v] + w)
```

optimize the space complexity:
``` 
for (int j = V; j >= v[i]; i--) {
	f[j] = std::max(f[j], f[j - v[i]] + w[i]);
}
```
#### full backpacks

for full backpacks question, every item can be selected an infinite number of times.

for every state, the equation is 
```
f[i][j] = max(f[i - 1][j], f[i - 1][j - v] + w, f[i - 1][j - 2v] + 2w, ... , f[i - 1][j - kv] + kw)
```

we have:
```
f[i][j - v] = max(f[i - 1][j - v], f[i - 1][j - 2v] + w, .... f[i - 1][j - kv] + (k - 1)w)
```

so:
``` 
f[i][j] = max(f[i - 1][j], f[i][j - v] + w)
```
so far, we can note the equation is similar to zero-one backpacks equation, so we can write a similar code of naive algorithm
``` 
for (int i = 1; i <= N; i++) {
	for (int j = 0; j <= V; j++) {
		f[i][j] = f[i - 1][j];
		if (j >= v[i]) f[i][j] = max(f[i][j], f[i][j - v[i]] + w[i]);
	}
}
```

and similarly, we can also optimize the space complexity

```
for (int i = 1; i <= N; i++) {
	for (int j = v[i]; j <= V; j++) {
		f[j] = max(f[j], f[j - v[i]] + w);
	}
}
```

#### multiple backpacks

In this modle, every kind of item can be selected a fix number of times. It is similar to zero-one backpacks that for every item, we just need nest a loop on zero-one bcakpacks code, but it is so ineffective, we can do better on it.

##### binary optimization

```
int maxn = 1000 + 10;
int num, worth, volume, cnt = 1;
int volumes[maxn], worths[maxn], f[maxn][maxn];

for (int i = 1; i < num; i <<= 1, cnt += 1) {
	volumes[cnt] = i * volume;
	worths[cnt] = i * worth;
}
if (num) {
	volumes[++cnt] = num * volume;
	worths[cnt] = num * worth;
}
```

take a example: if we have 37 a items, the number 37 can divide into [1, 2, 4, 8, 16, 6], and every number that less than 37 can combined by the list's elements. 

and so far, we can process rest question in zero-one modle;


#### mixd backpacks

the question mixd with zero-one backpacks, full-backpacks and multiple backpacks(also from zero-one modle), we just transform the input into below modle and store transformed data, finally we just transfer the correspond equation on demand.



