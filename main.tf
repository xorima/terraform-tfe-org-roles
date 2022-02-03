# Owner role must always exist
# And we do not want to manage the team in TF, just membership

data "tfe_team" "owners" {
  name         = "owners"
  organization = var.organization
}

data "tfe_organization_membership" "owners_team_member" {
  for_each     = local.owners_members
  organization = var.organization
  email        = each.key
}

resource "tfe_team_organization_member" "owners_team_members" {
  for_each                   = data.tfe_organization_membership.owners_team_member
  team_id                    = data.tfe_team.owners.id
  organization_membership_id = each.value.id
}

# Other teams are only created when required

resource "tfe_team" "policy" {
  count        = length(local.policy_members) == 0 ? 0 : 1
  name         = "organization-manage-policies"
  organization = var.organization
  organization_access {
    manage_policies = true
  }
}
data "tfe_organization_membership" "policy_team_member" {
  for_each     = local.policy_members
  organization = var.organization
  email        = each.key
}
resource "tfe_team_organization_member" "policy_team_member" {
  for_each                   = data.tfe_organization_membership.policy_team_member
  team_id                    = tfe_team.policy[0].id
  organization_membership_id = each.value.id
}

resource "tfe_team" "policy_override" {
  count        = length(local.policy_override_members) == 0 ? 0 : 1
  name         = "organization-manage-policy-overrides"
  organization = var.organization
  organization_access {
    manage_policy_overrides = true
  }
}

data "tfe_organization_membership" "policy_override_team_member" {
  for_each     = local.policy_override_members
  organization = var.organization
  email        = each.key
}

resource "tfe_team_organization_member" "policy_override_team_member" {
  for_each                   = data.tfe_organization_membership.policy_override_team_member
  team_id                    = tfe_team.policy_override[0].id
  organization_membership_id = each.value.id
}

resource "tfe_team" "workspace" {
  count        = length(local.workspace_members) == 0 ? 0 : 1
  name         = "organization-manage-workspaces"
  organization = var.organization
  organization_access {
    manage_workspaces = true
  }
}
data "tfe_organization_membership" "workspace_team_member" {
  for_each     = local.workspace_members
  organization = var.organization
  email        = each.key
}
resource "tfe_team_organization_member" "workspace_team_member" {
  for_each                   = data.tfe_organization_membership.workspace_team_member
  team_id                    = tfe_team.workspace[0].id
  organization_membership_id = each.value.id
}

resource "tfe_team" "vcs" {
  count        = length(local.vcs_members) == 0 ? 0 : 1
  name         = "organization-manage-vcs"
  organization = var.organization
  organization_access {
    manage_vcs_settings = true
  }
}
data "tfe_organization_membership" "vcs_team_member" {
  for_each     = local.vcs_members
  organization = var.organization
  email        = each.key

}
resource "tfe_team_organization_member" "vcs_team_member" {
  for_each                   = data.tfe_organization_membership.vcs_team_member
  team_id                    = tfe_team.vcs[0].id
  organization_membership_id = each.value.id
}

# The provider and Registry are currently considered "Broken" as there is no API to permission these
# So consumers will have to manually permission there
# Hence the only create if required has been disabled.

resource "tfe_team" "provider" {
  name         = "organization-manage-providers"
  organization = var.organization
}
data "tfe_organization_membership" "provider_team_member" {
  for_each     = local.provider_members
  organization = var.organization
  email        = each.key
}
resource "tfe_team_organization_member" "provider_team_member" {
  for_each                   = data.tfe_organization_membership.provider_team_member
  team_id                    = tfe_team.provider.id
  organization_membership_id = each.value.id
}

resource "tfe_team" "module" {
  name         = "organization-manage-modules"
  organization = var.organization
}
data "tfe_organization_membership" "module_team_member" {
  for_each     = local.module_members
  organization = var.organization
  email        = each.key
}
resource "tfe_team_organization_member" "module_team_member" {
  for_each                   = data.tfe_organization_membership.module_team_member
  team_id                    = tfe_team.module.id
  organization_membership_id = each.value.id
}
