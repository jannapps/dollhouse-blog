# Claude Code Configuration

## Local CI Process

Before pushing any changes to GitHub, always run the complete CI suite locally to prevent CI failures:

```bash
# Run complete CI suite in correct order
nix-shell --run "bin/brakeman" && \
nix-shell --run "bin/bundler-audit check --update" && \
nix-shell --run "bin/rubocop -a" && \
nix-shell --run "bin/rails test"
```

### CI Tools Used:
- **Brakeman**: Security vulnerability scanner
- **bundler-audit**: Checks for known security vulnerabilities in gems
- **RuboCop**: Code style and linting (with auto-fix `-a` flag)
- **Rails tests**: Application test suite

### Important Notes:
1. **Always run CI locally before pushing** - This prevents broken builds in the remote CI
2. **Use auto-fix for RuboCop** - Run `bin/rubocop -a` to automatically fix style issues
3. **Security first** - Brakeman must show 0 warnings before merging
4. **Git workflow** - Use feature branches and squash merge to main

## Security Guidelines

### File Access Security
- Never use user parameters directly in file operations
- Use whitelist-based file access with pre-approved mappings
- Implement strict input validation (alphanumeric, dash, underscore only)
- Always validate file paths are within expected directories

### Example Secure File Access Pattern:
```ruby
def safe_file_access(user_input)
  # 1. Validate input format
  return nil unless user_input.match?(/\A[a-zA-Z0-9\-_]+\z/)
  
  # 2. Use whitelist mapping
  file_path = allowed_files[user_input]
  return nil unless file_path
  
  # 3. Read from pre-approved path only
  File.read(file_path)
end
```

## Development Environment

This project uses NixOS with shell.nix for reproducible development environment:

- Ruby 3.2.9
- Rails 8.1.1  
- Bundler 2.5.6
- Server runs on http://localhost:9955