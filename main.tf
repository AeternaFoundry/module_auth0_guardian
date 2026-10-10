resource "auth0_guardian" "guardians" {
  for_each = var.guardians

  policy        = each.value.policy
  email         = each.value.email
  otp           = each.value.otp
  recovery_code = each.value.recovery_code

  dynamic "duo" {
    for_each = each.value.duo != null ? [each.value.duo] : []
    content {
      enabled         = duo.value.enabled
      hostname        = duo.value.hostname
      integration_key = duo.value.integration_key
      secret_key      = duo.value.secret_key
    }
  }

  dynamic "email_settings" {
    for_each = each.value.email_settings != null ? [each.value.email_settings] : []
    content {
      otp_expiration_time = email_settings.value.otp_expiration_time
      otp_length          = email_settings.value.otp_length
    }
  }

  dynamic "phone" {
    for_each = each.value.phone != null ? [each.value.phone] : []
    content {
      enabled       = phone.value.enabled
      message_types = phone.value.message_types
      dynamic "options" {
        for_each = phone.value.options != null ? [phone.value.options] : []
        content {
          auth_token            = options.value.auth_token
          enrollment_message    = options.value.enrollment_message
          from                  = options.value.from
          messaging_service_sid = options.value.messaging_service_sid
          sid                   = options.value.sid
          verification_message  = options.value.verification_message
        }
      }
      provider = phone.value.provider
    }
  }

  dynamic "phone_settings" {
    for_each = each.value.phone_settings != null ? [each.value.phone_settings] : []
    content {
      otp_expiration_time = phone_settings.value.otp_expiration_time
      otp_length          = phone_settings.value.otp_length
    }
  }

  dynamic "push" {
    for_each = each.value.push != null ? [each.value.push] : []
    content {
      dynamic "amazon_sns" {
        for_each = push.value.amazon_sns != null ? [push.value.amazon_sns] : []
        content {
          aws_access_key_id                 = amazon_sns.value.aws_access_key_id
          aws_region                        = amazon_sns.value.aws_region
          aws_secret_access_key             = amazon_sns.value.aws_secret_access_key
          sns_apns_platform_application_arn = amazon_sns.value.sns_apns_platform_application_arn
          sns_gcm_platform_application_arn  = amazon_sns.value.sns_gcm_platform_application_arn
        }
      }
      dynamic "custom_app" {
        for_each = push.value.custom_app != null ? [push.value.custom_app] : []
        content {
          app_name        = custom_app.value.app_name
          apple_app_link  = custom_app.value.apple_app_link
          google_app_link = custom_app.value.google_app_link
        }
      }
      dynamic "direct_apns" {
        for_each = push.value.direct_apns != null ? [push.value.direct_apns] : []
        content {
          bundle_id = direct_apns.value.bundle_id
          enabled   = direct_apns.value.enabled
          p12       = direct_apns.value.p12
          sandbox   = direct_apns.value.sandbox
        }
      }
      dynamic "direct_fcm" {
        for_each = push.value.direct_fcm != null ? [push.value.direct_fcm] : []
        content {
          server_key = direct_fcm.value.server_key
        }
      }
      enabled  = push.value.enabled
      provider = push.value.provider
    }
  }

  dynamic "settings" {
    for_each = each.value.settings != null ? [each.value.settings] : []
    content {
      display_remember_me_checkbox   = settings.value.display_remember_me_checkbox
      mfa_session_inactivity_timeout = settings.value.mfa_session_inactivity_timeout
      mfa_session_overall_timeout    = settings.value.mfa_session_overall_timeout
      remember_me_default_value      = settings.value.remember_me_default_value
    }
  }

  dynamic "webauthn_platform" {
    for_each = each.value.webauthn_platform != null ? [each.value.webauthn_platform] : []
    content {
      enabled                  = webauthn_platform.value.enabled
      override_relying_party   = webauthn_platform.value.override_relying_party
      relying_party_identifier = webauthn_platform.value.relying_party_identifier
    }
  }

  dynamic "webauthn_roaming" {
    for_each = each.value.webauthn_roaming != null ? [each.value.webauthn_roaming] : []
    content {
      enabled                  = webauthn_roaming.value.enabled
      override_relying_party   = webauthn_roaming.value.override_relying_party
      relying_party_identifier = webauthn_roaming.value.relying_party_identifier
      user_verification        = webauthn_roaming.value.user_verification
    }
  }
}

