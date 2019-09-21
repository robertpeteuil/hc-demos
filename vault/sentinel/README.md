# Demonstrate Sentinel Policies on Vault

Requires manually creating Sentinel Policies via the Vault UI: [Vault Sentinel Policies](<https://github.com/hashicorp/vault-guides/tree/master/governance/validation-policies>)

AFter creatint the four Sentinel EGP policies:

- Run the script `1-test-sentinel-egp.sh`
  - creates a test kv location
  - create access policy for kv
  - creates temporary token using new access policy
  - shows pass & fail examples of Zip Code Sentinel Policy
  - shows pass & fail examples of State Sentinel Policy
  - shows pass & fail examples of AWS Credentials Sentinel Policy
  - shows pass & fail examples of Azure Credentials Policy
