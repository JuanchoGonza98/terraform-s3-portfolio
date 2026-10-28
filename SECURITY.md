# Security Decisions

## Scope

Portfolio lab for hosting public static website assets.
Credentials and confidential information must not be stored here.

## Controls Defined in Terraform

- Block direct public access to S3.
- Deny HTTP requests through a bucket policy.
- Use SSE-S3 encryption.
- Enable object versioning.
- Expire noncurrent object versions after 7 days.

## Accepted Findings for the Initial Lab

These findings remain visible in Trivy. Documenting them does not
remediate them or indicate that all security checks pass.

### AWS-0132: Customer-Managed KMS Key

This lab uses SSE-S3 instead of a customer-managed KMS key.
Independent control over encryption keys is not required for
the public website assets in this scope.

Review this decision if data sensitivity or security requirements change.

### AWS-0089: S3 Server Access Logging

S3 server access logging is not enabled in the initial lab.
Reduced access auditability is accepted to keep the scope small
and avoid additional log storage.

Review this decision before production use.

## Deployment Status

The controls above are defined in code.
Deployment and verification in AWS are pending.
### AWS-0011: CloudFront Without AWS WAF

AWS WAF is not enabled for the initial static portfolio lab.
The distribution exposes public assets and allows GET and HEAD only.

Application-layer request filtering is not provided.
Review this decision before adding authentication, APIs, forms,
or workloads requiring stronger protection against abusive traffic.

### AWS-0010: CloudFront Access Logging

CloudFront access logging is not enabled in the initial lab.
Reduced request auditability is accepted to limit scope and
additional log storage.

Review this decision before production use or when troubleshooting
requires request-level access records.