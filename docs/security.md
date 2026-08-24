# Security guidelines

## Authentication & authorization
- Use OAuth2/OIDC for user authentication.
- Implement role-based access control (RBAC).
- Validate permissions on every request.

## Input validation
- Validate and sanitize all user inputs.
- Use allowlists over denylists.
- Use prepared statements to prevent SQL injection.

## Secrets management
- Never hardcode secrets in code.
- Use environment variables or vaults.
- Rotate secrets regularly.

## Dependency vulnerabilities
- Regularly scan dependencies for CVEs.
- Use tools like `cargo-audit`, `npm audit`, `safety`.
- Apply security patches promptly.

## Logging & monitoring
- Log security-relevant events (login, access changes).
- Monitor for suspicious activity.

## Data protection
- Encrypt sensitive data at rest and in transit.
- Use TLS for all external communications.
- Follow GDPR/CCPA for personal data.

## Secure development practices

Never:
- trust client-side validation
- expose internal stack traces externally
- store secrets in repositories
- disable security checks to simplify development

Use:
- Perform threat modeling for sensitive features.
- Apply least privilege access.
- Use secure defaults.

## Security review trigger

Security review is required when modifying:
- authentication
- authorization
- cryptography
- file handling
- network boundaries
- user input processing
- secrets handling