---
name: code-review
description: Code review workflow using GitHub CLI. Use when reviewing pull requests, checking PR diffs, adding review comments, or approving/requesting changes on PRs.
allowed-tools:
  - Bash(gh pr list:*)
  - Bash(gh pr view:*)
  - Bash(gh pr diff:*)
  - Bash(gh pr checks:*)
  - Bash(gh pr checkout:*)
  - Bash(gh issue list:*)
  - Bash(gh issue view:*)
  - Bash(gh run list:*)
  - Bash(gh run view:*)
  - Bash(gh api:*)
  - Read
  - Grep
  - Glob
---

# Code Review Skill

Efficient workflow for reviewing Pull Requests using GitHub CLI.

## Important Rules

### Read-Only Operations
This skill only allows read-only GitHub operations.
Write operations require explicit user instruction outside this skill.

For `gh api`: Use GET requests only. Do not use `-X POST/PUT/PATCH/DELETE` or `-f`/`-F` flags.

### Citation Required for All Issues
- Every issue raised MUST reference official documentation
- Include URL or specific section from official docs
- If no documentation supports the issue, do not raise it
- Format: `[Issue description] (Reference: [URL or doc name])`

## 1. Get PR Overview

### List PRs

```bash
gh pr list
gh pr list --author <username>
gh pr list --label "needs-review"
```

### View PR Details

```bash
gh pr view <number>
gh pr view <number> --json title,body,author,baseRefName,headRefName,commits,files
```

## 2. Review Changes

### View Diff

```bash
gh pr diff <number>
```

### List Changed Files

```bash
gh pr view <number> --json files --jq '.files[].path'
```

### View Specific File Changes

```bash
gh pr diff <number> -- <filepath>
```

### View Commit History

```bash
gh pr view <number> --json commits --jq '.commits[] | "\(.oid[:7]) \(.messageHeadline)"'
```

## 3. Impact Analysis (REQUIRED)

When reviewing changes to functions, methods, or interfaces, you MUST investigate the impact on callers.

### Workflow

1. Identify modified functions/methods from the diff
2. Search for all callers in the codebase
3. Verify callers are compatible with the changes
4. Report any breaking changes or required updates

### Search for Callers

```bash
# Search for function/method references
rg "functionName" --type <lang>
rg "\.methodName\(" --type <lang>

# Search with context
rg "functionName" -C 3 --type <lang>

# Search in specific directories
rg "functionName" src/ lib/
```

### Common Patterns to Check

- Function signature changes (parameters added/removed/reordered)
- Return type changes
- Renamed functions/methods
- Changed class/interface definitions
- Modified public API contracts

### Impact Report

When changes affect function signatures, include in review:
- List of all callers found
- Whether each caller needs updates
- Any potential breaking changes

## 4. Check CI Status

```bash
gh pr checks <number>
gh pr checks <number> --watch
```

### View Failed CI Logs

```bash
gh run view <run-id> --log-failed
```

## 5. Review Code Locally

### Checkout PR Branch

```bash
gh pr checkout <number>
```

## 6. Output Review Findings

### Review Output Format

```
## Review Summary

### Issues Found

#### [File: path/to/file.ext, Line: XX]
**Issue**: [Description of the issue]
**Reference**: [Official documentation URL or section]
**Suggestion**: [How to fix]

#### [File: path/to/file.ext, Line: YY]
**Issue**: [Description of the issue]
**Reference**: [Official documentation URL or section]
**Suggestion**: [How to fix]

### Impact Analysis
- [List of affected callers and compatibility status]

### Recommendation
- [ ] Approve
- [ ] Request Changes
- [ ] Comment Only

### Notes
[Any additional observations]
```

## 7. View Existing Review Comments

```bash
gh api repos/{owner}/{repo}/pulls/<number>/comments --jq '.[] | {path, line, body}'
gh pr view <number> --json reviews --jq '.reviews[] | {author: .author.login, state: .state, body}'
```

## Review Checklist

### Code Quality
- [ ] Changes align with the purpose
- [ ] Logic is correct
- [ ] Edge cases are handled
- [ ] No duplicate code

### Impact Analysis
- [ ] All callers of modified functions identified
- [ ] Callers verified compatible with changes
- [ ] No breaking changes to public APIs

### Security
- [ ] Input validation
- [ ] Authentication/authorization checks
- [ ] No hardcoded secrets

### Testing
- [ ] Tests are added/updated
- [ ] Tests cover appropriate cases
- [ ] CI is passing

### Documentation
- [ ] Documentation updated if needed
- [ ] Commit messages are appropriate

## Tips

- Combine `--json` with `--jq` to extract specific information
- Use `gh pr checkout` for local review, `gh pr diff` for terminal review
- For large PRs, review file by file with `gh pr diff -- <file>`
