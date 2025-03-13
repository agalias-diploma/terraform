# This terraform config is specified for managing DNS via AWS Route53

**NOTE:** This Terraform shouldn't change. The domain name is purchased on [GoDaddy](https://www.godaddy.com/) and the name is `agalias-project.online`

The Route53 is provisioned once to create one hosted zone, and generated AWS nameservers is replaced in GoDaddy to use custom AWS routes instead of auto-generated GoDaddy nameservers. The design is to use Route53, but never run `terraform destroy` command. Or if we need to do so, we need to make a DNS delegation and after save new routes in GoDaddy account.
