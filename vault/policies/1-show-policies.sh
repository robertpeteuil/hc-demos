#!/bin/bash

. env.sh
#policy-1
cat <<EOF > /tmp/policy-1.hcl
path "kv/foo" {
 capabilities = ["read"]
}
EOF
#policy-2
cat <<EOF > /tmp/policy-2.hcl
path "kv/foo" {
 capabilities = ["read", "update"]
}
EOF
#policy-3
cat <<EOF > /tmp/policy-3.hcl
path "kv/foo" {
 capabilities = ["create", "delete", "list"]
}
EOF
green "Create policies in Vault"
pe "vault policy write policy-1 /tmp/policy-1.hcl"
pe "vault policy write policy-1 /tmp/policy-2.hcl"
pe "vault policy write policy-1 /tmp/policy-3.hcl"
green "Enable userpass auth in Vault"
pe "vault auth enable userpass"
green "Create userpass user and associate with policies"
pe "vault write auth/userpass/users/cumulo password=notsosecure policies=policy-1,policy-2,policy-3"
# cyan "Enable kv secrets at kv"
green "Test policy"
pe "vault login -method=userpass username=cumulo password=notsosecure"
green "CREATE"
pe "vault kv put kv/foo user=newuser passsword=newpw"
green "READ"
pe "vault kv get kv/foo"
green "UPDATE"
pe "vault kv put kv/foo user=newuser2 passsword=newpw2"
green "DELETE"
pe "vault kv delete kv/foo"

