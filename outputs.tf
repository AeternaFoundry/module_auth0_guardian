output "guardians_id" {
  description = "Map of id values across all guardians, keyed the same as var.guardians"
  value       = { for k, v in auth0_guardian.guardians : k => v.id }
}
output "guardians_duo" {
  description = "Map of duo values across all guardians, keyed the same as var.guardians"
  value       = { for k, v in auth0_guardian.guardians : k => one(v.duo) }
  sensitive   = true
}
output "guardians_email" {
  description = "Map of email values across all guardians, keyed the same as var.guardians"
  value       = { for k, v in auth0_guardian.guardians : k => v.email }
}
output "guardians_email_settings" {
  description = "Map of email_settings values across all guardians, keyed the same as var.guardians"
  value       = { for k, v in auth0_guardian.guardians : k => one(v.email_settings) }
}
output "guardians_otp" {
  description = "Map of otp values across all guardians, keyed the same as var.guardians"
  value       = { for k, v in auth0_guardian.guardians : k => v.otp }
}
output "guardians_phone" {
  description = "Map of phone values across all guardians, keyed the same as var.guardians"
  value       = { for k, v in auth0_guardian.guardians : k => one(v.phone) }
  sensitive   = true
}
output "guardians_phone_settings" {
  description = "Map of phone_settings values across all guardians, keyed the same as var.guardians"
  value       = { for k, v in auth0_guardian.guardians : k => one(v.phone_settings) }
}
output "guardians_policy" {
  description = "Map of policy values across all guardians, keyed the same as var.guardians"
  value       = { for k, v in auth0_guardian.guardians : k => v.policy }
}
output "guardians_push" {
  description = "Map of push values across all guardians, keyed the same as var.guardians"
  value       = { for k, v in auth0_guardian.guardians : k => one(v.push) }
  sensitive   = true
}
output "guardians_recovery_code" {
  description = "Map of recovery_code values across all guardians, keyed the same as var.guardians"
  value       = { for k, v in auth0_guardian.guardians : k => v.recovery_code }
}
output "guardians_settings" {
  description = "Map of settings values across all guardians, keyed the same as var.guardians"
  value       = { for k, v in auth0_guardian.guardians : k => one(v.settings) }
}
output "guardians_webauthn_platform" {
  description = "Map of webauthn_platform values across all guardians, keyed the same as var.guardians"
  value       = { for k, v in auth0_guardian.guardians : k => one(v.webauthn_platform) }
}
output "guardians_webauthn_roaming" {
  description = "Map of webauthn_roaming values across all guardians, keyed the same as var.guardians"
  value       = { for k, v in auth0_guardian.guardians : k => one(v.webauthn_roaming) }
}

