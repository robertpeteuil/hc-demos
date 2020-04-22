#!/usr/bin/env bash

unset VAULT_TOKEN

# login as bob
vault login -method=userpass username="bob" password="training"

# Request to read "EU_GDPR_data/orders/acct1"
vault kv get -format=json EU_GDPR_data/orders/acct1 > cg_request.json

WRAP_TOKEN=$(cat cg_request.json | jq -r ".wrap_info.token")

ACCESSOR=$(cat cg_request.json | jq -r ".wrap_info.accessor")