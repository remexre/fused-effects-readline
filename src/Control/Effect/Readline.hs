{-# LANGUAGE DeriveFunctor, DeriveGeneric #-}
module Control.Effect.Readline
( -- * Readline effect
  Readline(..)
, prompt
  -- * Re-exports
, Algebra
, Has
, run
) where

import Control.Algebra
import Data.Text.Prettyprint.Doc
import Data.Text.Prettyprint.Doc.Render.Terminal
import GHC.Generics (Generic1)

prompt :: Has Readline sig m => String -> m (Int, Maybe String)
prompt p = send (Prompt p (curry pure))


data Readline m k
  = Prompt String (Int -> Maybe String -> m k)
  | Print (Doc AnsiStyle) (m k)
  deriving (Functor, Generic1)

instance HFunctor Readline
instance Effect   Readline
