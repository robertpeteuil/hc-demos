# KV V1 Blanket policy
path "secret/*"
{
  capabilities = ["create", "read", "update", "delete", "list"]
}

# KV V2 Blanket Policies:

# Allow full access to the current version of the kv
path "secret/data/*"
{
  capabilities = ["create", "read", "update", "delete", "list"]
}

path "secret/data/*"
{
  capabilities = [ "read", "list"]
}


# Allow deletion of any kv version
path "secret/delete/*"
{
  capabilities = ["update"]
}

# Allow un-deletion of any kv version
path "secret/undelete/*"
{
  capabilities = ["update"]
}

# Allow destroy of any kv version
path "secret/destroy/*"
{
  capabilities = ["update"]
}

# Allow list and view of metadata and to delete all versions and metadata for a key
path "secret/metadata/*"
{
  capabilities = ["list", "read", "delete"]
}
