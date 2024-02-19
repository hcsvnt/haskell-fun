-- Let's try out some haskell beginner stuff

-- Function to add two numbers
add :: Int -> Int -> Int
add x y = x + y

-- Function to add three numbers
add3 :: Int -> Int -> Int -> Int
add3 x y z = x + y + z

-- A list of numbers (integers)
numbers :: [Int]
numbers = [1, 2, 3, 4, 5]

-- A list of strings
strings :: [String]
strings = ["Hello", "World"]

-- A list of booleans
booleans :: [Bool]
booleans = [True, False]

-- A list of lists of integers
listOfLists :: [[Int]]
listOfLists = [[1, 2, 3], [4, 5, 6]]

-- A list of mixed number types (Int and Double)
mixedNumbers :: [Double]
mixedNumbers = [1, 2.0, 3, 4.0]

-- A function that takes a list of integers and returns the sum of the list
-- sumList :: [Int] -> Int sumList []       = 0 sumList (x : xs) = x + sumList
-- xs sumList (x: xs) = foldr(x)

-- How to replicate a data structure resembling an object? Use a record syntax
data Person = Person
  { name   :: String,
    age    :: Int,
    height :: Double,
    weight :: Double
  }
  deriving (Show)

{-  Type vs Typeclass A type is a kind of label that every value has. It tells
    us in which category of things that value fits. For example, Bool is a type
    that represents boolean values, Int is a type that represents integer
    values, and String is a type that represents string values. A typeclass is a
    sort of interface that defines some behavior. If a type is a part of a
    typeclass, that means that it supports and implements the behavior the
    typeclass describes. For example, the Eq typeclass provides an interface for
    testing equality. Any type where it makes sense to test equality between two
    values of that type should be a member of the Eq typeclass.
-}

-- An example person
person :: Person
person =
  Person
    { name = "John Doe",
      age = 25,
      height = 1.75,
      weight = 75.0
    }

{-  Deriving, Show In Haskell, deriving (Show) automatically makes the Person
    type an instance of the Show typeclass. The Show typeclass is used for types
    that can be converted to a string representation, typically for debugging
    purposes. By deriving Show, you're telling Haskell to automatically generate
    a sensible default implementation of the show function (which converts a
    value to a string) for the Person type. This means you can print or display
    Person values in the terminal or use them in any other context where a
    string representation is needed. Here's an example of how you can use it: In
    this example, print johnDoe will print a string representation of johnDoe to
    the terminal. This is possible because Person is an instance of Show due to
    the deriving (Show) clause.
-}

-- A function that takes a person and returns a string
personToString :: Person -> String
personToString (Person name age height weight) = "Name: " ++ name ++ ", Age: " ++ show age ++ ", Height: " ++ show height ++ ", Weight: " ++ show weight

-- Increase a number by 1
increment :: Int -> Int
increment x = x + 1

-- Increase all numbers in a list by 1 incrementAll :: [Int] -> [Int]

{- foldr function: takes a function, a starting value and a list and applies the
    function to the starting value and the first element of the list, then
    applies the function to the result of the previous application and the
    second element of the list and so on until the list is exhausted
-}

-- base case - if the string is empty, return an empty string doubleCharString
-- [] = [] and then doubleCharString x = whatever

-- Codewars: Duble Char - Given a string, you have to return a string in which
-- each character (case-sensitive) is repeated once.

example :: String
example = "String"

doubleChar :: Char -> [Char]
doubleChar x = [x, x]

doubleCharString :: String -> String
doubleCharString = concatMap doubleChar

{-
    Or we can define the helper function somewhat along the way if it isn't used
    elsewhere:

    doubleCharString :: String -> String doubleCharString = concatMap doubleChar
    where doubleChar :: Char -> [Char] doubleChar x = [x, x]
-}

-- Codewars: Count of positives, sum of negatives
{- Given an array of integers. Return an array, where the first element is the
    count of positives numbers and the second element is sum of negative
    numbers. 0 is neither positive nor negative. If the input is an empty array
    or is null, return an empty array.
 -}


-- countPositivesSumNegatives [] = [] - this won't work
countPositivesSumNegatives :: Maybe [Int] -> [Int]
countPositivesSumNegatives (Just []) = []
countPositivesSumNegatives Nothing   = []
countPositivesSumNegatives (Just xs) = [countPositives xs, sumNegatives xs]
    where
        countPositives :: [Int] -> Int
        countPositives xs = length (filter (> 0) xs)

        sumNegatives :: [Int] -> Int
        sumNegatives xs = sum (filter (< 0) xs)

-- Note: it needs to be called as countPositivesSumNegatives (Just[1, 2, -4,
-- -1]), to be able to handle the Nothing calls, why.


{- Maybe - optional value In Haskell, Maybe is a type that represents an
    optional value. A value of type Maybe a can either be Just something, where
    something is of type a, or Nothing.

    Here's a brief explanation of the two constructors:

    Just something: This represents a value of type a. For example, Just "hello"
    is a Maybe String, and Just 3 is a Maybe Int.

    Nothing: This represents the absence of a value. It's used when there's no
    sensible value to return or when an error occurred, but you don't want to
    throw an exception.
 -}


-- CodeWars - Fake Binary Given a string of digits, you should replace any digit
-- below 5 with '0' and any digit 5 and above with '1'. Return the resulting
-- string.

fakeBin :: String -> String
fakeBin = map(\x -> if x <'5' then '0' else '1')


-- Codewars - Total amount of points
    -- Points are awarded for each match as
    -- follows: if x > y: 3 points (win)
    -- if x < y: 0 points (loss)
    -- if x = y: 1 point (tie)
    -- For example: ["3:1", "2:2", "0:1", ...]

-- 1. split "2:1" string at ":" to get a ("2", "1") tuple
-- 2. read both positions of the tuple to Ints
-- 3. compare the numbers and return a score
-- 4. map steps 1-3 over the the list of score strings

-- splitScoreString :: String -> [Char]
-- splitScoreString x = let (a, b) = take 1 x in a


-- Codewars - Square(n) Sum
-- Complete the square sum function so that it squares each number passed into
-- it and then sums the results together.

squareSum :: [Int] -> Int
-- squareSum xs = sum (map (^2) xs) - is equivalent to (and better practice than)
squareSum xs = sum (map (\x -> x * x) xs)

-- Codewars - Sentence Smash
-- Write a function that takes an array of words and smashes them together into
-- a sentence and returns the sentence. You can ignore any need to sanitize
-- words or add punctuation, but you should add spaces between each word. Be
-- careful, there shouldn't be a space at the beginning or the end of the
-- sentence! ex ['hello', 'world', 'this', 'is', 'great']  =>  'hello world this
-- is great'

smash :: [String] -> String
smash = unwords

-- or

smash' :: [String] -> String
smash' []     = ""
smash' [a]    = a
smash' (x:xs) = x ++ " " ++ smash xs


-- Codewars - OCR Mistakes

-- NOTE: Chars use single quotes


correct :: String -> String
correct = map correctChar
    where
        correctChar :: Char -> Char
        correctChar char
            | char == '0' = 'O'
            | char == '1' = 'I'
            | char == '5' = 'S'
            | otherwise = char


getVolumeOfCuboid :: Double -> Double -> Double -> Double
getVolumeOfCuboid x y z = x*y*z

{-
    The function getVolumeOfCuboid is already quite simple and clear. However, if
    you want to make it point-free (i.e., without explicitly mentioning the
    arguments), you can use the curry function in combination with the uncurry
    function. Here's how you can do it:

    ) In this version, curry (uncurry ((*)) . (\(x, y, z) -> (x*y, z))) is a
    point-free function that takes three arguments and returns their product. The
    curry function transforms a function on pairs into a curried function, and the
    uncurry function transforms a curried function into a function on pairs. The
    (\(x, y, z) -> (x*y, z)) function takes a triple and returns a pair where the
    first element is the product of the first two elements of the triple and the
    second element is the third element of the triple.

    Please note that this version of the function is more complex and harder to read
    than the original version. In general, it's a good idea to prefer simplicity and
    clarity over cleverness in your code.
 -}


-- Codewars - Third Angle of Triangle

otherAngle :: Int -> Int -> Int
otherAngle a b = 180 - a - b


-- Codewars - Rock, Paper, Scissors
    -- "scissors", "paper" --> "Player 1 won!"
    -- "scissors", "rock" --> "Player 2 won!"
    -- "paper", "paper" --> "Draw!"

rps :: String -> String -> String
rps p1 p2
    | p1 == p2 = "Draw!"
    | p1 == "scissors" && p2 == "rock" = "Player 2 won!"
    | p1 == "scissors" && p2 == "paper" = "Player 1 won!"
    | p1 == "paper" && p2 == "scissors" = "Player 2 won!"
    | p1 == "paper" && p2 == "rock" = "Player 1 won!"
    | p1 == "rock" && p2 == "paper" = "Player 2 won!"
    | p1 == "rock" && p2 == "scissors" = "Player 1 won!"


-- Codewars - Repeat a String

-- NOTE: correct way to compose functions!!!

repeatStr :: Int -> String -> String
repeatStr n str = concat (replicate n str)
