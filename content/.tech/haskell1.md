+++
 title = "learn my haskell vol.1" 
 date = "2022-12-30T17:40:48+08:00" 
 tags = ["haskell"] 
 slug = "haskell1"
 gitinfo = true
 align = false
+++

about this note 1: some modules and codewars questions

### Modules Codes
``` haskell
import Data.List
import Data.Char

search needle haystack =
    let nlen = length needle
    in foldl (\acc x -> if take nlen x == needle then True else acc) False $ tails haystack

-- intersperse function
myIntersperse :: a -> [a] -> [a]
myIntersperse y = drop 1 . foldr (\x acc ->  y: x: acc ) []  

-- intercalate function
-- myIntercalate :: [a] -> [a] -> [a]
myIntercalate xs yss = drop (length xs) $ foldr (\as acc -> xs ++ as ++ acc) [] yss 

-- tanspose function
-- myTanspose

-- concat function
myConcat xss = foldr (\as acc -> as ++ acc) [] xss

-- a codewars question
findMidIndex :: (Num a, Ord a) => [a] -> Int
findMidIndex xs = length boollist 
    where taillist = tail . map sum . inits $ xs
          headlist = init . map sum . tails $ xs
          boollist = takeWhile (/= True) $ zipWith (==) taillist headlist

-- codewars
findNextSquare :: Integer -> Integer
findNextSquare n 
    | ispefect truen = truncate $ head $ filter ispefect [truen + 1..]
    | otherwise = -1
    where truen = fromInteger n

-- ispefect :: Integer -> Bool
ispefect x = fromIntegral (truncate . sqrt $ x)^2 == x   

--codewars
rowSumOddNumbers :: Int -> Integer
rowSumOddNumbers x = sum $ take x $ drop (sum [1..x-1]) [1, 3..]

-- https://www.codewars.com/kata/546e2562b03326a88e000020/train/haskell
squareDigit :: Int -> Int
squareDigit it 
    | it < 0 = negate $ proc (negate it)
    | otherwise = proc it
    where proc i = read (concatMap (show . (^2)) . intToListWithShow $ i) :: Int

-- 2 function about exchange a number into a list

intToListWithShow :: Int -> [Int]
intToListWithShow = map digitToInt . show

-- pure mathmatic, so I think it has high perfermence
intToList :: Integral a => a -> [a]
intToList x  = case x of
    0 -> [0]
    a | a < 0 -> reverse . toList . negate $ a 
    a -> reverse . toList $ a 
    where toList 0 = []
          toList a = mod a 10 : (toList . quot a $ 10) 

-- determining weather a number is prime
isPrime :: Integer -> Bool
isPrime x = case x of
    x | x <= 1 -> False
    2 -> True 
    _ -> all (\a -> mod x a /= 0) (2 : [ x | x <- [2..truncate . sqrt . fromInteger $ x], odd x])

-- compute the number of digits
countNumOfDigit :: Int -> Int
countNumOfDigit 0 = 0
countNumOfDigit x = 1 + (countNumOfDigit . quot x $ 10)

-- codewars
duplicateEncode :: String -> String
duplicateEncode xs = map encode xs'
    where xs' = map toLower xs
          encode x = if (length . filter (== x) $ xs') > 1 then ')' else '('

-- Sorry for the name of the function.
inArray :: [String] -> [String] -> [String]
inArray a1 a2 = foldr (\x acc -> if search x $ unwords a2 then x : acc else acc ) [] a1

-- search needle haystack =
    -- let nlen = length needle
    -- in foldl (\acc x -> if take nlen x == needle then True else acc) False $ tails haystack

perimeter :: Integer -> Integer
perimeter x = 4 * (sum . take (fromInteger x + 1) $ fibs) :: Integer

fibs :: [Integer]
fibs = 1 : 1 : zipWith (+) fibs (drop 1 fibs) 


rot13 :: String -> String
rot13 = map rot where
    rot 'm' = 'z'
    rot 'M' = 'Z'
    rot x
        | isAlpha x && ord x > 96 = chr (96 + mod (ord x - 96 + 13) 26) 
        | isAlpha x && ord x < 91 = chr (64 + mod (ord x - 64 + 13) 26)
        | otherwise = x


```
### CodeWars Questions

 ##### Maximum subarray sum

The maximum sum subarray problem consists in finding the maximum sum of a contiguous subsequence in an array or list of integers:

``` 
maxSequence [-2, 1, -3, 4, -1, 2, 1, -5, 4]
-- should be 6: [4, -1, 2, 1]
```
Easy case is when the list is made up of only positive numbers and the maximum sum is the sum of the whole array. If the list is made up of only negative numbers, return 0 instead.

Empty list is considered to have zero greatest sum. Note that the empty list or array is also a valid sublist/subarray.

```` haskell
-- Maximum Subarray
maxSequence :: [Int] -> Int
maxSequence = maximum . scanl (\acc x -> max 0 acc + x) 0
-- 我靠，这串代码太牛了

maxSubArray1 :: (Num a, Ord a) => [a] -> [a]
maxSubArray1 ls = head [a | a <- allSubArray, sum a == maximum (map sum allSubArray)]  where
    allSubArray = [ y | x <- okls, y <- x, sum y == maximum (map sum x)]
    okls = map inits $ tails ls
-- https://www.codewars.com/kata/54521e9ec8e60bc4de000d6c/train/haskell
maxSequence' :: [Int] -> Int
maxSequence' ls =  maximum (map sum allSubArray)  where
    allSubArray = [ y | x <- okls, y <- x, sum y == maximum (map sum x)]
    okls = map inits $ tails ls
````

##### Write Number in Expanded Form
You will be given a number and you will need to return it as a string in Expanded Form. For example:

````
expandedForm 12    -- Should return '10 + 2'
expandedForm 42    -- Should return '40 + 2'
expandedForm 70304 -- Should return '70000 + 300 + 4'
````

NOTE: All numbers will be whole numbers greater than 0.

If you liked this kata, check out part 2!!

``` haskell
expandedForm :: Int -> String
expandedForm = drop 3 . process . show  where
    process [] = []
    process (x: xs) = expandList ++ process xs  where 
        expandList = if x /= '0' then " + " ++ x : replicate (length xs) '0' else [] 
```