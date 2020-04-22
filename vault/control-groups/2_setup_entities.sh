#!/usr/bin/env bash

# Enable the userpass auth method.
# vault auth enable userpass

# Create a new user, bob with password, "training".
vault write auth/userpass/users/bob password="training"

# Create a new user, ellen with password, "training".
vault write auth/userpass/users/ellen password="training"

# Retrieve the userpass mount accessor and save it in a file named accessor.txt
vault auth list -format=json | jq -r '.["userpass/"].accessor' > accessor.txt


# Create Bob Smith entity and save the identity ID in the entity_id_bob.txt
vault write -format=json identity/entity name="Bob Smith" \
        policies="read-gdpr-order" \
        metadata=team="Processor" \
        | jq -r ".data.id" > entity_id_bob.txt

# Add an entity alias for the Bob Smith entity
vault write identity/entity-alias name="bob" \
      canonical_id=$(cat entity_id_bob.txt) \
      mount_accessor=$(cat accessor.txt)


# Create Ellen Wright entity and save the identity ID in the entity_id_ellen.txt
vault write -format=json identity/entity name="Ellen Wright" \
        policies="default" \
        metadata=team="Acct Controller" \
        | jq -r ".data.id" > entity_id_ellen.txt

# Add an entity alias for the Ellen Wright entity
vault write identity/entity-alias name="ellen" \
      canonical_id=$(cat entity_id_ellen.txt) \
      mount_accessor=$(cat accessor.txt)


# create acct_manager group and add Ellen Wright entity as a member
vault write identity/group name="acct_manager" \
    policies="acct_manager" \
    member_entity_ids=$(cat entity_id_ellen.txt)


