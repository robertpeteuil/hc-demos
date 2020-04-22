#!/usr/bin/env bash

# enable the key/value secrets engine at EU_GDPR_data
vault secrets enable -path=EU_GDPR_data -version=2 kv

# Write some mock data.
vault kv put EU_GDPR_data/orders/acct1 \
        order_number="12345678" product_id="987654321"


