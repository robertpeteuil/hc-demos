. env.sh

pe "vault secrets enable database"

cat << EOF
vault write database/config/vices 
    plugin_name=postgresql-database-plugin 
    allowed_roles=full-read 
    connection_url="postgresql://{{username}}:{{password}}@${DB_HOST}:${DB_PORT}/vices?sslmode=disable" 
    username="${VAULT_ADMIN_USER}" 
    password="${VAULT_ADMIN_PW}"
EOF
p ""

vault write database/config/vices \
    plugin_name=postgresql-database-plugin \
    allowed_roles=full-read \
    connection_url="postgresql://{{username}}:{{password}}@${DB_HOST}:${DB_PORT}/vices?sslmode=disable" \
    username="${VAULT_ADMIN_USER}" \
    password="${VAULT_ADMIN_PW}"



cat << EOF
vault write database/roles/full-read 
    db_name=vices 
    creation_statements="CREATE ROLE "{{name}}" WITH LOGIN PASSWORD '{{password}}' VALID UNTIL '{{expiration}}'; GRANT SELECT ON ALL TABLES IN SCHEMA public TO "{{name}}";" 
    default_ttl=${DYNAMIC_DEFAULT_TTL} 
    max_ttl=${DYNAMIC_MAX_TTL}"
EOF
p ""

vault write database/roles/full-read \
    db_name=vices \
    creation_statements="CREATE ROLE \"{{name}}\" WITH LOGIN PASSWORD '{{password}}' VALID UNTIL '{{expiration}}'; GRANT SELECT ON ALL TABLES IN SCHEMA public TO \"{{name}}\";" \
    default_ttl=${DYNAMIC_DEFAULT_TTL} \
    max_ttl=${DYNAMIC_MAX_TTL}
