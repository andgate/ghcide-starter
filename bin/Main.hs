module Main where

import Lib

main :: IO ()
main = do
  putStrLn "Hello world!"
  let x = 1
  putStrLn $ "1 + 1 = " ++ show (myFunc x)
