#!/usr/bin/env bash

# Create a new policy named read-gdpr-order
vault policy write read-gdpr-order read-gdpr-order.hcl

# Create a new policy named acct_manager
vault policy write acct_manager acct_manager.hcl


