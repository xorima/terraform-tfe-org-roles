# terraform-tfe-org-roles

Terraform Module to manage creation of organisation role based teams and their associated membership

This module does not handle adding users to the organisation as this may be handled by SSO, or other methods

## Restrictions

Currently this module will only create org level teams if there are members for that team, the exception is for the Registry permissions as currently the access to the private registry cannot be configured via the TFE provider. 

As a work around these teams are always created and it is up to an owner to correctly permission them
