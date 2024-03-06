module Parser (
  parseExpression
  ) where

import Text.Parsec
import Text.Parsec.String (Parser)
import Text.Parsec.Token (integer, parens)
import Text.Parsec.Language (haskellDef)
import Text.Parsec.Expr
import qualified Text.Parsec.Token as Token
import Control.Monad (liftM)
import ArithmeticExpression

lexer = Token.makeTokenParser haskellDef

int = Token.integer lexer
parens = Token.parens lexer
whiteSpace = Token.whiteSpace lexer

binary s f = Infix (do{ Token.reservedOp lexer s; return f })

table = [[binary "*" Mult AssocLeft, binary "/" Div AssocLeft],
         [binary "+" Sum AssocLeft],
         [binary "^" Pow AssocRight]]

term = Parser.parens expression
  <|> fmap (Val . fromIntegral) Parser.int

expression = buildExpressionParser table term

parseExpression :: String -> Either ParseError Expression
parseExpression = parse (whiteSpace *> expression <* eof) ""
