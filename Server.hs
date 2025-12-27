{-# LANGUAGE DataKinds #-}
{-# LANGUAGE TypeOperators #-}
{-# LANGUAGE OverloadedStrings #-}

module Server where

import           Network.Wai
import           Network.Wai.Handler.Warp
import           Servant
import           Data.Text (Text)

type API =
       "status" :> Get '[PlainText] Text

server :: Server API
server = pure "Backend running successfully"

api :: Proxy API
api = Proxy

app :: Application
app = serve api server

main :: IO ()
main = run 8080 app
