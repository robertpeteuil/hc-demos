#!/usr/bin/env bash

. env.sh

pe "vault policy list"

pe "vault policy read default"

pe "vault policy write full-kv policies/full-kv-policy.hcl"

# vault write auth/userpass/users/<username> password=<password> policies=<super-admin>
