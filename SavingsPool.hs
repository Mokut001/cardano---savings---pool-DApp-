{-# LANGUAGE DataKinds           #-}
{-# LANGUAGE NoImplicitPrelude   #-}
{-# LANGUAGE TemplateHaskell     #-}
{-# LANGUAGE ScopedTypeVariables #-}
{-# LANGUAGE OverloadedStrings   #-}
{-# LANGUAGE TypeApplications    #-}
{-# LANGUAGE TypeOperators       #-}
{-# LANGUAGE DeriveAnyClass      #-}
{-# LANGUAGE DeriveGeneric       #-}

module SavingsPool where

import           PlutusTx
import           PlutusTx.Prelude      hiding (Semigroup(..), unless)
import           Plutus.V2.Ledger.Api
import           Prelude               (Show)

data Action = Deposit | Withdraw
PlutusTx.unstableMakeIsData ''Action

{-# INLINABLE mkValidator #-}
mkValidator :: BuiltinData -> BuiltinData -> BuiltinData -> ()
mkValidator _ redeemer _ =
    case PlutusTx.unsafeFromBuiltinData @Action redeemer of
        Deposit  -> ()
        Withdraw -> ()

validator :: Validator
validator = mkValidatorScript $$(PlutusTx.compile [|| mkValidator ||])

validatorHash :: ValidatorHash
validatorHash = validatorHash validator

validatorAddress :: Address
validatorAddress = scriptAddress validator
