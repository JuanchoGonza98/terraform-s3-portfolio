# Security Decisions

## Scope

Portfolio lab for public static website assets. Credentials and confidential information must not be stored in the website or repository. This is not a production security baseline.

## Implemented Controls

- S3 public access is blocked.
- CloudFront accesses the private S3 REST origin through Origin Access Control (OAC).
- The website bucket policy restricts CloudFront read access to the intended distribution ARN and denies insecure transport.
- Viewer HTTP requests are redirected to HTTPS by CloudFront.
- S3 objects use SSE-S3 encryption at rest.
- Website versioning is enabled. Noncurrent version retention is 7 days in DEV and 14 days in HML.
- Application states use separate keys in a private, versioned, encrypted S3 backend with native state locking configured.
- GitHub Actions obtains temporary AWS credentials through OIDC. No permanent AWS access keys are stored in the workflow.
- The role trust restricts the audience and exact repository/branch subject, including immutable owner and repository IDs.
- The deployment role is scoped to existing DEV resources; it is not a general-purpose provisioning or teardown role.
- Apply is opt-in through a manual workflow input. The saved plan is applied within the same run.

## Verification and Its Limits

The deployed DEV site returned HTTP 200 through CloudFront and HTTP 403 for direct anonymous access to the S3 object. GitHub Actions completed planning, a no-change apply, and a subsequent website content update.

These are recorded tests, not continuous monitoring or a complete security assessment. A direct anonymous 403 alone does not prove that every possible access path is secure.

The workflow enforces formatting and Terraform validation. TFLint, Trivy, and Infracost were executed locally; they are not automated security gates. The temporary OIDC diagnostic step is removed from the final workflow.

## Accepted Findings

Documenting these findings does not remediate them or mean all security checks pass. Findings remain visible rather than being globally suppressed.

### AWS-0132: Customer-Managed KMS Key

The website uses SSE-S3 instead of a customer-managed KMS key. Independent key administration is not required for the public static assets in this lab. This does not provide customer-managed key policies, rotation control, or KMS-specific audit evidence.

Review this decision if data sensitivity or key-management requirements change.

### AWS-0089: S3 Server Access Logging

S3 server access logging is not enabled. Reduced request auditability is accepted to keep scope and log storage limited.

Review before production use or when request-level access records are required. Bootstrap is a separate Terraform configuration and should be assessed independently when modified.

### AWS-0011: CloudFront Without AWS WAF

AWS WAF is not enabled. The distribution serves public static assets and permits GET and HEAD only. This does not eliminate abusive traffic or request-related cost risk, and application-layer filtering is not provided.

Review before adding authentication, APIs, forms, or workloads requiring stronger traffic controls.

### AWS-0010: CloudFront Access Logging

CloudFront access logging is not enabled. Reduced request auditability is accepted to limit scope and storage.

Review before production use or when troubleshooting requires request-level access records.

## Repository and Credential Handling

- Never commit AWS secret keys, session credentials, GitHub personal access tokens, SSH private keys, `.env` secrets, Terraform state, or saved plans.
- Account IDs, public repository IDs, and role ARNs are identifiers rather than authentication secrets.
- Protect GitHub write access, use account 2FA, and review workflow changes. Code executed in an authorized workflow can exercise the role's permissions.
- A manual apply checkbox authorizes apply for that run. It is not a separate approval pause after the plan.
- Changes to the workflow's GitHub environment, branch, or repository identity require reviewing the OIDC trust subject.
- The bootstrap local state needs its own access-controlled backup outside Git.
- `.gitignore` protects against accidental tracking; it does not remove secrets already committed or replace a repository history review.

## Operational Boundaries

HML has separate S3 resources and state. Its recorded deployment predates the CloudFront addition to the shared root configuration; an HML plan may now propose CloudFront resources. Review the scope before any HML apply.

A budget alert is not an enforceable spending cap. Keep monitoring actual AWS usage, retained versions, and optional invalidations.

Preserve the backend bucket until all dependent environment states and resources have been safely handled. Do not use state deletion as a teardown method.

## Reporting

If a credential is exposed, revoke it promptly and review its use. Do not include secret values in public issues. Contact the repository owner through an available private channel for sensitive reports.
