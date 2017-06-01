{-# LANGUAGE DataKinds          #-}
{-# LANGUAGE DeriveAnyClass     #-}
{-# LANGUAGE DeriveGeneric      #-}
{-# LANGUAGE ExplicitNamespaces #-}
{-# LANGUAGE OverloadedStrings  #-}
{-# LANGUAGE TypeOperators      #-}
{-# LANGUAGE RecordWildCards    #-}

import Options.Generic (Generic, ParseRecord, type (<?>)(..))

import qualified Data.Text.Lazy.IO
import qualified Dhall
import qualified Options.Generic

newtype Options = Options
    { explain :: Bool <?> "Explain error messages in detail"
    } deriving (Generic, ParseRecord)

main :: IO ()
main = do
    Options {..} <- Options.Generic.getRecord "Template text using Dhall"
    let detail = if unHelpful explain then Dhall.detailed else id
    code <- Data.Text.Lazy.IO.getContents
    text <- detail (Dhall.input Dhall.auto code)
    Data.Text.Lazy.IO.putStr text
