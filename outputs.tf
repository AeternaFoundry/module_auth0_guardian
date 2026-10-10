output "guardians_id" {
  description = "Map of id values across all guardians, keyed the same as var.guardians except keys with no id are omitted"
  value       = { for k, v in auth0_guardian.guardians : k => v.id if v.id != null && length(v.id) > 0 }
}
output "guardians_duo" {
  description = "Map of duo values across all guardians, keyed the same as var.guardians except keys with no duo are omitted"
  value       = { for k, v in auth0_guardian.guardians : k => one(v.duo) if v.duo != null && length(v.duo) > 0 }
  sensitive   = true
}
output "guardians_email" {
  description = "Map of email values across all guardians, keyed the same as var.guardians except keys with no email are omitted"
  value       = { for k, v in auth0_guardian.guardians : k => v.email if v.email != null }
}
output "guardians_email_settings" {
  description = "Map of email_settings values across all guardians, keyed the same as var.guardians except keys with no email_settings are omitted"
  value       = { for k, v in auth0_guardian.guardians : k => one(v.email_settings) if v.email_settings != null && length(v.email_settings) > 0 }
}
output "guardians_otp" {
  description = "Map of otp values across all guardians, keyed the same as var.guardians except keys with no otp are omitted"
  value       = { for k, v in auth0_guardian.guardians : k => v.otp if v.otp != null }
}
output "guardians_phone" {
  description = "Map of phone values across all guardians, keyed the same as var.guardians except keys with no phone are omitted"
  value       = { for k, v in auth0_guardian.guardians : k => one(v.phone) if v.phone != null && length(v.phone) > 0 }
  sensitive   = true
}
output "guardians_phone_settings" {
  description = "Map of phone_settings values across all guardians, keyed the same as var.guardians except keys with no phone_settings are omitted"
  value       = { for k, v in auth0_guardian.guardians : k => one(v.phone_settings) if v.phone_settings != null && length(v.phone_settings) > 0 }
}
output "guardians_policy" {
  description = "Map of policy values across all guardians, keyed the same as var.guardians except keys with no policy are omitted"
  value       = { for k, v in auth0_guardian.guardians : k => v.policy if v.policy != null && length(v.policy) > 0 }
}
output "guardians_push" {
  description = "Map of push values across all guardians, keyed the same as var.guardians except keys with no push are omitted"
  value       = { for k, v in auth0_guardian.guardians : k => one(v.push) if v.push != null && length(v.push) > 0 }
  sensitive   = true
}
output "guardians_recovery_code" {
  description = "Map of recovery_code values across all guardians, keyed the same as var.guardians except keys with no recovery_code are omitted"
  value       = { for k, v in auth0_guardian.guardians : k => v.recovery_code if v.recovery_code != null }
}
output "guardians_settings" {
  description = "Map of settings values across all guardians, keyed the same as var.guardians except keys with no settings are omitted"
  value       = { for k, v in auth0_guardian.guardians : k => one(v.settings) if v.settings != null && length(v.settings) > 0 }
}
output "guardians_webauthn_platform" {
  description = "Map of webauthn_platform values across all guardians, keyed the same as var.guardians except keys with no webauthn_platform are omitted"
  value       = { for k, v in auth0_guardian.guardians : k => one(v.webauthn_platform) if v.webauthn_platform != null && length(v.webauthn_platform) > 0 }
}
output "guardians_webauthn_roaming" {
  description = "Map of webauthn_roaming values across all guardians, keyed the same as var.guardians except keys with no webauthn_roaming are omitted"
  value       = { for k, v in auth0_guardian.guardians : k => one(v.webauthn_roaming) if v.webauthn_roaming != null && length(v.webauthn_roaming) > 0 }
}

