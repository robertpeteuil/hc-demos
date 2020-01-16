#!/usr/bin/env bash

. env.sh

# aws policy

cat <<EOF > /tmp/use-aws.hcl
# Access to aws/
path "aws/*" {
  capabilities = ["create", "read", "update", "delete", "list"]
}
EOF

pe "vault policy write use-aws /tmp/use-aws.hcl"

p "vault token create -policy=use-aws"

vault token create -policy=use-aws -format=json | jq -r .auth.client_token > .user_token

unset VAULT_TOKEN
pe "vault login $(cat .user_token)"

green "test valid AWS EC2 policy"
pe "vault write aws/roles/all_iam credential_type=iam_user policy_document=@policies/ec2-allowed.json"

red "test prohibited AWS EC2 policy"
pe "vault write aws/roles/all_iam credential_type=iam_user policy_document=@policies/ec2-violation.json"

green "test valid AWS IAM policy"
pe "vault write aws/roles/all_iam credential_type=iam_user policy_document=@policies/iam-allowed.json"

red "test prohibited AWS IAM policy"
pe "vault write aws/roles/all_iam credential_type=iam_user policy_document=@policies/iam-violation.json"

rm .user_token
