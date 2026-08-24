# Security rules - applies to all files
# No path filter = loads everywhere

- Never commit secrets, tokens, API keys, or passwords.
- If you encounter a .env file, do not read it. Reference it by name only.
- Validate all user inputs at function boundaries.
- Use parameterized queries. Never string-concatenate SQL.
- Hash passwords with bcrypt or argon2. Never store plaintext.
- Sanitize all output to prevent XSS.
- Check authorization before every data access.
