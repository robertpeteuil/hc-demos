#!/bin/bash

. env.sh
# secret policy
cat <<EOF > /tmp/use-kv.hcl
# Access to kv/
path "kv/*" {
  capabilities = ["create", "read", "update", "delete", "list"]
}
EOF

pe "vault secrets enable -version=1 kv"

pe "vault policy write use-kv /tmp/use-kv.hcl"

p "vault token create -policy=use-kv"

vault token create -policy=use-kv -format=json | jq -r .auth.client_token > .user_token

unset VAULT_TOKEN
pe "vault login $(cat .user_token)"

# Zip Code Example
# pe "vault kv put kv/address zipcode=12345"
# yellow "write zip code that violates Sentinel Rule"
# pe "vault kv put kv/address zipcode=1234a"

# # State Example
# pe "vault kv put kv/address state=NY"
# yellow "write State that violates Sentinel Rule"
# pe "vault kv put kv/address state=NN"

# AWS creds example
pe "vault kv put kv/aws/config/root access_key=AAAAABBBBBCCCCCDDDDD secret_key=AAAAABBBBBCCCCCDDDDDAAAAABBBBBCCCCCDDDDD"
yellow "write AWS credentials that violates Sentinel Rule"
pe "vault kv put kv/aws/config/root access_key=AAAAA secret_key=AAAAA"

# Azure creds example
pe "vault kv put kv/azure/config subscription_id=aaaabbbb-cccc-dddd-eeee-ffffgggghhhh tenant_id=aaaabbbb-cccc-dddd-eeee-ffffgggghhhh client_id=aaaabbbb-cccc-dddd-eeee-ffffgggghhhh client_secret=aaaabbbb-cccc-dddd-eeee-ffffgggghhhh"
yellow "write Azure credentials that violates Sentinel Rule"
pe "vault kv put kv/azure/config subscription_id=AAAABBBB-CCCC-DDDD-EEEE-FFFFGGGGHHHH tenant_id=AAAAbbbb-cccc-dddd-eeee-ffffgggghhhh client_id=aaaabbbb-cccc-dddd-eeee-ffffgggghhhh client_secret=aaaabbbb-cccc-dddd-eeee-ffffgggghhhh"

rm .user_token
