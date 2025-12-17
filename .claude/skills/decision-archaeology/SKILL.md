---
name: decision-archaeology
description: Investigate why code was written a certain way. Use when tracing decision history through git blame, commit logs, PRs, and issues to understand the reasoning behind code changes.
allowed-tools:
  - Bash(git log:*)
  - Bash(git show:*)
  - Bash(git blame:*)
  - Bash(git diff:*)
  - Bash(gh pr list:*)
  - Bash(gh pr view:*)
  - Bash(gh issue list:*)
  - Bash(gh issue view:*)
  - Bash(gh search:*)
  - Bash(gh api:*)
  - Read
  - Grep
  - Glob
---

# Decision Archaeology Skill

Investigate the reasoning behind code decisions by tracing git history, PRs, and issues.

## Important Rules

### Read-Only Operations
This skill only allows read-only operations.

For `gh api`: Use GET requests only. Do not use `-X POST/PUT/PATCH/DELETE` or `-f`/`-F` flags.

## Workflow

1. Identify the code in question
2. Find the commit that introduced/modified it
3. Trace back to the PR and/or issue
4. Summarize the decision rationale

## 1. Investigate Code History

### Find Who Changed a Line

```bash
git blame <file>
git blame -L <start>,<end> <file>
git blame -L :<function_name> <file>
```

### View File History

```bash
git log --oneline <file>
git log --oneline -p <file>
git log --follow <file>
```

### Search Commits by Message

```bash
git log --oneline --grep="keyword"
git log --oneline --grep="fix" --grep="bug" --all-match
```

### Search Commits by Code Change

```bash
git log -S "code_snippet" --oneline
git log -G "regex_pattern" --oneline
```

## 2. Examine Commits

### View Commit Details

```bash
git show <commit>
git show <commit> --stat
git show <commit> -- <file>
```

### Compare Changes

```bash
git diff <commit1>..<commit2> -- <file>
git diff <commit>^ <commit> -- <file>
```

## 3. Find Related PRs

### Search PRs by Commit

```bash
gh pr list --search "<commit-sha>" --state all
gh api /search/issues --jq '.items[] | {number, title, html_url}' -f q="<commit-sha> type:pr repo:{owner}/{repo}"
```

### Search PRs by Keyword

```bash
gh pr list --search "keyword" --state all
gh pr view <number>
gh pr view <number> --json body,comments,reviews
```

### View PR Discussion

```bash
gh pr view <number> --comments
gh api repos/{owner}/{repo}/pulls/<number>/comments --jq '.[] | {user: .user.login, body}'
```

## 4. Find Related Issues

### Search Issues

```bash
gh issue list --search "keyword" --state all
gh issue view <number>
gh issue view <number> --comments
```

### Find Issues Referenced in Commit

Look for patterns in commit messages:
- `#123`, `fixes #123`, `closes #123`
- Issue URLs

```bash
git show <commit> --format="%B" --no-patch
```

## 5. Output Investigation Findings

### Investigation Report Format

```
## Decision Archaeology Report

### Target
- File: [path/to/file]
- Lines: [XX-YY]
- Code: [brief description]

### Timeline

#### [Date] Commit: [short-sha]
- Author: [name]
- Message: [commit message]
- PR: #[number] [title]
- Related Issue: #[number] [title]

#### [Earlier Date] ...

### Decision Rationale
[Summary of why this decision was made, based on PR discussions, issue context, and commit messages]

### Key References
- PR #[number]: [URL]
- Issue #[number]: [URL]
- Commit: [sha]
```

## Tips

- Start with `git blame` to find the introducing commit
- Use `git log -S` to find when specific code was added/removed
- Check commit message for issue/PR references (`#123`)
- PR descriptions and review comments often contain the "why"
- Issue discussions may have original context and requirements
