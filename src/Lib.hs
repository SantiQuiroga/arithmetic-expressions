module Lib
    ( someFunc
    ) where

import ArithmeticExpression
import ExpressionEvaluator

someFunc :: IO ()
someFunc = print (evalExpression (Sum (Val 8)(Val 3)))
