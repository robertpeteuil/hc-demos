#!/usr/bin/env bash

# Enable backup audit device
vault audit enable -local -path "audit_discard" file file_path=discard

# Enable File Audit Device
vault audit enable -local file file_path=/Users/robertpeteuil/vault/vault-audit.json




