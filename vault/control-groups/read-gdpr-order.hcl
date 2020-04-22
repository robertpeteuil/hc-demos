path "EU_GDPR_data/data/orders/*" {
  capabilities = [ "read" ]

  control_group = {
    factor "authorizer" {
        identity {
            group_names = [ "acct_manager" ]
            approvals = 1
        }
    }
  }
}
