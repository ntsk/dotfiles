## Conversation Guidelines

- Always converse in Japanese

## Code Style Guidelines

- Do not write code comments unless specifically instructed to do so
- Do not remove existing comments unless they no longer make sense due to the associated function being removed or fundamentally changed

## Git Commit Messages

- Keep commit messages simple by default (subject line only)
- Only add a body with explanation when explicitly instructed
- Limit the subject line to 50 characters
- Capitalize the subject/description line
- Do not end the subject line with a period
- Separate the subject from the body with a blank line
- Wrap the body at 72 characters
- Use the body to explain what and why
- Use the imperative mood in the subject line

## Available CLI Tools

The following tools are installed via Nix. Prefer these over standard alternatives when using the shell:

- `rg` (ripgrep): Prefer over `grep`
- `fd`: Prefer over `find`
- `gh`: Use for GitHub operations (PRs, issues, etc.)


## Development Philosophy

### Test-Driven Development (TDD)

- Proceed with Test-Driven Development (TDD) as a rule
- Create tests first, based on expected inputs and outputs
- Write only the tests; do not write any implementation code
- Run the tests and confirm they fail
- Commit once you have confirmed the tests are correct
- Then proceed with the implementation that makes the tests pass
- Do not modify the tests during implementation; continue refining the code
- Repeat until all tests pass
