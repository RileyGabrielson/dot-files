---
name: create-issue
description: Create a GitHub issue in the current repo. Use when the user asks to create a single issue, log a bug, or add a task to GitHub.
argument-hint: [issue title or description]
---

Create a GitHub issue for the current repo.

## Steps

1. Counsel with the user about the boundaries of the issue. Clarify parts that are not clear, architectural boundaries that are not well defined, etc.
2. Draft the issue content using the implementation issue template from the global standards (context, acceptance criteria, scope boundaries, relevant files, dependencies).
3. Use the Write tool to write the body to `.issue-temp.md` in the repo root.
4. Run `gh issue create --title "<title>" --body-file .issue-temp.md --assignee @me`.
5. Delete the temp file with the Bash tool.

@~/.claude/issues_and_prs.md
