#!/usr/bin/env bash
# Convert AWS Secret Access Key to an Amazon SES SMTP password
# using the following pseudocode:
#
#   key = AWS Secret Access Key;
#   message = "SendRawEmail";
#   versionInBytes = 0x02;
#   signatureInBytes = HmacSha256(message, key);
#   signatureAndVer = Concatenate(versionInBytes, signatureInBytes);
#   smtpPassword = Base64(signatureAndVer);
#
# Usage:
#   chmod u+x aws-ses-smtp-password.sh
#   ./aws-ses-smtp-password.sh secret-key-here
# See: http://docs.aws.amazon.com/ses/latest/DeveloperGuide/smtp-credentials.html
#

if [ "$#" -ne 1 ]; then
  echo "Usage: ./aws-ses-smtp-password.sh secret-key-here"
  exit 1
fi

KEY="${1}"
MESSAGE="SendRawEmail"
VERSION_IN_BYTES=$(printf \\$(printf '%03o' "2"));
SIGNATURE_IN_BYTES=$(echo -n "${MESSAGE}" | openssl dgst -sha256 -hmac "${KEY}" -binary);
SIGNATURE_AND_VERSION="${VERSION_IN_BYTES}${SIGNATURE_IN_BYTES}"
SMTP_PASSWORD=$(echo -n "${SIGNATURE_AND_VERSION}" | base64);

echo "${SMTP_PASSWORD}"
