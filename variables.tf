variable "guardians" {
  description = <<EOT
Map of guardians, attributes below
Required:
    - policy
Optional:
    - email
    - otp
    - recovery_code
    - duo (block):
        - enabled (required)
        - hostname (optional)
        - integration_key (optional)
        - secret_key (optional)
    - email_settings (block):
        - otp_expiration_time (required)
        - otp_length (required)
    - phone (block):
        - enabled (required)
        - message_types (optional)
        - options (optional, block):
            - auth_token (optional)
            - enrollment_message (optional)
            - from (optional)
            - messaging_service_sid (optional)
            - sid (optional)
            - verification_message (optional)
        - provider (optional)
    - phone_settings (block):
        - otp_expiration_time (required)
        - otp_length (required)
    - push (block):
        - amazon_sns (optional, block):
            - aws_access_key_id (required)
            - aws_region (required)
            - aws_secret_access_key (required)
            - sns_apns_platform_application_arn (required)
            - sns_gcm_platform_application_arn (required)
        - custom_app (optional, block):
            - app_name (optional)
            - apple_app_link (optional)
            - google_app_link (optional)
        - direct_apns (optional, block):
            - bundle_id (required)
            - enabled (optional)
            - p12 (required)
            - sandbox (required)
        - direct_fcm (optional, block):
            - server_key (required)
        - enabled (required)
        - provider (optional)
    - settings (block):
        - display_remember_me_checkbox (required)
        - mfa_session_inactivity_timeout (required)
        - mfa_session_overall_timeout (required)
        - remember_me_default_value (required)
    - webauthn_platform (block):
        - enabled (required)
        - override_relying_party (optional)
        - relying_party_identifier (optional)
    - webauthn_roaming (block):
        - enabled (required)
        - override_relying_party (optional)
        - relying_party_identifier (optional)
        - user_verification (optional)
EOT

  type = map(object({
    policy        = string
    email         = optional(bool)
    otp           = optional(bool)
    recovery_code = optional(bool)
    duo = optional(object({
      enabled         = bool
      hostname        = optional(string)
      integration_key = optional(string)
      secret_key      = optional(string)
    }))
    email_settings = optional(object({
      otp_expiration_time = number
      otp_length          = number
    }))
    phone = optional(object({
      enabled       = bool
      message_types = optional(list(string))
      options = optional(object({
        auth_token            = optional(string)
        enrollment_message    = optional(string)
        from                  = optional(string)
        messaging_service_sid = optional(string)
        sid                   = optional(string)
        verification_message  = optional(string)
      }))
      provider = optional(string)
    }))
    phone_settings = optional(object({
      otp_expiration_time = number
      otp_length          = number
    }))
    push = optional(object({
      amazon_sns = optional(object({
        aws_access_key_id                 = string
        aws_region                        = string
        aws_secret_access_key             = string
        sns_apns_platform_application_arn = string
        sns_gcm_platform_application_arn  = string
      }))
      custom_app = optional(object({
        app_name        = optional(string)
        apple_app_link  = optional(string)
        google_app_link = optional(string)
      }))
      direct_apns = optional(object({
        bundle_id = string
        enabled   = optional(bool)
        p12       = string
        sandbox   = bool
      }))
      direct_fcm = optional(object({
        server_key = string
      }))
      enabled  = bool
      provider = optional(string)
    }))
    settings = optional(object({
      display_remember_me_checkbox   = bool
      mfa_session_inactivity_timeout = number
      mfa_session_overall_timeout    = number
      remember_me_default_value      = bool
    }))
    webauthn_platform = optional(object({
      enabled                  = bool
      override_relying_party   = optional(bool)
      relying_party_identifier = optional(string)
    }))
    webauthn_roaming = optional(object({
      enabled                  = bool
      override_relying_party   = optional(bool)
      relying_party_identifier = optional(string)
      user_verification        = optional(string)
    }))
  }))
  validation {
    condition = alltrue([
      for k, v in var.guardians : (
        contains(["all-applications", "confidence-score", "never"], v.policy)
      )
    ])
    error_message = "must be one of: \"all-applications\", \"confidence-score\", \"never\""
  }
  validation {
    condition = alltrue([
      for k, v in var.guardians : (
        v.settings == null || (v.settings.mfa_session_inactivity_timeout >= 3600 && v.settings.mfa_session_inactivity_timeout <= 2592000)
      )
    ])
    error_message = "must be between 3600 and 2592000"
  }
  validation {
    condition = alltrue([
      for k, v in var.guardians : (
        v.settings == null || (v.settings.mfa_session_overall_timeout >= 3600 && v.settings.mfa_session_overall_timeout <= 7776000)
      )
    ])
    error_message = "must be between 3600 and 7776000"
  }
  validation {
    condition = alltrue([
      for k, v in var.guardians : (
        v.webauthn_roaming == null || (v.webauthn_roaming.user_verification == null || (contains(["discouraged", "preferred", "required"], v.webauthn_roaming.user_verification)))
      )
    ])
    error_message = "must be one of: \"discouraged\", \"preferred\", \"required\""
  }
  validation {
    condition = alltrue([
      for k, v in var.guardians : (
        v.phone == null || (v.phone.provider == null || (contains(["auth0", "twilio", "phone-message-hook"], v.phone.provider)))
      )
    ])
    error_message = "must be one of: \"auth0\", \"twilio\", \"phone-message-hook\""
  }
  validation {
    condition = alltrue([
      for k, v in var.guardians : (
        v.push == null || (v.push.provider == null || (contains(["direct", "guardian", "sns"], v.push.provider)))
      )
    ])
    error_message = "must be one of: \"direct\", \"guardian\", \"sns\""
  }
  # Note: 2 additional provider-side validators are enforced at apply time but not mirrored as validation{} blocks here (bespoke or non-mechanically-translatable).
}

