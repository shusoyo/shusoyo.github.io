+++
 title = "learn my haskell vol.0" 
 date = "2022-12-24T21:40:48+08:00" 
 tags = ["haskell"] 
 slug = "haskell"
 gitinfo = true
 align = false
+++


```` haskell
doubleMe x = x * 2
doubleUs x y = doubleMe x + doubleMe y
doubleSmallNumber x = if x > 100
                      then x
                      else x * 2
doubleSmallNumber' x = (if x > 100 then x else x * 2) + 1

lucky :: Integral a => a -> String
lucky 7 = "LUCKY NUMBER SEVEN"
lucky _ = "sorry, you are out of lucky"

-- factorial recursion version
factorial :: (Integral a) => a -> a
factorial 0 = 1
factorial n = n * factorial (n - 1)

-- factorial product function version
factorial' :: Integral a => a -> a
factorial' x = product [1..x]

point_add :: Num a => (a, a) -> (a, a) -> (a, a)
point_add (a, b) (c, d) = (a + c, b + d) 

head' :: [a] -> a
head' [] = error "error"
head' (x: _)  = x

length' :: Num a => [b] -> a
length' [] = 0
length' (_: xs) = 1 + length' xs

sum' :: Num a => [a] -> a
sum' [] = 0
sum' (x: xs) = x + sum' xs

bmi_tell :: (RealFloat a) => a -> a -> String
bmi_tell weight height
    | bmi <= 18.5 = "underweight"
    | bmi <= 25.0 = "normal"
    | bmi <= 30.0 = "fat"
    | otherwise   = "whale"
    where bmi = weight / height ^ 2

bmi_tell' :: (RealFloat a) => a -> String
bmi_tell' bmi
    | bmi <= 18.5 = "underweight"
    | bmi <= 25.0 = "normal"
    | bmi <= 30.0 = "fat"
    | otherwise   = "whale"

calcbmis :: RealFloat a => [(a, a)] -> [a]
calcbmis xs = [bmi w h | (w, h) <- xs]
    where bmi weight height = weight / height ^ 2

calcbmis' :: RealFloat a => [(a, a)] -> [a]
calcbmis' xs = [ bmi | (w, h) <- xs, let bmi = w / h ^ 2 ]

myDrop n xs = if n <= 0 || null xs
              then xs
              else myDrop (n - 1) (tail xs) 

-- about recursion 
maximum' :: Ord a => [a] -> a
maximum' [] = error "maximum of a empty list"
maximum' [x] = x
maximum' (x: xs) = max x (maximum' xs)

replicate' :: (Num a, Ord a) => a -> b -> [b]
replicate' n x
    | n <= 0 = []
    | otherwise = x : replicate' (n - 1) x

take' :: (Ord a, Num a)=> a -> [b] -> [b]
take' n _
    | n <= 0 = []
take' _ [] = []
take' n (x: xs) = x: take' (n - 1) xs

reverse' :: [a] -> [a]
reverse' [] = []
reverse' (x: xs) = reverse' xs ++ [x]

repeat' :: a -> [a]
repeat' x = x: repeat' x

zip' :: [a] -> [b] -> [(a, b)]
zip' _ [] = []
zip' [] _ = []
zip' (x: xs) (y: ys) = (x, y): zip' xs ys

elem' :: Eq a => a -> [a] -> Bool
elem' a [] = False
elem' a (x: xs) 
    | a == x = True
    | otherwise = elem' a xs



-- quick sort
quicksort :: Ord a => [a] -> [a]
quicksort [] = []
quicksort (x: xs) =
    let smallerSorted = quicksort [a | a <- xs, a <= x]
        biggerSorted = quicksort [a | a <- xs, a >= x]
    in smallerSorted ++ [x] ++ biggerSorted


-- high-order function
zipWith' :: (a -> b -> c) -> [a] -> [b] -> [c]
zipWith' _ [] _ = []
zipWith' _ _ [] = []
zipWith' f (x: xs) (y: ys) = f x y : zipWith' f xs ys


-- fib =  fib(n) = fib(n - 1) + fib(n - 2)
fibs :: [Integer]
fibs = 1 : 1 : zipWith (+) fibs (drop 1 fibs)

--  Collatz 串行
-- function chain
chain :: Integral a => a -> [a]
chain 1 = [1]
chain x 
    | even x = x: chain (div x 2)   
    | odd x = x: chain (3 * x + 1)             
         
-- number of chains which length biger than 15 -- where version
numLongChains :: Int
numLongChains = length (filter isLong (map chain [1..100]))
    where isLong xs = length xs > 15 

-- lambda version
-- lambda experssion is (\xs -> length xs > 15)
-- (\ + 参数 -> 函数体)
numLongChains' :: Int
numLongChains' = length (filter (\xs -> length xs > 15) (map chain [1..100]))

-- fold
-- foldl 跟着一个两个参数的匿名函数
-- 一个是初始值，一个是折叠项，两个参数传入匿名函数中
-- 然后执行匿名函数中的操作
sum'' :: Num a => [a] -> a
sum'' xs = foldl (\acc x -> acc + x) 0 xs

-- fold and curried
-- 函数的柯里化
sum''' :: Num a => [a] -> a
sum''' = foldl (+) 0

length'' :: [a] -> Int
length'' xs = foldl (\acc x -> acc + 1) 0 xs

myElem :: Eq a => a -> [a] -> Bool
myElem x xs = foldl (\acc y -> if y == x then True else acc) False xs

myFoldl :: (a -> b -> a) -> a -> [b] -> a
myFoldl f acc [] = acc
myFoldl f acc (x: xs) = myFoldl f (f acc x) xs 

myMap :: (a -> b) -> [a] -> [b]
myMap f xs = foldr (\x acc -> f x : acc) [] xs

-- `++` 运算符性能很差
myMapLfold :: (a -> b) -> [a] -> [b]
myMapLfold f xs = foldl (\acc x -> acc ++ [f x]) [] xs

myMaximum :: Ord a => [a] -> a
-- myMaximum xs = foldl1 (\acc x -> if x > acc then x else acc) xs
myMaximum = foldl1 (\acc x -> if x > acc then x else acc) 

myReverse :: [a] -> [a]
myReverse = foldl (\acc x -> x: acc) []

myProduct :: Num a => [a] -> a
myProduct = foldl1 (*)

myFilter :: (a -> Bool) -> [a] -> [a]
myFilter f = foldr (\x acc -> if f x then x: acc else acc) []

-- just show, because fold method have tarverse the list
myHead :: [a] -> a
myHead = foldr1 (\x _ -> x)

myList :: [a] -> a
myList = foldl1 (\_ x -> x)
````