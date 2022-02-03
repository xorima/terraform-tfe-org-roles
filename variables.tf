variable "organization" {
  type        = string
  description = "The name for the organisation"
}

variable "owner_member_emails" {
  type        = list(string)
  description = "A list of email addresses for users who should have Owner rights across the entire Organisation. This grants them full access to everything"
}

variable "policy_member_emails" {
  type        = list(string)
  description = "A list of email addresses for users who should have the Manage Policies rights across the entire Organisation. This grants members access to create, edit, and delete the organization's Sentinel policies"
  default     = []
}

variable "policy_overrides_member_emails" {
  type        = list(string)
  description = "A list of email addresses for users who should have the Manage Policy Overrides rights across the entire Organisation. This grants members access to override soft-mandatory policy checks"
  default     = []
}

variable "workspace_member_emails" {
  type        = list(string)
  description = "A list of email addresses for users who should have the Manage Workspaces rights across the entire Organisation. This grants members access to to create and administrate all workspaces within the organization"
  default     = []
}

variable "vcs_member_emails" {
  type        = list(string)
  description = "A list of email addresses for users who should have the Manage VCS Settings rights across the entire Organisation. This grants members access to manage the organization's VCS Providers and SSH keys"
  default     = []
}

variable "provider_member_emails" {
  type        = list(string)
  description = "A list of email addresses for users who should have the Manage Provides rights across the entire Organisation. This grants members access to publish and delete providers in the organization's private registry"
  default     = []
}

variable "module_member_emails" {
  type        = list(string)
  description = "A list of email addresses for users who should have the Manage Modules rights across the entire Organisation. This grants members access to publish and delete modules in the organization's private registry"
  default     = []
}


locals {
  owners_members          = toset(var.owner_member_emails)
  policy_members          = toset(var.policy_member_emails)
  policy_override_members = toset(var.policy_overrides_member_emails)
  workspace_members       = toset(var.workspace_member_emails)
  vcs_members             = toset(var.vcs_member_emails)
  provider_members        = toset(var.provider_member_emails)
  module_members          = toset(var.module_member_emails)
}
